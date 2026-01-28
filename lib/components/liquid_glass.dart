import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidGlass extends StatefulWidget {
  final Widget child;
  final double blurSigma;
  final double frostOpacity;
  final double borderRadius;
  final bool hasBorder;
  final LinearGradient? borderGradient;
  final bool isIridescent;
  final double refractiveIndex; // Phoenix Protocol

  const LiquidGlass({
    super.key,
    required this.child,
    this.blurSigma = 12.0,
    this.frostOpacity = 0.05,
    this.borderRadius = 24.0,
    this.hasBorder = true,
    this.borderGradient,
    this.isIridescent = false,
    this.refractiveIndex = 1.5,
  });

  @override
  State<LiquidGlass> createState() => _LiquidGlassState();
}

class _LiquidGlassState extends State<LiquidGlass>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _mousePosition = Offset.zero;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      onHover: (e) => setState(() => _mousePosition = e.localPosition),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Stack(
          children: [
            // 1. BACKDROP FILTER (The Blur)
            BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: widget.blurSigma, sigmaY: widget.blurSigma),
              child: Container(
                color: Colors.transparent,
              ),
            ),

            // 1.5 NOISE TEXTURE (Phoenix Protocol: "Tooth")
            Positioned.fill(
              child: Opacity(
                opacity: 0.05,
                child: Image.network(
                  'https://grainy-gradients.vercel.app/noise.svg',
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => const SizedBox(),
                ),
              ),
            ),

            // 2. SURFACE TINT & ANIMATED SHIMMER
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final shimmerOffset = _controller.value * 0.2; // Subtle shift
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: widget.isIridescent
                          ? [
                              Colors.white.withValues(alpha: 0.4 *
                                      (0.8 +
                                          0.2 *
                                              _controller.value)), // Breathing
                              Colors.blueAccent.withValues(alpha: 0.05),
                              Colors.purpleAccent.withValues(alpha: 0.05),
                              Colors.white.withValues(alpha: 0.1),
                            ]
                          : [
                              Colors.white.withValues(alpha: (widget.frostOpacity + 0.05) *
                                      (0.9 + 0.1 * _controller.value)),
                              Colors.white
                                  .withValues(alpha: widget.frostOpacity),
                              Colors.black.withValues(alpha: 0.02),
                            ],
                      stops: widget.isIridescent
                          ? [
                              0.0 - shimmerOffset,
                              0.4 + shimmerOffset,
                              0.6 - shimmerOffset,
                              1.0 + shimmerOffset
                            ]
                          : [0.0, 0.4, 1.0],
                    ),
                    boxShadow: widget.isIridescent
                        ? [
                            BoxShadow(
                              color: Colors.blue.withValues(alpha: 0.1 + (0.05 * _controller.value)),
                              blurRadius: 10 + (5 * _controller.value),
                              spreadRadius: -2,
                            ),
                            BoxShadow(
                              color: Colors.purple.withValues(alpha: 0.1),
                              blurRadius: 20,
                              spreadRadius: -5,
                            ),
                          ]
                        : null,
                  ),
                );
              },
            ),

            // 2.5 EDGE LIGHTING & ASYMMETRIC REFRACTION (Visual Logic Delta)
            if (_isHovering)
              Positioned.fill(
                child: CustomPaint(
                  painter: _LiquidLogicPainter(
                    mousePosition: _mousePosition,
                    isIridescent: widget.isIridescent,
                  ),
                ),
              ),

            // 3. REFRACTIVE BORDER
            if (widget.hasBorder)
              IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: CustomPaint(
                    painter: _GlassBorderPainter(
                      radius: widget.borderRadius,
                      gradient: widget.borderGradient ??
                          LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: widget.isIridescent
                                ? [
                                    Colors.cyanAccent.withValues(alpha: 0.6),
                                    Colors.purpleAccent.withValues(alpha: 0.5),
                                    Colors.orangeAccent
                                        .withValues(alpha: 0.4), // Omega: Fire
                                    Colors.white.withValues(alpha: 0.6),
                                  ]
                                : [
                                    Colors.black.withValues(alpha: 0.1),
                                    Colors.black.withValues(alpha: 0.02),
                                    Colors.white.withValues(alpha: 0.5),
                                    Colors.black.withValues(alpha: 0.05),
                                  ],
                            stops: const [0.0, 0.3, 0.6, 1.0],
                          ),
                    ),
                  ),
                ),
              ),

            // 3.5 OMEGA GLOW (Breathing Outer Shadow for Iridescent items)
            if (widget.isIridescent)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (c, _) => Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withValues(alpha: 0.1 + (0.1 * _controller.value)),
                          blurRadius: 20 + (10 * _controller.value),
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: Colors.cyan.withValues(alpha: 0.1),
                          blurRadius: 30,
                          spreadRadius: 5,
                        )
                      ])),
                ),
              ),

            // 4. CONTENT
            widget.child,
          ],
        ),
      ),
    );
  }
}

class _LiquidLogicPainter extends CustomPainter {
  final Offset mousePosition;
  final bool isIridescent;

  _LiquidLogicPainter(
      {required this.mousePosition, required this.isIridescent});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Edge Lighting (Glow follows cursor)
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          (isIridescent ? Colors.cyanAccent : Colors.white)
              .withValues(alpha: 0.15),
          Colors.transparent,
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: mousePosition, radius: 150));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), glowPaint);

    // 2. Asymmetric Refraction (Inverse Glare)
    final inversePosition = Offset(
      size.width - mousePosition.dx,
      size.height - mousePosition.dy,
    );
    final glarePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          (isIridescent ? Colors.purpleAccent : Colors.white)
              .withValues(alpha: 0.05),
          Colors.transparent,
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: inversePosition, radius: 200));

    // Use overlay-like blend mode
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..blendMode = BlendMode.overlay);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), glarePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _LiquidLogicPainter oldDelegate) =>
      oldDelegate.mousePosition != mousePosition;
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
      ..strokeWidth = 1.0;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
