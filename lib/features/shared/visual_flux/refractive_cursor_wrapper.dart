import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

/// Global controller to handle cursor state from anywhere
class VisualFlux {
  static final ValueNotifier<bool> isHovering = ValueNotifier(false);

  static void onEnter() => isHovering.value = true;
  static void onExit() => isHovering.value = false;
}

class RefractiveCursorWrapper extends StatefulWidget {
  final Widget child;

  const RefractiveCursorWrapper({super.key, required this.child});

  @override
  State<RefractiveCursorWrapper> createState() =>
      _RefractiveCursorWrapperState();
}

class _RefractiveCursorWrapperState extends State<RefractiveCursorWrapper> {
  Offset _position = Offset.zero;
  bool _isVisible = false;

  void _updatePosition(PointerEvent event) {
    setState(() {
      _position = event.position;
      _isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none, // Hide OS cursor
      onHover: _updatePosition,
      child: Stack(
        children: [
          // Main Content
          Listener(
            onPointerHover: _updatePosition,
            onPointerMove: _updatePosition,
            child: widget.child,
          ),

          // The Refractive Cursor
          if (_isVisible)
            ValueListenableBuilder<bool>(
              valueListenable: VisualFlux.isHovering,
              builder: (context, isHovering, child) {
                final double size = isHovering ? 28.0 : 14.0;
                final double offset = size / 2;

                return Positioned(
                  left: _position.dx - offset,
                  top: _position.dy - offset,
                  child: IgnorePointer(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.easeOutCubic,
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.6),
                        boxShadow: [
                          if (isHovering)
                            BoxShadow(
                              color: AppColors.leverage1.withValues(alpha: 0.4),
                              blurRadius: 16,
                              spreadRadius: 2,
                            ),
                          // Subtle inner glow for refraction feel
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.8),
                            blurRadius: 4,
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
