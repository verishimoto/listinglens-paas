import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

/// The "Sun Cursor" effect from Opal visual logic.
///
/// Wraps the entire application stack.
/// - Tracks mouse/pointer position.
/// - Renders a subtle, asymmetric glow that follows the cursor.
/// - "Sun" cursor state: A small, bright dot that trails slightly or snaps to interactive elements
///   (simplified implementation for MVP: just the glow/follower).
class SunCursor extends StatefulWidget {
  final Widget child;

  const SunCursor({super.key, required this.child});

  @override
  State<SunCursor> createState() => _SunCursorState();
}

class _SunCursorState extends State<SunCursor>
    with SingleTickerProviderStateMixin {
  Offset _position = Offset.zero;
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _position = event.position;
          _isVisible = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isVisible = false;
        });
      },
      child: Stack(
        children: [
          widget.child,
          // The Glow
          IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isVisible ? 1.0 : 0.0,
              child: CustomPaint(
                painter: _CursorGlowPainter(_position),
                size: Size.infinite,
              ),
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
    // 1. Core Light (Sun) - The bright center
    final paintCore = Paint()
      ..color = AppColors.leverage15.withValues(alpha: 0.15) // White/Plasma
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    canvas.drawCircle(position, 40, paintCore);

    // 2. Asymmetric Aura (Opal Glow) - The colored diffraction
    // Using a gradient to simulate different wavelengths (Red/Blue/Purple)
    final gradient = RadialGradient(
      center: Alignment.center,
      radius: 0.5,
      colors: [
        AppColors.leverage2.withValues(alpha: 0.1), // Cyan/Plasma
        AppColors.leverage1.withValues(alpha: 0.05), // Purple
        Colors.transparent,
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    final paintAura = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: position, radius: 250),
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);

    canvas.drawCircle(position, 250, paintAura);
  }

  @override
  bool shouldRepaint(covariant _CursorGlowPainter oldDelegate) {
    return oldDelegate.position != position;
  }
}
