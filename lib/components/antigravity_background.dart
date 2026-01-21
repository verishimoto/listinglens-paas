import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'dart:math';

class AntigravityBackground extends StatefulWidget {
  const AntigravityBackground({super.key});

  @override
  State<AntigravityBackground> createState() => _AntigravityBackgroundState();
}

class _AntigravityBackgroundState extends State<AntigravityBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _mousePos = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (e) => setState(() => _mousePos = e.position),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _OrbitalBlobPainter(
              animationValue: _controller.value,
              mousePos: _mousePos,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _OrbitalBlobPainter extends CustomPainter {
  final double animationValue;
  final Offset mousePos;

  _OrbitalBlobPainter({required this.animationValue, required this.mousePos});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Base White/Crystal Field
    final rect = Offset.zero & size;
    final bgPaint = Paint()..color = AppColors.crystalBackground;
    canvas.drawRect(rect, bgPaint);

    // 2. Calculated Orbital Positions
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Gentle repulsion from mouse
    final mouseDeltaX = (mousePos.dx - centerX) * 0.05;
    final mouseDeltaY = (mousePos.dy - centerY) * 0.05;

    // Blob 1: Orange (Sun)
    _drawBlob(
      canvas,
      Offset(
        centerX + cos(animationValue * 2 * pi) * 200 - mouseDeltaX,
        centerY + sin(animationValue * 2 * pi) * 100 - mouseDeltaY,
      ),
      300,
      AppColors.mellowOrange.withOpacity(0.15),
    );

    // Blob 2: Cyan (Planet)
    _drawBlob(
      canvas,
      Offset(
        centerX + cos(animationValue * 2 * pi + 2) * 300 - mouseDeltaX * 1.5,
        centerY + sin(animationValue * 2 * pi + 2) * 200 - mouseDeltaY * 1.5,
      ),
      250,
      AppColors.mellowCyan.withOpacity(0.15),
    );

    // Blob 3: Violet (Moon)
    _drawBlob(
      canvas,
      Offset(
        centerX + cos(animationValue * -2 * pi) * 400 + mouseDeltaX,
        centerY + sin(animationValue * -2 * pi) * 300 + mouseDeltaY,
      ),
      350,
      const Color(0xFF7E00FF).withOpacity(0.1),
    );

    // 3. Noise Overlay (Static Grain)
    // In production, use an ImageShader. Here we just assume it's part of the glass layer on top.
  }

  void _drawBlob(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, color.withOpacity(0)],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _OrbitalBlobPainter oldDelegate) {
    return true; // Constant animation
  }
}
