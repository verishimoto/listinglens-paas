import 'package:flutter/material.dart';
import 'dart:math' as math;

class OpalGem extends StatefulWidget {
  final double size;
  final bool isActive;
  const OpalGem({super.key, this.size = 100, this.isActive = true});

  @override
  State<OpalGem> createState() => _OpalGemState();
}

class _OpalGemState extends State<OpalGem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
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
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _GemPainter(
            rotation: _controller.value * 2 * math.pi,
            isActive: widget.isActive,
          ),
        );
      },
    );
  }
}

class _GemPainter extends CustomPainter {
  final double rotation;
  final bool isActive;
  _GemPainter({required this.rotation, required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;
    final path = Path();

    // Octagonal Gem Shape
    for (int i = 0; i < 8; i++) {
      double angle = (i * 45) * math.pi / 180 + (rotation * 0.2);
      double x = center.dx + radius * math.cos(angle);
      double y = center.dy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Base Color (Opal/Cyan)
    final paint = Paint()
      ..shader = RadialGradient(
        colors: isActive
            ? [Colors.cyanAccent, Colors.blueAccent, Colors.purpleAccent]
            : [Colors.grey, Colors.blueGrey],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Facet Lines
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 8; i++) {
      double angle = (i * 45) * math.pi / 180 + (rotation * 0.2);
      double x = center.dx + radius * math.cos(angle);
      double y = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), linePaint);
    }

    // Glow
    if (isActive) {
      canvas.drawCircle(
          center,
          radius,
          Paint()
            ..color = Colors.cyanAccent.withValues(alpha: 0.1)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20));
    }
  }

  @override
  bool shouldRepaint(covariant _GemPainter oldDelegate) => true;
}
