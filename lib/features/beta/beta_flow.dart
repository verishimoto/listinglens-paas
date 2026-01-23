import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import '../../core/services/credit_service.dart';
import '../../shared/paywall_modal.dart';
import '../../core/services/analysis_service.dart';
import '../../core/data/analysis_result.dart';

class BetaFlow extends ConsumerWidget {
  const BetaFlow({super.key});

  Future<void> _handleBeginAnalysis(BuildContext context, WidgetRef ref) async {
    final creditService = ref.read(creditServiceProvider.notifier);
    final hasCredits = ref.read(creditServiceProvider) > 0;

    if (!hasCredits) {
      showDialog(
        context: context,
        builder: (_) => const PaywallModal(),
      );
      return;
    }

    // 1. Pick Image
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    // Show Loading
    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          ),
        ),
      );
    }

    try {
      final service = AnalysisService();
      final result = await service.analyzeListingImage(image);

      if (context.mounted) {
        Navigator.pop(context); // Dismiss loading
        creditService.consumeCredit();

        // Show Beta Result (Glass Modal)
        _showBetaResult(context, result);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Liquid Intelligence Failed.'),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _showBetaResult(BuildContext context, AnalysisResult result) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 500,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('CRYSTAL CLEAR',
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          letterSpacing: 4)),
                  const SizedBox(height: 20),
                  Text('${result.overallScore}',
                      style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 80,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text(result.summary,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      children: result.actionableFeedback
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text("• $e",
                                    style: TextStyle(
                                        color: Colors.white
                                            .withValues(alpha: 0.8))),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // LiquidOpal: Dark Mode Only, Neon Gradients, Glass
    return Scaffold(
      backgroundColor: const Color(0xFF09090b),
      body: Stack(
        children: [
          // 1. Ambient Background Mesh
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

          // 2. Glass Foreground
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: 500,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(30),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 40,
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                      const Icon(Icons.auto_awesome,
                          size: 60, color: Colors.white),
                      const SizedBox(height: 30),
                      Text(
                        'LIQUID OPAL',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.purple, blurRadius: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Aesthetic Intelligence',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withValues(alpha: 0.6),
                          letterSpacing: 2,
                        ),
                      ),
                      const Spacer(),
                      _GlassButton(
                        label: "BEGIN ANALYSIS",
                        onTap: () => _handleBeginAnalysis(context, ref),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
