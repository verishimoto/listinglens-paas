import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/components/liquid_background.dart';
import 'package:listing_lens_paas/layout/gluesystem.dart';
import 'package:listing_lens_paas/features/lab/the_lab.dart';
import 'package:listing_lens_paas/features/hub/the_hub.dart';
import 'package:listing_lens_paas/components/sun_cursor.dart';
import 'package:listing_lens_paas/features/lab/opal_audit_result.dart';
import 'package:listing_lens_paas/features/archives/archives.dart';

class EpsilonShell extends StatefulWidget {
  const EpsilonShell({super.key});

  @override
  State<EpsilonShell> createState() => _EpsilonShellState();
}

class _EpsilonShellState extends State<EpsilonShell> {
  String _view = 'lab'; // 'lab', 'hub', 'archives'
  int _activeStage = 0;
  LiquidState _liquidState = LiquidState.idle;

  void _triggerAnalysis() async {
    setState(() => _liquidState = LiquidState.analyzing);
    // Simulate Analysis (Game Theory: Delay creates anticipation)
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _liquidState = LiquidState.success);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _liquidState = LiquidState.idle);
  }

  final List<Map<String, dynamic>> _stages = [
    {
      "id": 1,
      "title": "Hero Cover",
      "subtitle": "Primary Impact",
      "cleared": false,
      "imagePath": "C:\\Users\\veris\\.gemini\\antigravity\\brain\\417cda50-6209-449e-adee-488612bd2286\\uploaded_media_0_1769527676670.png"
    },
    {
      "id": 2,
      "title": "Flat Proof",
      "subtitle": "Quality QA",
      "cleared": false,
      "imagePath": "C:\\Users\\veris\\.gemini\\antigravity\\brain\\417cda50-6209-449e-adee-488612bd2286\\uploaded_media_1_1769527676670.png"
    },
    {
      "id": 3,
      "title": "Video Retention",
      "subtitle": "Motion SEO",
      "cleared": false,
      "imagePath": "C:\\Users\\veris\\.gemini\\antigravity\\brain\\417cda50-6209-449e-adee-488612bd2286\\uploaded_media_3_1769527676670.png" // Using the 4th/video-like file if applicable
    },
    {
      "id": 4,
      "title": "Lifestyle Fit",
      "subtitle": "Social Proof",
      "cleared": false,
      "imagePath": "C:\\Users\\veris\\.gemini\\antigravity\\brain\\417cda50-6209-449e-adee-488612bd2286\\uploaded_media_2_1769527676670.png"
    },
    {
      "id": 5,
      "title": "Tech Spec",
      "subtitle": "Data Integrity",
      "cleared": false,
      "imagePath": null
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SunCursor(
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: Stack(
          children: [
            // 1. Global Liquid Background
            Positioned.fill(child: LiquidBackground(currentState: _liquidState)),

            // 2. Main Content (Constrained Max Width)
            Positioned.fill(
              child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 24),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SIDEBAR
                              SizedBox(
                                width: 300,
                                child: ListView.builder(
                                  itemCount: _stages.length,
                                  itemBuilder: (context, index) {
                                    final s = _stages[index];
                                    return GlueSystem.sidebarItem(
                                      isActive: _activeStage == index &&
                                          _view == 'lab',
                                      title: s['title'],
                                      subtitle: s['subtitle'],
                                      isCleared: s['cleared'],
                                      onTap: () {
                                        setState(() {
                                          _activeStage = index;
                                          _view = 'lab';
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),

                              // CONTENT GLASS PANEL
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: _buildGlassPanel(
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: KeyedSubtree(
                                        key: ValueKey(_view + _liquidState.toString()),
                                        child: _view == 'lab'
                                            ? (_liquidState == LiquidState.success || _liquidState == LiquidState.analyzing // Just for demo, usually success only
                                                ? (_liquidState == LiquidState.analyzing
                                                  ? TheLab(
                                                      stageData: _stages[_activeStage],
                                                      onAnalyze: _triggerAnalysis,
                                                      isAnalyzing: true,
                                                    )
                                                    : OpalAuditResult(
                                                      stageData: _stages[_activeStage],
                                                      onNext: () {
                                                        setState(() {
                                                          if (_activeStage < _stages.length - 1) {
                                                            _activeStage++;
                                                            _liquidState = LiquidState.idle;
                                                          }
                                                        });
                                                      },
                                                    )
                                                )
                                                : TheLab(
                                                    stageData: _stages[_activeStage],
                                                    onAnalyze: _triggerAnalysis,
                                                  )
                                              )
                                            : (_view == 'hub'
                                                ? const TheHub()
                                                : const Archives()),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassPanel({required Widget child}) {
    // Manual Glass Effect for Windows
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0C0C12)
                .withValues(alpha: 0.6), // Dark semi-transparent
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          padding: const EdgeInsets.all(32),
          child: child,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.leverage2, // Cyan
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.lens, color: Colors.black),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("PLAYBOOK PIPELINE",
                    style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5)),
                Text("LIQUID MEMORY MASTER V11.5",
                    style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withValues(alpha: 0.3),
                        letterSpacing: 2.0)),
              ],
            ),
          ],
        ),
        _buildNavCluster(),
      ],
    );
  }

  Widget _buildNavCluster() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: ['lab', 'hub', 'archives'].map((v) {
          final active = _view == v;
          return GestureDetector(
            onTap: () => setState(() => _view = v),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: active ? AppColors.leverage6 : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                v == 'lab'
                    ? 'THE LAB'
                    : v == 'hub'
                        ? 'THE HUB'
                        : 'ARCHIVES',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: active
                      ? Colors.black
                      : Colors.white.withValues(alpha: 0.5),
                  letterSpacing: 1.2,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("SELLABILITY ROI PREDICTION ENGINE V1.0",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withValues(alpha: 0.4),
                    letterSpacing: 1.5)),
            const Text("0% PROGRESS",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.leverage6,
                    letterSpacing: 1.5)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 6,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(3)),
              child: Row(
                children: [
                  Container(
                      width: 20,
                      decoration: BoxDecoration(
                          color: AppColors.leverage6,
                          borderRadius: BorderRadius.circular(3))),
                ],
              ),
            ),
            const Text(
                "Powered by MellowPen Studio | mellowpen.studio@gmail.com",
                style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMute,
                    letterSpacing: 1.0)),
          ],
        ),
      ],
    );
  }
}
