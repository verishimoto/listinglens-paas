import 'package:flutter/material.dart';
import 'dart:math' as math;

class IridescentBorder extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final bool isReactive;

  const IridescentBorder({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.isReactive = true,
  });

  @override
  State<IridescentBorder> createState() => _IridescentBorderState();
}

class _IridescentBorderState extends State<IridescentBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        _controller.repeat();
      },
      onExit: (_) {
        setState(() => _isHovering = false);
        _controller.reset();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _RazorBorderPainter(
              animationValue: _controller.value,
              borderRadius: widget.borderRadius,
              opacity: widget.isReactive ? (_isHovering ? 1.0 : 0.3) : 1.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0), // Strict 1px reserve
              child: widget.child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class _RazorBorderPainter extends CustomPainter {
  final double animationValue;
  final double borderRadius;
  final double opacity;

  _RazorBorderPainter({
    required this.animationValue,
    required this.borderRadius,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity <= 0.05) return; // Optimization

    final rect = Offset.zero & size;
    // Deflate by 0.5 to keep stroke inside bounds
    final RRect rrect = RRect.fromRectAndRadius(
      rect.deflate(0.5),
      Radius.circular(borderRadius),
    );

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: math.pi * 2,
        colors: [
          const Color(0xFF7E00FF).withValues(alpha: opacity), // Opal Purple
          const Color(0xFF00C7FF).withValues(alpha: opacity), // Opal Cyan
          const Color(0xFFDCFF00).withValues(alpha: opacity), // Opal Yellow
          const Color(0xFF7E00FF).withValues(alpha: opacity), // Loop
        ],
        stops: const [0.0, 0.4, 0.7, 1.0],
        transform: GradientRotation(animationValue * 2 * math.pi),
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_RazorBorderPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.opacity != opacity;
  }
}
