import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class OpalAuditResult extends StatelessWidget {
  final Map<String, dynamic> stageData;
  final VoidCallback onNext;

  const OpalAuditResult({
    super.key,
    required this.stageData,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    // REFACTORED: ListingLens Liquid Glass Theme (No "Opal" Greens)
    // Uses AppColors.leverage1 (Purple) & leverage2 (Cyan)

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT: Image & Summary
        Expanded(
          flex: 5,
          child: Column(
            children: [
              _buildGlassCard(
                child: Column(
                  children: [
                    // Image Container with Liquid Border
                    Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Colors.white.withValues(alpha: 0.05)),
                      ),
                      child: stageData['imagePath'] != null
                          ? Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    File(stageData['imagePath']),
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                // Gloss Overlay
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white.withValues(alpha: 0.1),
                                          Colors.transparent,
                                          Colors.transparent,
                                        ],
                                        stops: const [0.0, 0.4, 1.0],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Icon(Icons.lens_blur,
                                  size: 64,
                                  color: Colors.white.withValues(alpha: 0.1)),
                            ),
                    ),
                    const SizedBox(height: 24),

                    // Grade / Score (Liquid Style)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("DOPAMINE SCORE",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        fontSize: 14,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            // Gradient Text
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  AppColors.leverage2,
                                  AppColors.leverage3
                                ],
                              ).createShader(bounds),
                              child: Text("A-",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                          fontSize: 120, // Enormous
                                          height: 0.9)),
                            ),
                          ],
                        ),
                        // Liquid Crystal Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.leverage1.withValues(alpha: 0.2),
                                AppColors.leverage2.withValues(alpha: 0.1)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: AppColors.leverage2.withValues(alpha: 0.3)),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.leverage2.withValues(alpha: 0.1),
                                  blurRadius: 20,
                                  spreadRadius: 2)
                            ],
                          ),
                          child: Row(
                            children: [
                              Text("92",
                                  style: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              Text("/100",
                                  style: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      color: Colors.white.withValues(alpha: 0.5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Strengths Card
              _buildGlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome,
                            color: AppColors.leverage3, size: 14),
                        const SizedBox(width: 8),
                        Text("NEURO-AESTHETIC LOCKS",
                            style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 10,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildCheckItem("Contrast Ratio > 4.5:1 (Pop Factor)"),
                    _buildCheckItem("Focal Point: Center-Weighted integrity"),
                    _buildCheckItem("Emotional Valence: Trust (Blue spectrum)"),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 24),

        // RIGHT: Detailed Analysis
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _buildGlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("DEEP DIVE METRICS",
                        style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 10,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    _buildLiquidBar("Visual Hierarchy", 0.95),
                    _buildLiquidBar("Cognitive Load", 0.88),
                    _buildLiquidBar("Brand Resonance", 0.92),
                    _buildLiquidBar("Click Probability", 0.75),
                    const SizedBox(height: 32),
                    Divider(color: Colors.white.withValues(alpha: 0.1)),
                    const SizedBox(height: 24),
                    Text("THE ORACLE SPEAKS",
                        style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: AppColors.leverage1, // Purple
                            fontSize: 10,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Text(
                      "\"The visuals are strong, but the shadow play is weak. Creative Market buyers want to see layer depth. Boost the Ambient Occlusion in your mockups by 15% to increase perceived value.\"",
                      style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          height: 1.6,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Next Liquid Action Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onNext,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.leverage1.withValues(alpha: 0.8),
                          AppColors.leverage1.withValues(alpha: 0.4),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2), width: 1),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.leverage1.withValues(alpha: 0.3),
                            blurRadius: 25,
                            offset: const Offset(0, 5))
                      ],
                    ),
                    child: Center(
                      child: Text("ADVANCE PIPELINE",
                          style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.leverage3.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check,
                color: AppColors.leverage3, size: 10), // Teal check
          ),
          const SizedBox(width: 12),
          Text(text,
              style: const TextStyle(
                  fontFamily: 'SF Pro Display',
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildLiquidBar(String title, double score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              Text("${(score * 100).toInt()}%",
                  style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      color: score > 0.9
                          ? AppColors.leverage3
                          : (score > 0.7 ? AppColors.leverage2 : Colors.orange),
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: score,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            score > 0.9
                                ? AppColors.leverage3
                                : AppColors.leverage2,
                            (score > 0.9
                                    ? AppColors.leverage3
                                    : AppColors.leverage2)
                                .withValues(alpha: 0.3)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: (score > 0.9
                                    ? AppColors.leverage3
                                    : AppColors.leverage2)
                                .withValues(alpha: 0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
