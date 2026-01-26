import 'dart:ui';
import 'package:flutter/material.dart';
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
    return Container(
      color: AppColors.backgroundDark, // #050505
      child: Stack(
        children: [
          // Blob 1: Cyan
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                top: -100 + (_controller.value * 50),
                left: -100 + (_controller.value * 100),
                child: _buildBlob(
                  width: 600,
                  height: 600,
                  color: AppColors.leverage2, // Cyan
                  radius: 0.6,
                ),
              );
            },
          ),
          // Blob 2: Orange
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: -150 + (_controller.value * 80),
                right: -150 + ((1 - _controller.value) * 120),
                child: _buildBlob(
                  width: 550,
                  height: 550,
                  color: AppColors.leverage6, // Orange
                  radius: 0.65,
                ),
              );
            },
          ),
          // Blob 3: Purple accent
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                top: 200,
                right: 200 + (_controller.value * 40),
                child: _buildBlob(
                  width: 400,
                  height: 400,
                  color: AppColors.leverage1, // Purple
                  radius: 0.7,
                ),
              );
            },
          ),

          // The Diffuser (Global Blur)
          // This creates the "Fluid" mix of the blobs behind everything
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(color: Colors.transparent),
            ),
          ),

          // Noise Overlay (Optional Texture)
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: IgnorePointer(
                child: Container(
                  color: Colors.white, // Placeholder for actual noise image
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlob(
      {required double width,
      required double height,
      required Color color,
      required double radius}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0.0)],
          stops: [0.2, 1.0],
          radius: radius,
        ),
      ),
    );
  }
}
