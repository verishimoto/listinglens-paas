import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/features/lab/the_fingerprint.dart';
import 'package:listing_lens_paas/features/lab/the_arena.dart';

class TheLab extends StatefulWidget {
  final VoidCallback? onAnalyze;
  final Map<String, dynamic>? stageData; // passed from EpsilonShell
  final bool isAnalyzing;

  const TheLab(
      {super.key, this.onAnalyze, this.stageData, this.isAnalyzing = false});

  @override
  State<TheLab> createState() => _TheLabState();
}

class _TheLabState extends State<TheLab> {
  // 'Etsy' or 'Creative Market'
  String _platform = 'Etsy';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // PLATFORM SELECTOR (Opal Style)
        Container(
          height: 48,
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildChoiceChip('Etsy'),
              _buildChoiceChip('Creative Market'),
            ],
          ),
        ),

        Expanded(
          child: Row(
            children: [
              // Drop Area / Preview (Left)
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A)
                        .withValues(alpha: 0.5), // Brand Dark from HTML
                    borderRadius: BorderRadius.circular(24),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    backgroundBlendMode: BlendMode.overlay,
                  ),
                  child: Stack(
                    children: [
                      // Backdrop Glow
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: Alignment.center,
                              radius: 0.8,
                              colors: [
                                _platform == 'Etsy'
                                    ? AppColors.leverage6
                                        .withValues(alpha: 0.15) // Orange/Etsy
                                    : AppColors.leverage4
                                        .withValues(alpha: 0.15), // Green/CM
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Content
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 64,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              widget.stageData?['title'].toUpperCase() ??
                                  "ENTER STRATEGY ROOM",
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.stageData?['subtitle'] ??
                                  (_platform == 'Etsy'
                                      ? "Etsy Standard • 5:4 or 4:3 Ratio • >2000px"
                                      : "Creative Market • 3:2 Ratio • >3000px"),
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: AppColors.leverage2, // Cyan accent
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "\"Visual dominance anchor. Must capture interest in <1.2s.\"",
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.white.withValues(alpha: 0.4),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),

                            // Liquid Glass Button
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: widget.onAnalyze,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 16),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withValues(alpha: 0.1),
                                        Colors.white.withValues(alpha: 0.05),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.2),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.2),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.upload_file,
                                          color: Colors.white, size: 20),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "UPLOAD ASSET",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 32),

              // Analysis Pane (Right)
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.leverage6.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color:
                                  AppColors.leverage6.withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: AppColors.leverage6,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.leverage6
                                              .withValues(alpha: 0.5),
                                          blurRadius: 8)
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "STRATEGIC ANALYSIS • ${_platform.toUpperCase()}",
                                  style: TextStyle(
                                    color: AppColors.leverage6,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Text(
                              "Awaiting heuristic scan...",
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                color: Colors.white.withValues(alpha: 0.6),
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: 0.05,
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.1),
                              color: AppColors.leverage6,
                              minHeight: 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Tip Box
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.05)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "PRO TIP: ${_platform}",
                              style: TextStyle(
                                color: AppColors.leverage2, // Cyan
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _platform == 'Etsy'
                                  ? "\"Etsy buyers prioritize 'lifestyle context'. Showing the product in use increases conversion by 17%.\""
                                  : "\"Creative Market buyers prioritize 'asset utility'. Showing the wireframe/layers increases trust.\"",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white.withValues(alpha: 0.8),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // v1.3 THE FINGERPRINT (Integrity Scan)
                      const SizedBox(height: 24),
                      const TheFingerprint(),

                      const SizedBox(height: 24),

                      // v1.2 THE ARENA (Competitor Simulation)
                      const TheArena(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceChip(String label) {
    final bool isSelected = _platform == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _platform = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color:
                isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
