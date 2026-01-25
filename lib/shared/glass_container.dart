import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final Color color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Border? border;
  final Gradient? gradient;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 10,
    this.opacity = 0.05,
    this.color = Colors.white,
    this.borderRadius,
    this.padding,
    this.border,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(24);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color.withValues(alpha: opacity),
            borderRadius: radius,
            border: border ??
                Border.all(color: Colors.white.withValues(alpha: 0.1)),
            gradient: gradient,
          ),
          child: child,
        ),
      ),
    );
  }
}
