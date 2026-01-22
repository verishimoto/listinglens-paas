import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/components/dark_mode_toggle.dart';
import 'dart:ui' as ui;

class LiquidTabShell extends StatefulWidget {
  final List<Map<String, dynamic>> tabs;
  final int activeIndex;
  final Function(int) onTabSelected;
  final Widget content;

  const LiquidTabShell({
    super.key,
    required this.tabs,
    required this.activeIndex,
    required this.onTabSelected,
    required this.content,
  });

  @override
  State<LiquidTabShell> createState() => _LiquidTabShellState();
}

class _LiquidTabShellState extends State<LiquidTabShell> {
  Offset _mousePos = Offset.zero;
  bool _isDark = true; // Local state for demo, ideally Riverpod

  void _toggleTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double tabHeight = 64.0; // Slightly taller
    const double tabWidth = 280.0; // Slightly wider for better readability
    const double connectionCurveRadius = 24.0;

    // Calculate vertical offset for the active tab (centered path)
    // We assume fixed tab height or consistent spacing
    final double activeTabTop =
        32.0 + (widget.activeIndex * (tabHeight + 16.0)); // Increased spacing

    return MouseRegion(
      onHover: (e) => setState(() => _mousePos = e.position),
      child: Stack(
        children: [
          // 1. THE MENISCUS SHAPE (Custom Paint)
          // This draws the unified glass body + tab
          Positioned.fill(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Stack(children: [
                  CustomPaint(
                    size: Size.infinite,
                    painter: _MeniscusGlassPainter(
                      tabTop: activeTabTop,
                      tabHeight: tabHeight,
                      tabWidth: tabWidth,
                      curveRadius: connectionCurveRadius,
                      mousePos: _mousePos,
                    ),
                  ),
                  // NOISE LAYER (Ghost Glass: 4%)
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.04,
                      child: Image.network(
                        'https://grainy-gradients.vercel.app/noise.svg',
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => const SizedBox(),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),

          // 2. THE CONTENT (Clipped or Padded)
          Padding(
            padding: const EdgeInsets.only(left: tabWidth),
            child: widget.content,
          ),

          // 3. THE TABS (Text/Icons Interactables)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: tabWidth,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    itemCount: widget.tabs.length,
                    itemBuilder: (context, index) {
                      final isActive = widget.activeIndex == index;
                      // Render text only, geometry is handled by painter
                      return GestureDetector(
                        onTap: () => widget.onTabSelected(index),
                        child: Container(
                          height: 64.0, // Match tabHeight constant
                          margin: const EdgeInsets.only(bottom: 12),
                          color: Colors.transparent, // Hit test target
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              if (isActive)
                                Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                        color:
                                            AppColors.signalColor, // Active Dot
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.signalColor,
                                              blurRadius: 6)
                                        ])),
                              if (isActive) const SizedBox(width: 12),
                              Text(
                                widget.tabs[index]['title']
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: isActive
                                      ? FontWeight.w900
                                      : FontWeight.w500,
                                  letterSpacing: 1.2,
                                  color: isActive
                                      ? AppColors.textMain
                                      : AppColors.textMute,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  DarkModeToggle(onToggle: _toggleTheme, isDark: _isDark),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MeniscusGlassPainter extends CustomPainter {
  final double tabTop;
  final double tabHeight;
  final double tabWidth;
  final double curveRadius;
  final Offset mousePos;

  _MeniscusGlassPainter({
    required this.tabTop,
    required this.tabHeight,
    required this.tabWidth,
    required this.curveRadius,
    required this.mousePos,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          AppColors.crystalSurface.withValues(alpha: 0.65) // Transparent Liquid
      ..style = PaintingStyle.fill;

    // SUN REFRACTION PHYSICS
    // The cursor is the "Sun". Refraction (glow) happens on the OPPOSITE side.
    // Calculate the vector from Mouse(Sun) through Center to the opposite edge.
    final center = Offset(size.width / 2, size.height / 2);
    final toUnnormalized = center - mousePos;
    final dist = toUnnormalized.distance;
    final dir = dist > 0 ? toUnnormalized / dist : const Offset(1, 1);

    // Project the glow point to the far edge based on mouse position intensity
    final glowOffset = center + (dir * size.width * 0.6);

    // Dynamic Iridescence Shader
    paint.shader =
        ui.Gradient.linear(Offset(0, 0), Offset(size.width, size.height), [
      Colors.white.withValues(alpha: 0.5),
      const Color(0xFFF5F5FA).withValues(alpha: 0.3),
      const Color(0xFFE0E5FF).withValues(alpha: 0.2),
    ], [
      0.0,
      0.5,
      1.0
    ]);

    final path = Path();

    // CONSTANTS
    const double tabInternalRadius = 24.0;

    // 1. BUILD PATH (Continuous Meniscus)
    path.moveTo(size.width, 0);
    path.lineTo(tabWidth, 0);

    // Top Meniscus (Connection)
    // Smooth Bezier from Body Edge (x=tabWidth) down to Tab Top
    // Control point pushes slightly OUT into the tab area for a "liquid" feel
    path.lineTo(tabWidth, tabTop - curveRadius);
    path.cubicTo(
        tabWidth,
        tabTop - (curveRadius * 0.5), // Control 1
        tabWidth - (curveRadius * 0.5),
        tabTop, // Control 2
        tabWidth - curveRadius - 10,
        tabTop // End (pushed in)
        );

    // Tab Top Edge
    path.lineTo(tabInternalRadius, tabTop);

    // Tab Nose (Selection Indicator)
    path.arcToPoint(Offset(tabInternalRadius, tabTop + tabHeight),
        radius: const Radius.circular(tabInternalRadius), clockwise: false);

    // Tab Bottom Edge
    path.lineTo(tabWidth - curveRadius - 10, tabTop + tabHeight);

    // Bottom Meniscus (Connection)
    path.cubicTo(
        tabWidth - (curveRadius * 0.5),
        tabTop + tabHeight,
        tabWidth,
        tabTop + tabHeight + (curveRadius * 0.5),
        tabWidth,
        tabTop + tabHeight + curveRadius);

    // Continue Body
    path.lineTo(tabWidth, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    // 2. SHADOW (Deep Ambient Diffusion)
    canvas.drawShadow(
        path, AppColors.leverage1.withValues(alpha: 0.12), 50, true);

    // 3. FILL (Glass)
    canvas.drawPath(path, paint);

    // 4. OPPOSITE GLIMMER (The "Sun" Effect)
    // Radial gradient centered at the "Anti-Sun" position
    final glimmerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = ui.Gradient.radial(
          glowOffset,
          size.width * 0.7, // Large spread
          [
            Colors.white.withValues(alpha: 0.95), // Hotspot
            Colors.white.withValues(alpha: 0.4),
            Colors.white.withValues(alpha: 0.0), // Fade out
          ],
          [
            0.0,
            0.2,
            1.0
          ])
      ..maskFilter =
          const MaskFilter.blur(BlurStyle.normal, 4.0); // Soften the light

    // Clip to path key for border effect
    canvas.save();
    canvas.clipPath(path);
    canvas.drawPath(
        path, glimmerPaint); // Draw stroke *inside* clip? No, usually center.
    // Actually, simply drawing the stroke with the masked shader works well for borders.
    canvas.restore();
    // Re-draw stroke on top to ensure visibility
    canvas.drawPath(path, glimmerPaint);

    // 5. INNER SPECULAR (The "Ice Block" Edge)
    final innerBorder = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.white.withValues(alpha: 0.15);
    canvas.drawPath(path, innerBorder);
  }

  @override
  bool shouldRepaint(covariant _MeniscusGlassPainter oldDelegate) {
    return oldDelegate.tabTop != tabTop || oldDelegate.mousePos != mousePos;
  }
}
