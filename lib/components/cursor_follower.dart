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
    // 1. Refractive Mesh (Wide Field)
    final fieldPaint = Paint()
      ..shader = ui.Gradient.radial(
        position,
        400,
        [
          Colors.white.withValues(alpha: 0.08),
          Colors.cyanAccent.withValues(alpha: 0.03),
          Colors.transparent,
        ],
        [0.0, 0.4, 1.0],
      )
      ..blendMode = BlendMode.screen;

    canvas.drawCircle(position, 400, fieldPaint);

    // 2. The Glass Focus (Reactive Core)
    final corePaint = Paint()
      ..shader = ui.Gradient.radial(
        position,
        150,
        [
          Colors.white.withValues(alpha: 0.15),
          Colors.white.withValues(alpha: 0.05),
          Colors.transparent,
        ],
        [0.0, 0.2, 1.0],
      )
      ..blendMode = BlendMode.overlay;

    canvas.drawCircle(position, 150, corePaint);

    // 3. Specular Highlight (The "Lead")
    final specularPaint = Paint()
      ..shader = ui.Gradient.radial(
        position,
        40,
        [
          Colors.white.withValues(alpha: 0.4),
          Colors.white.withValues(alpha: 0.0),
        ],
      )
      ..blendMode = BlendMode.plus;

    canvas.drawCircle(position, 40, specularPaint);
  }

  @override
  bool shouldRepaint(covariant _CursorGlowPainter oldDelegate) {
    return oldDelegate.position != position;
  }
}
