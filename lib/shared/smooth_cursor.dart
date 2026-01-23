import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:ui' as ui;

/// A specialized widget that replaces the system cursor with a
/// "Simple Follow" cursor featuring inertia and optical smoothing.
///
/// Based on the "Simple Follow" Framer pattern.
class SmoothCursor extends StatefulWidget {
  final Widget child;
  final Color cursorColor;
  final double smoothing; // 0.0 to 1.0 (lower is heavier/smoother)

  const SmoothCursor({
    super.key,
    required this.child,
    this.cursorColor = Colors.white,
    this.smoothing = 0.12,
  });

  @override
  State<SmoothCursor> createState() => _SmoothCursorState();
}

class _SmoothCursorState extends State<SmoothCursor>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;

  // Physics state
  Offset _mousePos = Offset.zero;
  Offset _cursorPos = Offset.zero;

  // Interactive state (hovering over clickable)
  // Note: True "global hover" detection in Flutter is complex without wrapping every widget.
  // We will default to a standard size, but the infrastructure is here if we want to expand it.
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration elapsed) {
    // Standard Linear Interpolation (Lerp) for inertia
    // current += (target - current) * smoothing
    final dx = _mousePos.dx - _cursorPos.dx;
    final dy = _mousePos.dy - _cursorPos.dy;

    if (dx.abs() < 0.1 && dy.abs() < 0.1) {
      // Resting state
      return;
    }

    setState(() {
      _cursorPos += Offset(dx * widget.smoothing, dy * widget.smoothing);
    });
  }

  void _onHover(PointerHoverEvent event) {
    _mousePos = event.position;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none, // Hide native cursor
      onHover: _onHover,
      child: Stack(
        children: [
          widget.child,
          // The Custom Cursor
          Positioned(
            left: _cursorPos.dx - 10, // Center the 20x20 cursor
            top: _cursorPos.dy - 10,
            child: IgnorePointer(
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent, // Glassy center
                  border: Border.all(
                    color: widget.cursorColor.withValues(alpha: 0.9),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.cursorColor.withValues(alpha: 0.1),
                      blurRadius: 4,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
