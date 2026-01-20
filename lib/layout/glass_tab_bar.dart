import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class GlassTabBar extends StatefulWidget {
  final List<Map<String, dynamic>> tabs;
  final int activeIndex;
  final Function(int) onTabSelected;
  final bool isVertical;

  const GlassTabBar({
    super.key,
    required this.tabs,
    required this.activeIndex,
    required this.onTabSelected,
    this.isVertical = false,
    this.showIndex = true,
  });

  final bool showIndex;

  @override
  State<GlassTabBar> createState() => _GlassTabBarState();
}

class _GlassTabBarState extends State<GlassTabBar> {
  int? _hoverIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.isVertical ? 260 : null,
      height: widget.isVertical ? double.infinity : 60,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        alignment:
            widget.isVertical ? Alignment.centerRight : Alignment.bottomCenter,
        children: [
          // No Rail needed if we are fusing?
          // Actually, keeping a faint rail helps define the "spine".
          Positioned(
            right: widget.isVertical ? 0 : 0,
            top: widget.isVertical ? 0 : null,
            bottom: 0,
            left: widget.isVertical ? null : 0,
            child: Container(
              width: widget.isVertical ? 1 : null,
              height: widget.isVertical ? null : 1,
              color: Colors.black.withOpacity(0.05), // Subtle rail
            ),
          ),

          ListView.builder(
            scrollDirection:
                widget.isVertical ? Axis.vertical : Axis.horizontal,
            padding: widget.isVertical
                ? const EdgeInsets.symmetric(vertical: 24)
                : const EdgeInsets.symmetric(horizontal: 24),
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
    // 1. FUSION LOGIC
    // The Active Tab must be the EXACT same color as the Content Panel.
    final fusionColor = AppColors.crystalSurface
        .withOpacity(0.65); // Matches FusedGlassShell (Crystal)

    final hasIcon = widget.tabs[index].containsKey('icon');
    final IconData? icon =
        hasIcon ? widget.tabs[index]['icon'] as IconData : null;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoverIndex = index),
      onExit: (_) => setState(() => _hoverIndex = null),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onTabSelected(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,

          // FUSION GEOMETRY
          margin: widget.isVertical
              ? EdgeInsets.only(
                  bottom: 12, // Increased spacing between tabs
                  right: isActive
                      ? -32
                      : 0, // Deep Overlap: Pushes 32px INTO the content panel
                )
              : EdgeInsets.only(
                  right: 8,
                  bottom: isActive ? -1.5 : 0,
                ),

          height: widget.isVertical ? 64 : null, // Taller tabs
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          alignment:
              widget.isVertical ? Alignment.centerLeft : Alignment.center,
          decoration: BoxDecoration(
            color: isActive
                ? fusionColor // Shared Glass Color
                : isHovering
                    ? Colors.black.withOpacity(0.05)
                    : Colors.transparent,

            // CONDITIONAL BORDER:
            // If Active, we REMOVE the right border so it flows into the panel.
            border: isActive
                ? Border(
                    top: BorderSide(
                        color: Colors.white.withOpacity(0.5), width: 1),
                    left: BorderSide(
                        color: Colors.white.withOpacity(0.5), width: 1),
                    right: widget.isVertical
                        ? BorderSide.none // OPEN RIGHT SIDE (Fusion Gate)
                        : BorderSide(color: Colors.black.withOpacity(0.05)),
                    bottom: widget.isVertical
                        ? BorderSide(
                            color: Colors.white.withOpacity(0.5), width: 1)
                        : BorderSide.none,
                  )
                : Border.all(color: Colors.transparent),

            borderRadius: widget.isVertical
                ? const BorderRadius.horizontal(
                    left: Radius.circular(16)) // Smooth left
                : const BorderRadius.vertical(top: Radius.circular(12)),

            // FUSION GLOW:
            // This shadow must match the content panel's refraction to look like one object.
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.mellowCyan.withOpacity(0.2),
                      blurRadius: 30,
                      offset: const Offset(-10, 0), // Light source from right
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Indicator Dot (MellowPen Style)
              if (isActive && widget.showIndex)
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(
                      color: AppColors.mellowCyan, // Cyan Dot
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: AppColors.mellowCyan, blurRadius: 8)
                      ]),
                ),

              if (widget.showIndex)
                Text(
                  '0${index + 1}',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontFamilyFallback: const ['Inter'],
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: isActive ? AppColors.mellowCyan : AppColors.textMute,
                  ),
                ),
              if (widget.showIndex) const SizedBox(width: 12),

              if (hasIcon) ...[
                Icon(
                  icon,
                  size: 16,
                  color: isActive ? AppColors.textMain : AppColors.textMute,
                ),
                const SizedBox(width: 8),
              ],

              Text(
                widget.tabs[index]['title'].toString().toUpperCase(),
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontFamilyFallback: const ['Inter'],
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  letterSpacing: 1,
                  color: isActive ? AppColors.textMain : AppColors.textMute,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
