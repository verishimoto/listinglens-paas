import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class LiquidBackground extends StatefulWidget {
  const LiquidBackground({super.key});

  @override
  State<LiquidBackground> createState() => _LiquidBackgroundState();
}

class _LiquidBackgroundState extends State<LiquidBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 35), vsync: this)
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Using LiquidGlassRenderer for the blobs if possible, or sticking to
    // standard gradients if performance is too heavy.
    // Given the README, LiquidGlass works best *over* content.
    // Ideally, we put the gradients BEHIND the glass layer.

    return Container(
      color: AppColors.backgroundDark, // #050505
      child: Stack(
        children: [
          // 1. Base Gradients (The "Liquid" Sources)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                top: -100 + (_controller.value * 50),
                left: -100 + (_controller.value * 100),
                child: Container(
                  width: 600,
                  height: 600,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.leverage2, // Cyan
                        Colors.transparent,
                      ],
                      radius: 0.6,
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: -150 + (_controller.value * 80),
                right: -150 + ((1 - _controller.value) * 120),
                child: Container(
                  width: 550,
                  height: 550,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.leverage6, // Orange
                        Colors.transparent,
                      ],
                      radius: 0.65,
                    ),
                  ),
                ),
              );
            },
          ),

          // 2. The Liquid Glass Layer - Applied over the blobs to distort them?
          // Or strictly used for UI panels?
          // Based on "For the effect to be visible, you must place your glass widget on top of other content."
          // We will use this in the EpsilonShell for panels, not necessarily the background itself.
          // But we can add a subtle glass distortion over the background if desired.

          // For now, let's keep the background as just the blurred blobs
          // to save GPU for the interactive UI elements.
        ],
      ),
    );
  }
}
