import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'dart:ui';

class DarkModeToggle extends StatefulWidget {
  final VoidCallback onToggle;
  final bool isDark;

  const DarkModeToggle({
    super.key,
    required this.onToggle,
    required this.isDark,
  });

  @override
  State<DarkModeToggle> createState() => _DarkModeToggleState();
}

class _DarkModeToggleState extends State<DarkModeToggle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onToggle,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 60,
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: _isHovered
                      ? Colors.white.withValues(alpha: 0.5)
                      : Colors.white.withValues(alpha: 0.2),
                ),
                boxShadow: [
                  if (_isHovered)
                    BoxShadow(
                      color: AppColors.leverage2.withValues(alpha: 0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    )
                ],
              ),
              child: Stack(
                alignment: Alignment.centerLeft, // Track alignment
                children: [
                  // SUN/MOON ICONS BACKGROUND
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(Icons.wb_sunny_rounded, size: 14, color: Colors.white38),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Icon(Icons.nightlight_round, size: 14, color: Colors.white38),
                      ),
                    ],
                  ),
                  
                  // MOVING KNOB
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.elasticOut,
                    alignment: widget.isDark ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isDark ? AppColors.leverage1 : AppColors.crystalSurface,
                         boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Icon(
                        widget.isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                        size: 14,
                        color: widget.isDark ? Colors.white : AppColors.leverage7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
