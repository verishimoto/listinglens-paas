import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class GlassTabBar extends StatefulWidget {
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
  State<GlassTabBar> createState() => _GlassTabBarState();
}

class _GlassTabBarState extends State<GlassTabBar> {
  int? _hoverIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 1. THE RAIL (Panel Border Line)
          // Placed at the bottom. Active tabs will sit ON TOP of this z-index to hide it.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 1,
              color: const Color(0xFFE0E0E0),
            ),
          ),

          // 2. THE TABS (Piano Keys)
          // We use a ListView to allow scrolling if needed, but centering is better for "Piano" feel.
          // Let's stick to ListView for safety but centered.
          ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: widget.tabs.length,
            itemBuilder: (context, index) {
              final isActive = widget.activeIndex == index;
              final isHovering = _hoverIndex == index;
              return _buildTab(index, isActive, isHovering);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, bool isActive, bool isHovering) {
    // Detective's Iridescent Palette (Subtle & Premium)
    final gradient = LinearGradient(
      colors: const [
        Color(0xFFFFDAB9), // Peach
        Color(0xFFE6E6FA), // Lavender
        Color(0xFF87CEEB), // Sky
        Color(0xFFF0FFF0), // Mint
      ],
      stops: const [0.0, 0.3, 0.6, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hoverIndex = index),
      onExit: (_) => setState(() => _hoverIndex = null),
      cursor: SystemMouseCursors.click, // "Click" cursor requested
      child: GestureDetector(
        onTap: () => widget.onTabSelected(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.only(right: 2), // Tiny gap between "keys"
          padding: const EdgeInsets.symmetric(horizontal: 24),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // Active: Opaque to cover the rail. Hover: Glassy. Inactive: Transparent.
            color: isActive
                ? const Color(0xFFF5F5FA) // Matches Panel Background
                : isHovering
                    ? Colors.white.withOpacity(0.5)
                    : Colors.transparent,

            // Border Logic:
            // Active: Top/Left/Right defined, Bottom REMOVED (Seamless).
            border: isActive
                ? Border(
                    top: BorderSide(color: Colors.black.withOpacity(0.05)),
                    left: BorderSide(color: Colors.black.withOpacity(0.05)),
                    right: BorderSide(color: Colors.black.withOpacity(0.05)),
                    bottom: BorderSide.none, // HIDDEN -> Merges with Panel
                  )
                : Border(
                    // Inactive: No border, or maybe a subtle bottom one to match rail?
                    // Transparent lets the Rail show through.
                    bottom: BorderSide(color: Colors.transparent, width: 1),
                  ),

            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),

            // Hover Glow (Framer Style)
            boxShadow: isHovering && !isActive
                ? [
                    BoxShadow(
                      color: const Color(0xFF87CEEB).withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    )
                  ]
                : [],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Active Indicator (Iridescent Line)
              if (isActive)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                  ),
                ),

              // Tab Label
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Index Number
                    Text(
                      '0${index + 1}',
                      style: TextStyle(
                        fontFamily: 'Agency FB',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isActive
                            ? AppColors.signalColor
                            : AppColors.textMute.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Title
                    Text(
                      widget.tabs[index]['title'].toString().toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isActive ? FontWeight.w900 : FontWeight.w500,
                        letterSpacing: 1.5,
                        color: isActive
                            ? AppColors.textMain
                            : isHovering
                                ? AppColors.textMain.withOpacity(0.8)
                                : AppColors.textMute,
                        // Active Glow
                        shadows: isActive
                            ? [
                                Shadow(
                                    color: const Color(0xFFE0E7FF),
                                    blurRadius: 10),
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
