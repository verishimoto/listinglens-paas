import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MeniscusTab extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isActive;
  final bool passed;
  final int index;
  final VoidCallback onTap;

  const MeniscusTab({
    super.key,
    required this.label,
    this.icon,
    required this.isActive,
    required this.passed,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The Meniscus Glue (Only when active)
        if (isActive)
          Positioned(
            top: -24,
            bottom: -24,
            right: -24, // Overlap into content
            width: 48,
            child: CustomPaint(
              painter: _MeniscusPainter(color: AppColors.structureColor),
            ),
          ),

        // The Tab Itself
        Padding(
          padding: const EdgeInsets.only(right: 24.0), // Space for glue
          child: InkWell(
            onTap: onTap,
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(30)),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isActive ? AppColors.structureColor : Colors.transparent,
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(30)),
                border: isActive
                    ? const Border(
                        left:
                            BorderSide(color: AppColors.signalColor, width: 4))
                    : null,
              ),
              child: Row(
                children: [
                  // Status Circle
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: passed ? AppColors.signalColor : null,
                      border: passed
                          ? null
                          : Border.all(
                              color: AppColors.textMain.withValues(alpha: 0.3),
                              width: 2),
                    ),
                    child: Center(
                      child: passed
                          ? const Icon(Icons.check,
                              size: 16, color: Colors.black)
                          : Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textMute,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      color: isActive ? AppColors.textMain : AppColors.textMute,
                      shadows: isActive
                          ? [
                              Shadow(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  blurRadius: 15)
                            ]
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MeniscusPainter extends CustomPainter {
  final Color color;

  _MeniscusPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    // Top Meniscus (Inverse Curve)
    path.moveTo(size.width, 0); // Top Right (inside content)
    path.lineTo(size.width, 24); // Start of curve
    path.arcToPoint(
      const Offset(0, 24),
      radius: const Radius.circular(24),
      clockwise: false,
    );
    path.lineTo(0, size.height - 24); // Bottom of tab body

    // Bottom Meniscus (Inverse Curve)
    path.arcToPoint(
      Offset(size.width, size.height), // Bottom Right (inside content)
      radius: const Radius.circular(24),
      clockwise: false,
    );

    // Close the shape to fill right side
    path.lineTo(size.width, 0);
    path.close();

    // Actually, we need to draw the "corners" that fill the gap
    // The previous logic was slightly inverse. Let's rethink based on the "glue".
    // We physically want to draw the *extensions* of the bg color above and below the tab.

    // Correct Logic:
    // We are drawing TWO shapes: The top corner filler and bottom corner filler.
    // BUT, the React CSS implementation uses `border-bottom-right-radius` on a pseudo element.
    // Let's emulate exactly that: Two blocks positioned absolute.

    // Since this painter is positioned covering the whole right edge + vertical bleed:

    // Top Glue
    final topPath = Path();
    topPath.moveTo(0, 24); // Start at tab top-right
    topPath.lineTo(size.width, 24); // Go right into content
    topPath.lineTo(size.width, 0); // Go up
    topPath.lineTo(0, 0); // Go left
    // Cut out the circle
    topPath.arcToPoint(
      Offset(size.width, 24),
      radius: const Radius.circular(24),
      clockwise: true,
    );
    // Wait, arcToPoint draws the line TO the point.
    // Let's use a simpler approach: Draw the Rect, cut the Arc.

    // Easier: Draw the inverse curve strokes.
    // Or just Draw the shape that *connects*.

    // Let's stick to the React logic:
    // .meniscus-top { background: transparent; border-bottom-right-radius: 30px; box-shadow: 10px 10px 0 0 var(--solid-panel); }
    // This uses box-shadow to fill the color.

    // In Flutter, we can just draw the path directly.

    // Top Meniscus Shape
    final topCurve = Path();
    topCurve.moveTo(0, 24);
    topCurve.quadraticBezierTo(
        size.width * 0.5, 24, size.width, 0); // Ease out?
    // No, standard inverse rounded corner:
    topCurve.reset();
    topCurve.moveTo(0, 0);
    topCurve.lineTo(size.width, 0); // Top Right
    topCurve.lineTo(size.width, 24); // Bottom Right of top block
    topCurve.arcToPoint(const Offset(0, 0),
        radius: const Radius.circular(24), clockwise: false);
    topCurve.close();
    // This draws a concave shape? No.

    // Let's just draw the "filled" parts.
    // Top Glue Part
    canvas.drawPath(
      Path()
        ..moveTo(0, 24)
        ..lineTo(size.width, 24)
        ..lineTo(size.width, 0) // Go up to "content" top
        ..arcToPoint(const Offset(0, 24),
            radius: const Radius.circular(24), clockwise: false)
        ..close(),
      paint,
    );

    // Bottom Glue Part
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height - 24)
        ..lineTo(size.width, size.height - 24)
        ..lineTo(size.width, size.height) // Go down
        ..arcToPoint(Offset(0, size.height - 24),
            radius: const Radius.circular(24),
            clockwise: true) // Clockwise? No.
        // From (width, height) to (0, height-24) via curve.
        ..close(),
      paint,
    );

    // Wait, the bottom curve direction:
    // We are at (width, height). We want to arc to (0, height-24).
    // The center of circle is at (0, height).
    // So clockwise is correct? No, counter-clockwise from right to top.

    final bottomPath = Path();
    bottomPath.moveTo(size.width, size.height - 24);
    bottomPath.lineTo(size.width, size.height);
    bottomPath.lineTo(0, size.height - 24); // Diagonal? No.

    // Let's try drawing a rectangle and subtracting the circle.
    // Top: Rect(0,0, w, 24). Mask out Circle at (0,0) radius 24.
    // Bottom: Rect(0, h-24, w, 24). Mask out Circle at (0, h) radius 24.

    // Actually, simple path drawing is best.

    // TOP WEDGE
    var path1 = Path();
    path1.moveTo(0, 0);
    path1.lineTo(size.width, 0);
    path1.lineTo(size.width, 24);
    path1.arcToPoint(const Offset(0, 0),
        radius: const Radius.circular(24), clockwise: false);
    path1.close();
    // Invert y for top (wait, my y coords above assumed local block for top glue)

    // Let's paint the "Top Meniscus"
    // Ideally this custom painter should be sized 30x30.
    // But here I sized it width=48, height=full tab + bleed.

    // Reshaping to match React exactly:
    // Top Wedge:
    canvas.drawPath(
      Path()
        ..moveTo(size.width, 24)
        ..lineTo(size.width, 0)
        ..lineTo(0, 0) // Top Left of glue area
        // Draw arc from (0,0) to (size.width, 24)? No.
        // We want the curve to be transparent, and the rest colored.
        // The curve creates the "rounded inner corner".

        // Correct Shape:
        // Start Top Left (0,0), go Top Right (w,0), go Down (w, 24)
        // Arc back to Top Left.
        ..arcToPoint(const Offset(0, 0),
            radius: const Radius.circular(24), clockwise: false)
        ..close(),
      paint,
    );

    // Bottom Wedge
    canvas.drawPath(
      Path()
        ..moveTo(size.width, size.height - 24)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..arcToPoint(Offset(size.width, size.height - 24),
            radius: const Radius.circular(24), clockwise: false)
        ..close(),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
