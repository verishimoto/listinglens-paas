import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class GlassTabBar extends StatelessWidget {
  final List<Map<String, dynamic>> tabs;
  final int activeIndex;
  final Function(int) onTabSelected;

  const GlassTabBar({
    super.key,
    required this.tabs,
    required this.activeIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: const Border(
            bottom: BorderSide(color: Color(0xFFE0E0E0))), // Panel boundary
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              // [SOCRATIC UPDATE]: Asymmetric padding (Right: 48) forces the last item
              // to "bleed" or be cut off, triggering the user's instinct to scroll.
              // This satisfies the Detective's "Bleed Rule".
              padding: const EdgeInsets.only(left: 24, right: 48),
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                final isActive = activeIndex == index;
                return _buildTab(context, index, isActive);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, int index, bool isActive) {
    // Detective's Iridescent Palette
    final gradient = LinearGradient(
      colors: const [
        Color(0xFFFFDAB9), // Soft Peach
        Color(0xFFE6E6FA), // Lavender
        Color(0xFF87CEEB), // Sky Blue
        Color(0xFFF0FFF0), // Mint Shimmer
      ],
      stops: const [0.0, 0.3, 0.6, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                isActive ? Colors.white.withOpacity(0.05) : Colors.transparent,
            border: isActive
                ? null
                : const Border(
                    bottom: BorderSide(color: Colors.transparent, width: 2)),
          ),
          child: Stack(
            children: [
              // 1. Apple-style 1px Border (Clamped) with Iridescent Shader if Active
              // 1. BOOTSTRAP LOGIC: Active Tab has borders on Top/Left/Right but NO Bottom
              // This makes it visually "merge" with the panel content below.
              if (isActive)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(
                          0xFFF5F5FA), // Match Scaffold Background (merged)
                      border: Border(
                        top: BorderSide.none, // Handled by gradient
                        left: BorderSide(color: Colors.black.withOpacity(0.05)),
                        right:
                            BorderSide(color: Colors.black.withOpacity(0.05)),
                        bottom: BorderSide.none, // SEAMLESS MERGE
                      ),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          gradient: gradient,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                )
              else
                // Inactive tabs just hover
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: Container(
                      height: 1, color: Colors.transparent), // Placeholder
                ),

              // 2. Content
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '0${index + 1}',
                      style: TextStyle(
                        fontFamily: 'Agency FB',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isActive
                            ? AppColors.signalColor
                            : AppColors.textMute,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      tabs[index]['title'].toString().toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isActive ? FontWeight.w900 : FontWeight.w500,
                        letterSpacing: 1.5,
                        color:
                            isActive ? AppColors.textMain : AppColors.textMute,
                        shadows: isActive
                            ? [
                                // "Crystal" requires a subtle colorful glow, not just white
                                Shadow(
                                    color: const Color(0xFFE0E7FF),
                                    blurRadius: 8),
                              ]
                            : [],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
