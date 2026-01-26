import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

enum LiquidState { idle, analyzing, success, warning }

class LiquidBackground extends StatefulWidget {
  final LiquidState currentState;
  const LiquidBackground({super.key, this.currentState = LiquidState.idle});

  @override
  State<LiquidBackground> createState() => _LiquidBackgroundState();
}

class _LiquidBackgroundState extends State<LiquidBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 35), vsync: this)
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Reactive Logic: Cove Analysis (Designer Node)
  // "Emotional State Injection" -> Color Mapping at Runtime
  Color _getBlob1Color() {
    switch (widget.currentState) {
      case LiquidState.analyzing:
        return AppColors.leverage1; // Purple (Deep thought)
      case LiquidState.success:
        return AppColors.leverage4; // Green (Go)
      case LiquidState.warning:
        return AppColors.leverage6; // Orange (Alert)
      case LiquidState.idle:
        return AppColors.leverage2; // Cyan (Calm)
    }
  }

  Color _getBlob2Color() {
    switch (widget.currentState) {
      case LiquidState.analyzing:
        return AppColors.leverage2; // Cyan mix
      case LiquidState.success:
        return AppColors.leverage3; // Teal
      case LiquidState.warning:
        return AppColors.error; // Red
      case LiquidState.idle:
        return AppColors.leverage6; // Orange (Calm)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundDark, // #050505
      child: Stack(
        children: [
          // Blob 1: Top Left
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                top: -100 + (_controller.value * 50),
                left: -100 + (_controller.value * 100),
                child: AnimatedContainer(
                  duration: const Duration(
                      milliseconds: 1200), // Smooth emotional shift
                  child: _buildBlob(
                    width: 600,
                    height: 600,
                    color: _getBlob1Color(),
                    radius: 0.6,
                  ),
                ),
              );
            },
          ),

          // Blob 2: Bottom Right
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: -150 + (_controller.value * 80),
                right: -150 + ((1 - _controller.value) * 120),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  child: _buildBlob(
                    width: 550,
                    height: 550,
                    color: _getBlob2Color(),
                    radius: 0.65,
                  ),
                ),
              );
            },
          ),

          // The Diffuser (Global Blur)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlob(
      {required double width,
      required double height,
      required Color color,
      required double radius}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0.0)],
          stops: const [0.2, 1.0],
          radius: radius,
        ),
      ),
    );
  }
}
