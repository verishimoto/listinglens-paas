import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/features/shared/visual_flux/refractive_cursor_wrapper.dart';

class LiquidGlassCard extends StatefulWidget {
  final Widget child;
  final double width;
  final double? height;
  final VoidCallback? onTap;

  const LiquidGlassCard({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height,
    this.onTap,
  });

  @override
  State<LiquidGlassCard> createState() => _LiquidGlassCardState();
}

class _LiquidGlassCardState extends State<LiquidGlassCard>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _liftAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 150),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _liftAnimation = Tween<double>(begin: 0.0, end: -4.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(PointerEvent details) {
    setState(() => _isHovering = true);
    _controller.forward();
    VisualFlux.onEnter();
  }

  void _onExit(PointerEvent details) {
    setState(() => _isHovering = false);
    _controller.reverse();
    VisualFlux.onExit();
  }

  @override
  Widget build(BuildContext context) {
    // VISUAL TOKENS from Whisperer Deck Recon
    final Color borderColor = _isHovering
        ? Colors.white.withValues(alpha: 0.35)
        : Colors.white.withValues(alpha: 0.15);

    // The Deep Purple Glow found in recon: rgba(168,85,247,0.15)
    // AppColors.leverage1 is 0xFF7E00FF (Indigo). We approximate the recon purple.
    final Color glowColor =
        AppColors.leverage1.withValues(alpha: _isHovering ? 0.25 : 0.0);

    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      cursor: SystemMouseCursors
          .click, // Will be overridden by custom cursor logic later
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _liftAnimation.value),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: borderColor, width: 1.5),
                    // Glass Background Gradient
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha: 0.05),
                      ],
                    ),
                    boxShadow: [
                      // Deep Ambient Shadow
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 48,
                        offset: const Offset(0, 16),
                      ),
                      // Iridescent Glow (Reactive)
                      BoxShadow(
                        color: glowColor,
                        blurRadius: 60,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      // "Liquid" Blur + Saturation
                      filter: ImageFilter.compose(
                        outer: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        inner: ColorFilter.mode(
                            Colors.white.withValues(alpha: 0.1),
                            BlendMode.overlay), // Saturation hack
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
