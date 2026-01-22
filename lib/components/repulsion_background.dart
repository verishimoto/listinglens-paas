import 'dart:math';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class RepulsionBackground extends StatefulWidget {
  const RepulsionBackground({super.key});

  @override
  State<RepulsionBackground> createState() => _RepulsionBackgroundState();
}

class _RepulsionBackgroundState extends State<RepulsionBackground>
    with SingleTickerProviderStateMixin {
  final List<Particle> _blobs = [];
  final List<Particle> _dots = [];
  final Random random = Random();
  Offset mousePosition = Offset.zero;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_blobs.isEmpty && _dots.isEmpty) {
      final size = MediaQuery.of(context).size;
      // CREATE PARTICLES AND BLOBS
      for (int i = 0; i < 60; i++) {
        bool isBlob = i < 5; // First 5 are large blobs
        final particle = Particle(
          x: random.nextDouble() * size.width,
          y: random.nextDouble() * size.height,
          radius: isBlob
              ? random.nextDouble() * 200 + 100
              : random.nextDouble() * 4 + 2,
          color: isBlob
              ? (i % 2 == 0 ? AppColors.mellowCyan : AppColors.mellowOrange)
              : Colors.white,
          isBlob: isBlob,
          velocity:
              Offset(random.nextDouble() - 0.5, random.nextDouble() - 0.5),
        );

        if (isBlob) {
          _blobs.add(particle);
        } else {
          _dots.add(particle);
        }
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent details) {
    setState(() {
      mousePosition = details.position;
    });
  }

  void _updateParticles(Size size) {
    // Combine lists for update logic, or update separately
    // Updating separately is fine
    for (var particle in [..._blobs, ..._dots]) {
      // Move
      particle.x += particle.velocity.dx * 0.5; // Drift
      particle.y += particle.velocity.dy * 0.5;

      // Wrap
      if (particle.x < -200) particle.x = size.width + 200;
      if (particle.x > size.width + 200) particle.x = -200;
      if (particle.y < -200) particle.y = size.height + 200;
      if (particle.y > size.height + 200) particle.y = -200;

      // Repulsion (Reverse Gravity)
      double dx = particle.x - mousePosition.dx;
      double dy = particle.y - mousePosition.dy;
      double distance = sqrt(dx * dx + dy * dy);
      double repulsionRadius = particle.isBlob ? 600.0 : 300.0;

      double targetX = particle.x;
      double targetY = particle.y;

      if (distance < repulsionRadius) {
        // Push away
        double force = (repulsionRadius - distance) / repulsionRadius;
        targetX += dx * force * 0.05;
        targetY += dy * force * 0.05;
      }

      particle.x += (targetX - particle.x) * 0.1;
      particle.y += (targetY - particle.y) * 0.1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      child: LayoutBuilder(builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            _updateParticles(Size(constraints.maxWidth, constraints.maxHeight));
            return CustomPaint(
              size: Size.infinite,
              painter: _RepulsionPainter(
                blobs: _blobs,
                dots: _dots,
              ),
            );
          },
        );
      }),
    );
  }
}

class Particle {
  double x;
  double y;
  double radius;
  Color color;
  Offset velocity;
  bool isBlob;

  Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.color,
    required this.velocity,
    this.isBlob = false,
  });
}

class _RepulsionPainter extends CustomPainter {
  final List<Particle> blobs;
  final List<Particle> dots;

  _RepulsionPainter({
    required this.blobs,
    required this.dots,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw Blobs First (Background)
    for (var particle in blobs) {
      _drawParticle(canvas, particle);
    }
    // 2. Draw Dots (Foreground)
    for (var particle in dots) {
      _drawParticle(canvas, particle);
    }
  }

  void _drawParticle(Canvas canvas, Particle particle) {
    final paint = Paint()
      ..color = particle.isBlob
          ? particle.color.withValues(alpha: 0.15)
          : particle.color.withValues(alpha: 0.3)
      ..maskFilter =
          MaskFilter.blur(BlurStyle.normal, particle.isBlob ? 100 : 0);

    canvas.drawCircle(Offset(particle.x, particle.y), particle.radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
