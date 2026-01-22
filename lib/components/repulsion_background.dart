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
  List<Particle> particles = [];
  final int particleCount = 60;
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
    if (particles.isEmpty) {
      final size = MediaQuery.of(context).size;
      // CREATE PARTICLES AND BLOBS
      for (int i = 0; i < particleCount; i++) {
        bool isBlob = i < 5; // First 5 are large blobs
        particles.add(Particle(
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
        ));
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size.infinite,
            painter: _RepulsionPainter(
              particles: particles,
              mousePosition: mousePosition,
            ),
          );
        },
      ),
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
  final List<Particle> particles;
  final Offset mousePosition;

  _RepulsionPainter({
    required this.particles,
    required this.mousePosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw Blobs First (Background)
    for (var particle in particles.where((p) => p.isBlob)) {
      _paintParticle(canvas, size, particle);
    }
    // 2. Draw Dots (Foreground)
    for (var particle in particles.where((p) => !p.isBlob)) {
      _paintParticle(canvas, size, particle);
    }
  }

  void _paintParticle(Canvas canvas, Size size, Particle particle) {
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

    // Paint
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
