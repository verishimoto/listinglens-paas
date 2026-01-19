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
        color: AppColors.voidColor.withOpacity(0.3),
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
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
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.signalColor : Colors.transparent,
              width: 3,
            ),
          ),
          color: isActive ? Colors.white.withOpacity(0.05) : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            // Slide Number
            Text(
              '0${index + 1}',
              style: TextStyle(
                fontFamily: 'Agency FB', // Assuming available or fallback
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isActive ? AppColors.signalColor : AppColors.textMute,
              ),
            ),
            const SizedBox(width: 12),
            // Label
            Text(
              tabs[index]['title'].toString().toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w900 : FontWeight.w500,
                letterSpacing: 1.5,
                color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
