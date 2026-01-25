import 'dart:ui';
import 'package:flutter/material.dart';

/// A high-fidelity cursor that simulates light refraction and magnification.
class RefractiveCursor extends StatefulWidget {
  final Widget child;
  final Color cursorColor;
  final double scale;

  const RefractiveCursor({
    super.key,
    required this.child,
    this.cursorColor = Colors.white,
    this.scale = 1.1,
  });

  @override
  State<RefractiveCursor> createState() => _RefractiveCursorState();
}

class _RefractiveCursorState extends State<RefractiveCursor> {
  Offset _position = Offset.zero;
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setState(() {
        _position = event.localPosition;
        _visible = true;
      }),
      onExit: (_) => setState(() => _visible = false),
      cursor: SystemMouseCursors.none,
      child: Stack(
        children: [
          widget.child,
          if (_visible)
            Positioned(
              left: _position.dx - 20,
              top: _position.dy - 20,
              child: IgnorePointer(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.cursorColor.withValues(alpha: 0.4),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.cursorColor.withValues(alpha: 0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.matrix(
                        Matrix4.identity()
                            .scaled(widget.scale, widget.scale)
                            .storage,
                      ),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
