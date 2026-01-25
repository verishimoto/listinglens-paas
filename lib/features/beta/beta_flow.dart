import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'beta_time_stream.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import '../../core/services/credit_service.dart';
import '../../shared/paywall_modal.dart';

import '../../core/data/analysis_result.dart';
import '../../shared/smooth_cursor.dart';
import '../../core/providers/analysis_provider.dart';

class BetaFlow extends ConsumerStatefulWidget {
  const BetaFlow({super.key});

  @override
  ConsumerState<BetaFlow> createState() => _BetaFlowState();
}

class _BetaFlowState extends ConsumerState<BetaFlow> {
  int _step = 0; // 0: Idle, 1: Infusing (Loading), 2: Clarified (Result)
  AnalysisResult? _lastResult;

  void _showCinematicNav(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Nav",
      pageBuilder: (_, __, ___) => const _CinematicNavOverlay(),
      transitionBuilder: (_, anim, __, child) {
        return FadeTransition(opacity: anim, child: child);
      },
    );
  }

  Future<void> _handleBeginAnalysis() async {
    final creditService = ref.read(creditServiceProvider.notifier);
    final hasCredits = ref.read(creditServiceProvider) > 0;

    if (!hasCredits) {
      showDialog(
        context: context,
        builder: (_) => const PaywallModal(),
      );
      return;
    }

    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() => _step = 1); // Phase: Infusion

    try {
      final service = ref.read(analysisServiceProvider);
      final result = await service.analyzeListingImage(image);

      await Future.delayed(const Duration(seconds: 1)); // Cinematic wait

      if (mounted) {
        creditService.consumeCredit();
        setState(() {
          _lastResult = result;
          _step = 2; // Phase: Clarification
        });
      }
    } catch (e) {
      setState(() => _step = 0);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Liquid Intelligence Failed.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmoothCursor(
      cursorColor: Colors.cyanAccent,
      smoothing: 0.08,
      child: Scaffold(
        backgroundColor: const Color(0xFF09090b),
        body: Stack(
          children: [
            // Ambient Background
            const Positioned(
              top: -100,
              left: -100,
              child: _GlowOrb(color: Colors.purple, size: 400),
            ),
            const Positioned(
              bottom: -50,
              right: -50,
              child: _GlowOrb(color: Colors.cyan, size: 300),
            ),

            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                child: _buildStepContent(),
              ),
            ),

            // Nav Trigger
            Positioned(
              top: 24,
              right: 24,
              child: IconButton(
                onPressed: () => _showCinematicNav(context),
                icon: const Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 1: // Infusion
        return Column(
          key: const ValueKey(1),
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: Colors.cyan),
            const SizedBox(height: 40),
            Text(
              'INFUSING INTELLIGENCE',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                letterSpacing: 4,
                fontFamily: 'Agency FB',
              ),
            ),
          ],
        );
      case 2: // Clarification
        return _buildClarification();
      default: // Absorption (Idle)
        return _buildAbsorption();
    }
  }

  Widget _buildAbsorption() {
    return Container(
      key: const ValueKey(0),
      width: 500,
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          const Spacer(),
          const Icon(Icons.auto_awesome, size: 60, color: Colors.white),
          const SizedBox(height: 30),
          const Text(
            'LIQUID OPAL',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          _GlassButton(
            label: "BEGIN ABSORPTION",
            onTap: _handleBeginAnalysis,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildClarification() {
    final result = _lastResult!;
    return Container(
      key: const ValueKey(2),
      width: 500,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${result.overallScore}',
              style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 80,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text(result.summary,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          const SizedBox(height: 40),
          _GlassButton(
              label: "DISSOLVE", onTap: () => setState(() => _step = 0)),
        ],
      ),
    );
  }
}

class _CinematicNavOverlay extends StatelessWidget {
  const _CinematicNavOverlay();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.9),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _NavText("HOME"),
            const _NavText("LISTINGS"),
            const _NavText("ANALYTICS"),
            const _NavText("SETTINGS"),
            _GlassButton(
              label: "RECALL",
              onTap: () {
                Navigator.pop(context);
                showGeneralDialog(
                  context: context,
                  pageBuilder: (_, __, ___) => const BetaTimeStream(),
                );
              },
            ),
            const SizedBox(height: 40),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white54),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}

class _NavText extends StatelessWidget {
  final String text;
  const _NavText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          letterSpacing: 8,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.5),
            blurRadius: 100,
            spreadRadius: 50,
          ),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _GlassButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.withValues(alpha: 0.3),
              Colors.cyan.withValues(alpha: 0.3)
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
