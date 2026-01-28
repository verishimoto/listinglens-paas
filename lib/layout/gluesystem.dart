import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class GlueSystem {
  static Widget sidebarItem({
    required bool isActive,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isCleared,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutQuart,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            decoration: isActive
                ? BoxDecoration(
                    // The "Glue" Logic:
                    // A subtle gradient background that fades to the right
                    gradient: LinearGradient(
                      colors: [
                        AppColors.leverage6.withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    // The "Hard" Glue Edge on the left
                    border: const Border(
                      left: BorderSide(color: AppColors.leverage6, width: 4),
                    ),
                  )
                : null,
            child: Row(
              children: [
                // Status Check
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCleared
                          ? AppColors.leverage4 // Green
                          : Colors.white.withValues(alpha: 0.2), // Dim
                      width: 2,
                    ),
                    color: isCleared ? AppColors.leverage4 : Colors.transparent,
                  ),
                  child: isCleared
                      ? const Icon(Icons.check, size: 12, color: Colors.black)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subtitle.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: Colors.white24,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isActive ? Colors.white : Colors.white70,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
