import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'dart:math' as math;

class IridescentBorder extends StatefulWidget {
  final Widget child;
  final double borderWidth;
  final BorderRadius borderRadius;

  const IridescentBorder({
    super.key,
    required this.child,
    this.borderWidth = 1.5,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
  });

  @override
  State<IridescentBorder> createState() => _IridescentBorderState();
}

class _IridescentBorderState extends State<IridescentBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Slow, breathing rotation
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: SweepGradient(
              center: Alignment.center,
              startAngle: 0.0,
              endAngle: math.pi * 2,
              colors: const [
                Color(0xFF7E00FF), // Opal Purple (Leverage 1)
                Color(0xFF00C7FF), // Opal Cyan (Leverage 2)
                Color(0xFFDCFF00), // Opal Pink/Yellow shift (Leverage 5)
                Color(0xFF7E00FF), // Loop back to Purple
              ],
              stops: const [0.0, 0.4, 0.7, 1.0],
              transform: GradientRotation(_controller.value * 2 * math.pi),
            ),
          ),
          padding: EdgeInsets.all(widget.borderWidth),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(
                  0xFF050507), // Match Void background to mask the fill
              borderRadius: widget.borderRadius,
            ),
            child: widget.child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
