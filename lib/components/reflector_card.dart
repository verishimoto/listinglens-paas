import 'package:flutter/material.dart';

class ReflectorCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double borderRadius;
  final Color baseColor;

  const ReflectorCard({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius = 24.0,
    this.baseColor = const Color(0xFF18181B),
  });

  @override
  State<ReflectorCard> createState() => _ReflectorCardState();
}

class _ReflectorCardState extends State<ReflectorCard> {
  final ValueNotifier<Offset> _mousePos = ValueNotifier(Offset.zero);
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      onHover: (event) {
        _mousePos.value = event.localPosition;
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: widget.baseColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 40,
                      offset: const Offset(0, 10),
                    )
                  ]
                : [],
          ),
          child: Stack(
            children: [
              // Content
              widget.child,

              // Reflector Border
              if (_isHovering)
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _ReflectorPainter(
                        mousePos: _mousePos,
                        borderRadius: widget.borderRadius,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReflectorPainter extends CustomPainter {
  final ValueNotifier<Offset> mousePos;
  final double borderRadius;

  _ReflectorPainter({required this.mousePos, required this.borderRadius})
      : super(repaint: mousePos);

  @override
  void paint(Canvas canvas, Size size) {
    // Defines the "Flashlight" gradient
    final paint = Paint()
      ..shader = RadialGradient(
        center: Alignment(
          (mousePos.value.dx / size.width) * 2 - 1,
          (mousePos.value.dy / size.height) * 2 - 1,
        ),
        radius: 0.5, // 300px roughly
        colors: [
          Colors.white.withOpacity(0.8),
          const Color(0xFF00C7FF).withOpacity(0.3), // Accent Cyan
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _ReflectorPainter oldDelegate) => true;
}
