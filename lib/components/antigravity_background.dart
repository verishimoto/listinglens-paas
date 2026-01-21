import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'dart:math';

class AntigravityBackground extends StatefulWidget {
  const AntigravityBackground({super.key});

  @override
  State<AntigravityBackground> createState() => _AntigravityBackgroundState();
}

class _AntigravityBackgroundState extends State<AntigravityBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();
  Offset _mousePos = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();

    // Initialize Particles
    for (int i = 0; i < 150; i++) {
      _particles.add(_Particle(_random));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (e) => setState(() => _mousePos = e.position),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          _updateParticles();
          return CustomPaint(
            painter: _AntigravityPainter(
              animationValue: _controller.value,
              mousePos: _mousePos,
              particles: _particles,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }

  void _updateParticles() {
    // Determine screen size roughly for boundary checks (or assume normalized 0-1 and scale in painter)
    // Here we simulate simple physics updates
    for (var particle in _particles) {
      particle.update(_mousePos);
    }
  }
}

class _Particle {
  Offset position;
  Offset velocity;
  double size;
  double opacity;

  _Particle(Random random)
      : position = Offset(random.nextDouble(), random.nextDouble()),
        velocity = Offset((random.nextDouble() - 0.5) * 0.002,
            (random.nextDouble() - 0.5) * 0.002),
        size = random.nextDouble() * 3 + 1,
        opacity = random.nextDouble() * 0.5 + 0.1;

  void update(Offset mousePos) {
    position += velocity;

    // Wrap around logic (normalized coordinates 0..1)
    if (position.dx < 0) position = Offset(1, position.dy);
    if (position.dx > 1) position = Offset(0, position.dy);
    if (position.dy < 0) position = Offset(position.dx, 1);
    if (position.dy > 1) position = Offset(position.dx, 0);
  }
}

class _AntigravityPainter extends CustomPainter {
  final double animationValue;
  final Offset mousePos;
  final List<_Particle> particles;

  _AntigravityPainter({
    required this.animationValue,
    required this.mousePos,
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Base Gradient (Subtle Aurora)
    final rect = Offset.zero & size;
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFF8F9FF), // White-ish
          Color(0xFFEef2ff), // Very pale blue
        ],
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // 2. Orbital Blobs (Background visuals)
    // Gentle repulsion from mouse for blobs too
    final mouseDeltaX = (mousePos.dx - centerX) * 0.05;
    final mouseDeltaY = (mousePos.dy - centerY) * 0.05;

    _drawBlob(
      canvas,
      Offset(
        centerX + cos(animationValue * 2 * pi) * 200 - mouseDeltaX,
        centerY + sin(animationValue * 2 * pi) * 100 - mouseDeltaY,
      ),
      350,
      AppColors.mellowOrange.withOpacity(0.08),
    );

    _drawBlob(
      canvas,
      Offset(
        centerX + cos(animationValue * 2 * pi + 2) * 300 - mouseDeltaX * 1.5,
        centerY + sin(animationValue * 2 * pi + 2) * 200 - mouseDeltaY * 1.5,
      ),
      300,
      AppColors.mellowCyan.withOpacity(0.08),
    );

    _drawBlob(
      canvas,
      Offset(
        centerX + cos(animationValue * -1.5 * pi) * 400 + mouseDeltaX,
        centerY + sin(animationValue * -1.5 * pi) * 300 + mouseDeltaY,
      ),
      400,
      const Color(0xFF9747FF).withOpacity(0.05), // Soft Purple
    );

    // 3. Dust Particles (Antigravity)
    final particlePaint = Paint()..color = AppColors.textMute;

    for (var particle in particles) {
      // Scale normalized pos to screen size
      var pX = particle.position.dx * size.width;
      var pY = particle.position.dy * size.height;

      // Mouse Reaction: Repel or Attract
      // Let's do a localized repulsion field around the mouse
      final dx = pX - mousePos.dx;
      final dy = pY - mousePos.dy;
      final dist = sqrt(dx * dx + dy * dy);

      double renderX = pX;
      double renderY = pY;

      if (dist < 200) {
        // Simple easing away from mouse
        final force = (200 - dist) / 200;
        renderX += dx * force * 0.5;
        renderY += dy * force * 0.5;
      }

      particlePaint.color =
          AppColors.textMain.withOpacity(particle.opacity * 0.6);
      canvas.drawCircle(Offset(renderX, renderY), particle.size, particlePaint);
    }
  }

  void _drawBlob(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, color.withOpacity(0)],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _AntigravityPainter oldDelegate) => true;
}
