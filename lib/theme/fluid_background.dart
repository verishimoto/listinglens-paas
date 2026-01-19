import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class FluidBackground extends StatefulWidget {
  const FluidBackground({super.key});

  @override
  State<FluidBackground> createState() => _FluidBackgroundState();
}

class _FluidBackgroundState extends State<FluidBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base Void
        Container(color: AppColors.voidColor),
        
        // Fluid Orbs
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: [
                _buildOrb(
                  alignment: Alignment(-0.5 + 0.2 * cos(_controller.value * 2 * pi), -0.5 + 0.2 * sin(_controller.value * 2 * pi)),
                  color: AppColors.signalColor.withOpacity(0.4),
                  radius: 400,
                ),
                _buildOrb(
                  alignment: Alignment(0.5 - 0.2 * sin(_controller.value * 2 * pi), -0.5 + 0.2 * cos(_controller.value * 2 * pi)),
                  color: const Color(0xFF00C7FF).withOpacity(0.4), // Cyan
                  radius: 350,
                ),
                _buildOrb(
                  alignment: Alignment(0.5 - 0.2 * cos(_controller.value * 2 * pi), 0.5 - 0.2 * sin(_controller.value * 2 * pi)),
                  color: const Color(0xFF7E00FF).withOpacity(0.4), // Indigo
                  radius: 450,
                ),
              ],
            );
          },
        ),

        // Blur Mesh
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            color: AppColors.voidColor.withOpacity(0.75), // Dark overlay
          ),
        ),
      ],
    );
  }

  Widget _buildOrb({required Alignment alignment, required Color color, required double radius}) {
    return Align(
      alignment: alignment,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
