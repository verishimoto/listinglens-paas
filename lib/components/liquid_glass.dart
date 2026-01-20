import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidGlass extends StatelessWidget {
  final Widget child;
  final double blurSigma;
  final double frostOpacity;
  final double borderRadius;
  final bool hasBorder;
  final LinearGradient? borderGradient;

  const LiquidGlass({
    super.key,
    required this.child,
    this.blurSigma = 30.0, // Deep blur for "Liquid" feel
    this.frostOpacity = 0.05, // Very subtle surface tint
    this.borderRadius = 24.0,
    this.hasBorder = true,
    this.borderGradient,
    this.isIridescent = false,
  });

  final bool isIridescent;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          // 1. BACKDROP FILTER (The Blur)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(
              color: Colors.transparent,
            ),
          ),

          // 2. SURFACE TINT & NOISE SIMULATION (Gradient Overlay)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isIridescent
                    ? [
                        Colors.white.withOpacity(0.4),
                        Colors.blueAccent.withOpacity(0.05),
                        Colors.purpleAccent.withOpacity(0.05),
                        Colors.white.withOpacity(0.1),
                      ]
                    : [
                        Colors.white.withOpacity(frostOpacity + 0.05),
                        Colors.white.withOpacity(frostOpacity),
                        Colors.black.withOpacity(
                            0.02), // Slight darkening for light mode depth
                      ],
                stops: isIridescent
                    ? const [0.0, 0.4, 0.6, 1.0]
                    : const [0.0, 0.4, 1.0],
              ),
              boxShadow: isIridescent
                  ? [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: -2,
                      ),
                    ]
                  : null,
            ),
          ),

          // 3. REFRACTIVE BORDER
          if (hasBorder)
            IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: Colors.transparent), // Placeholder
                  gradient: borderGradient != null
                      ? null // If standard gradient provided (not supported directly in Border) - see replacement below
                      : null,
                ),
                child: CustomPaint(
                  painter: _GlassBorderPainter(
                    radius: borderRadius,
                    gradient: borderGradient ??
                        LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isIridescent
                              ? [
                                  Colors.cyanAccent.withOpacity(0.5),
                                  Colors.purpleAccent.withOpacity(0.3),
                                  Colors.pinkAccent.withOpacity(0.3),
                                  Colors.white.withOpacity(0.4),
                                ]
                              : [
                                  Colors.black.withOpacity(
                                      0.1), // Darker border for light theme
                                  Colors.black.withOpacity(0.02),
                                  Colors.white.withOpacity(
                                      0.5), // Specular highlight still white
                                  Colors.black.withOpacity(0.05),
                                ],
                          stops: const [0.0, 0.4, 0.6, 1.0],
                        ),
                  ),
                ),
              ),
            ),

          // 4. CONTENT
          child,
        ],
      ),
    );
  }
}

class _GlassBorderPainter extends CustomPainter {
  final double radius;
  final Gradient gradient;

  _GlassBorderPainter({required this.radius, required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0; // Thin, crisp border

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
