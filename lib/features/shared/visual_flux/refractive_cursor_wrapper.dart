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

                return AnimatedPositioned(
                  duration:
                      const Duration(milliseconds: 100), // "Mass" lag of 100ms
                  curve: Curves.easeOutCubic,
                  left: _position.dx - offset,
                  top: _position.dy - offset,
                  child: IgnorePointer(
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // Pure light source
                        boxShadow: [
                          if (isHovering)
                            BoxShadow(
                              color: AppColors.leverage1.withValues(alpha: 0.5),
                              blurRadius: 24,
                              spreadRadius: 4,
                            ),
                          // Core "Photon" Glow
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.8),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      // "Photon" Blend Mode: Interacts with surface like light
                      foregroundDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        backgroundBlendMode: BlendMode.overlay,
                        color: Colors.white.withValues(alpha: 0.5),
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
