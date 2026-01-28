import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class NoisyLiquidBackground extends StatelessWidget {
  final Widget child;

  const NoisyLiquidBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. LIQUID GRADIENT (Static for now, can be animated later)
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF050507), // Deep Void
                Color(0xFF0F0518), // Deep Purple bias
                Color(0xFF001015), // Deep Cyan bias
              ],
            ),
          ),
        ),

        // 2. ORB GLOWS (The "Liquid")
        Positioned(
          top: -100,
          left: -100,
          child: _buildOrb(AppColors.leverage1, 500, 0.15), // Purple
        ),
        Positioned(
          bottom: -100,
          right: -100,
          child: _buildOrb(AppColors.leverage2, 600, 0.1), // Cyan
        ),
        Positioned(
          top: 200,
          right: 50,
          child: _buildOrb(AppColors.leverage3, 300, 0.05), // Teal spot
        ),

        // 3. NOISE OVERLAY (High Res Pattern)
        Positioned.fill(
          child: CustomPaint(
            painter: _NoisePainter(),
          ),
        ),

        // 4. CONTENT
        SafeArea(child: child),
      ],
    );
  }

  Widget _buildOrb(Color color, double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: opacity),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: opacity),
            blurRadius: 100,
            spreadRadius: 50,
          )
        ],
      ),
    );
  }
}

class _NoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42); // Fixed seed for consistent static pattern
    final paint = Paint()..strokeWidth = 1.0;

    // Draw monochromatic noise
    for (int i = 0; i < (size.width * size.height) / 10; i++) {
      // Density factor
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double opacity = random.nextDouble() * 0.08; // Very subtle (max 8%)

      paint.color = Colors.white.withValues(alpha: opacity);
      canvas.drawPoints(PointMode.points, [Offset(x, y)], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
