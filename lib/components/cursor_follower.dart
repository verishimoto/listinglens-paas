import 'package:flutter/material.dart';

import 'dart:ui' as ui;

class CursorFollower extends StatefulWidget {
  final Widget child;
  const CursorFollower({super.key, required this.child});

  @override
  State<CursorFollower> createState() => _CursorFollowerState();
}

class _CursorFollowerState extends State<CursorFollower> {
  Offset _position = Offset.zero;

  void _updatePosition(PointerEvent event) {
    setState(() {
      _position = event.position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _updatePosition,
      child: Stack(
        children: [
          // Content
          widget.child,

          // Refractive Overlay (The "Follower")
          IgnorePointer(
            child: CustomPaint(
              painter: _CursorGlowPainter(_position),
              size: Size.infinite,
            ),
          ),
        ],
      ),
    );
  }
}

class _CursorGlowPainter extends CustomPainter {
  final Offset position;
  _CursorGlowPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Refractive Mesh
    // We paint a subtle overlay that simulates the "field" of the cursor
    final paint = Paint()
      ..shader = ui.Gradient.radial(
        position,
        600, // Large radius
        [
          Colors.white.withValues(alpha: 0.05), // Center highlight
          Colors.cyanAccent.withValues(alpha: 0.02),
          Colors.purpleAccent.withValues(alpha: 0.01),
          Colors.transparent
        ],
        [0.0, 0.3, 0.6, 1.0],
      )
      ..blendMode = BlendMode.screen; // Additive light

    canvas.drawCircle(position, 600, paint);

    // 2. The Core (High Intensity)
    final corePaint = Paint()
      ..shader = ui.Gradient.radial(
        position,
        100,
        [Colors.white.withValues(alpha: 0.1), Colors.transparent],
      )
      ..blendMode = BlendMode.overlay;

    canvas.drawCircle(position, 100, corePaint);
  }

  @override
  bool shouldRepaint(covariant _CursorGlowPainter oldDelegate) {
    return oldDelegate.position != position;
  }
}
