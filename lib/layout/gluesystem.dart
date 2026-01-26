
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class GlueSystem {
  static Widget sidebarItem({
    required bool isActive,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isCleared,
  }) {
    // If active, we want to use the Liquid Glass "Blend" effect if possible.
    // However, blending requires both shapes to be in the same LiquidGlassBlendGroup.
    // Since the sidebar items are lists, putting them all in one group is tricky for layout.
    // We'll simulate the "Glue" using the specialized design but apply LiquidGlass to the active item.

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: isActive
              ? LiquidGlassLayer(
                  settings: const LiquidGlassSettings(
                    thickness: 20,
                    blur: 20,
                    glassColor: Color(0x1AFF7B02), // Slight Orange Tint
                    outlineIntensity: 0.2,
                  ),
                  child: LiquidGlass(
                     shape: LiquidRoundedSuperellipse(borderRadius: 12),
                     // Connect visual logic: Left border + Gradient
                     child: _buildItemContent(isActive, title, subtitle, isCleared),
                  ),
                )
              : _buildItemContent(isActive, title, subtitle, isCleared),
        ),
      ),
    );
  }

  static Widget _buildItemContent(bool isActive, String title, String subtitle, bool isCleared) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: isActive 
        ? BoxDecoration(
            border: Border(left: BorderSide(color: AppColors.leverage6, width: 4)),
             gradient: LinearGradient(
              colors: [
                AppColors.leverage6.withValues(alpha: 0.1),
                Colors.transparent,
              ],
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
    );
  }
}
