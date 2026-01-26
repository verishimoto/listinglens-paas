import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class TheLab extends StatelessWidget {
  const TheLab({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Drop Area / Preview
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("🖼️", style: TextStyle(fontSize: 64)),
                const SizedBox(height: 24),
                const Text(
                  "ENTER STRATEGY ROOM",
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -1.0,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "\"Visual dominance anchor. Must capture interest in <1.2s.\"",
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("SWAP LAYER",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5)),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 32),

        // Analysis Pane
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.leverage6.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppColors.leverage6.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "STRATEGIC ANALYSIS",
                      style: TextStyle(
                        color: AppColors.leverage6,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4.0,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Awaiting machine synthesis...",
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withValues(alpha: 0.4),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppColors.leverage6,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.leverage6, blurRadius: 10)
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text("ACTIVE REQUIREMENT SCAN",
                            style: TextStyle(
                                color: AppColors.leverage6,
                                fontWeight: FontWeight.bold)),
                      ],
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
                ),
                child: Text(
                  "\"Optimize for the biological hit of the first slide. If the eye doesn't rest, the cart stays empty.\"",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
