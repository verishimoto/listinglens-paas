import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
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
                // Clip the blur to the custom shape (rough approximation or full rect if acceptable)
                // For exact path clipping, we'd need a BackdropFilter inside a ClipPath,
                // but usually Rect clip is fine for full-screen overlapping layers or specific regions.
                // However, since Meniscus is a complex shape, applying blur to the whole area might look boxy.
                // A better approach for "Glassmorphism" is to use BackdropFilter within a Stack layer that effectively covers the glass area.
                // Given the painter fills the whole screen (except the gap), we can blur the whole screen background or use a ClipPath.
                // Let's try blending it with the painter.
                // Actually, the simplest reliable way in Flutter for this "Tab Shell" which covers most of the right side:
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: CustomPaint(
                    painter: _MeniscusGlassPainter(
                      tabTop: activeTabTop,
                      tabHeight: tabHeight,
                      tabWidth: tabWidth,
                      curveRadius: connectionCurveRadius,
                      mousePos: _mousePos,
                    ),
                  ),
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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 24),
              itemCount: widget.tabs.length,
              itemBuilder: (context, index) {
                final isActive = widget.activeIndex == index;
                // Render text only, geometry is handled by painter
                return GestureDetector(
                  onTap: () => widget.onTabSelected(index),
                  child: Container(
                    height: tabHeight,
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
                                  color: AppColors.signalColor, // Active Dot
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.signalColor,
                                        blurRadius: 6)
                                  ])),
                        if (isActive) const SizedBox(width: 12),
                        Text(
                          widget.tabs[index]['title'].toString().toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight:
                                isActive ? FontWeight.w900 : FontWeight.w500,
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
      ..color = AppColors.crystalSurface.withOpacity(0.85) // Base Glass
      ..style = PaintingStyle.fill;

    // Shader for Iridescent Glow
    final rect = Offset.zero & size;
    paint.shader =
        ui.Gradient.linear(Offset.zero, Offset(size.width, size.height), [
      Colors.white.withOpacity(0.9),
      const Color(0xFFF5F5FA).withOpacity(0.8),
      const Color(0xFFE0E5FF).withOpacity(0.6),
    ], [
      0.0,
      0.5,
      1.0
    ]);

    final path = Path();

    // START: Top Right of Body
    path.moveTo(size.width, 0);
    path.lineTo(tabWidth, 0); // Top Left of Body (Gap Start)

    // TAB CONNECTION (Top)
    // Line down to tab top connection
    path.lineTo(tabWidth, tabTop - curveRadius);
    // Curve OUT to Tab
    path.quadraticBezierTo(
        tabWidth,
        tabTop, // Control Point (Corner)
        tabWidth - curveRadius,
        tabTop // End Point (Tab Top Edge start)
        );
    path.lineTo(20, tabTop); // Tab Left Edge (padded)

    // TAB NOSE (Rounded Left)
    path.arcToPoint(Offset(20, tabTop + tabHeight),
        radius: const Radius.circular(16), clockwise: false);

    // TAB CONNECTION (Bottom)
    path.lineTo(tabWidth - curveRadius, tabTop + tabHeight);
    // Curve IN to Body
    path.quadraticBezierTo(
        tabWidth,
        tabTop + tabHeight, // Control
        tabWidth,
        tabTop + tabHeight + curveRadius // End
        );

    // CONTINUE BODY
    path.lineTo(tabWidth, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    // DRAW SHADOW
    canvas.drawShadow(path, AppColors.mellowCyan.withOpacity(0.2), 30, true);

    // 4. DRAW FILL (Base Glass)
    canvas.drawPath(path, paint);

    // 5. STRONG REFRACTION (Inner Glow)
    final refractionPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = ui.Gradient.linear(
          Offset(0, tabTop), Offset(tabWidth, tabTop + tabHeight), [
        Colors.white.withOpacity(0.8),
        Colors.white.withOpacity(0.0),
        Colors.white.withOpacity(0.5),
      ], [
        0.0,
        0.5,
        1.0
      ]);
    canvas.drawPath(path, refractionPaint);

    // 6. IRIDESCENT RIM (Outer Stroke)
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..shader = ui.Gradient.sweep(Offset(size.width / 2, size.height / 2), [
        AppColors.mellowCyan.withOpacity(0.5),
        AppColors.mellowOrange.withOpacity(0.5),
        const Color(0xFF7E00FF).withOpacity(0.5),
        AppColors.mellowCyan.withOpacity(0.5),
      ], [
        0.0,
        0.3,
        0.7,
        1.0
      ]);
    canvas.drawPath(path, borderPaint);

    // 7. MOUSE GLOW (Overlay)
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.mellowCyan.withOpacity(0.4), // Stronger hover
          AppColors.mellowOrange.withOpacity(0.1),
          Colors.transparent
        ],
        stops: const [0.0, 0.5, 1.0],
        radius: 0.8,
      ).createShader(Rect.fromCircle(center: mousePos, radius: 500))
      ..blendMode = BlendMode.overlay;

    canvas.drawRect(rect, glowPaint);
  }

  @override
  bool shouldRepaint(covariant _MeniscusGlassPainter oldDelegate) {
    return oldDelegate.tabTop != tabTop || oldDelegate.mousePos != mousePos;
  }
}
