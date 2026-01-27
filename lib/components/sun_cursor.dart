import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'dart:ui';

class SunCursor extends StatefulWidget {
  final Widget child;
  const SunCursor({super.key, required this.child});

  @override
  State<SunCursor> createState() => _SunCursorState();
}

class _SunCursorState extends State<SunCursor> {
  Offset _position = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() => _position = event.position);
      },
      child: Stack(
        children: [
          // The underlying content
          widget.child,

          // The "Sun" Cursor / Glow Layer
          IgnorePointer(
            child: CustomPaint(
              painter: _SunGlowPainter(center: _position),
              size: Size.infinite,
            ),
          ),
        ],
      ),
    );
  }
}

class _SunGlowPainter extends CustomPainter {
  final Offset center;

  _SunGlowPainter({required this.center});

  @override
  void paint(Canvas canvas, Size size) {
    // "Asymmetric Edge Glow" - A subtle, large radial gradient that follows the mouse
    // Creates that "liquid glass" feel by illuminating the background/glass elements behind it.

    // 1. The Core Sun (Hot Spot)
    final paintCore = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.leverage3.withValues(alpha: 0.15), // Teal glow
          AppColors.leverage1.withValues(alpha: 0.05), // Purple wash
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: 150));

    canvas.drawCircle(center, 150, paintCore);

    // 2. The Ambient Asymmetry (Larger, more subtle wash)
    // We offset the center slightly to create "movement" or "drag" feel if we tracked velocity,
    // but for now, we'll keep it centered but very large to act as a torch.
    final paintAmbient = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withValues(alpha: 0.03),
          Colors.transparent,
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: 400));

    canvas.drawCircle(center, 400, paintAmbient);
  }

  @override
  bool shouldRepaint(covariant _SunGlowPainter oldDelegate) {
    return oldDelegate.center != center;
  }
}
