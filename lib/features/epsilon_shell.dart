import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/features/lab/the_lab.dart';
import 'package:listing_lens_paas/features/hub/the_hub.dart';

// --- SOLID FUSION SHELL (Lighter, Web-Optimized) ---
class EpsilonShell extends StatefulWidget {
  const EpsilonShell({super.key});

  @override
  State<EpsilonShell> createState() => _EpsilonShellState();
}

class _EpsilonShellState extends State<EpsilonShell> {
  String _activeTab = 'lab';
  // Mock Data for Lab

  @override
  Widget build(BuildContext context) {
    // 1. THE WORKSPACE (Deep Background)
    return Scaffold(
      backgroundColor: const Color(0xFF050507),
      body: Row(
        children: [
          // 2. THE FUSION TAB (Navigation)
          _buildFusionTab(),

          // 3. THE FUSION PANEL (Content)
          Expanded(
            child: _buildFusionPanel(),
          ),
        ],
      ),
    );
  }

  Widget _buildFusionTab() {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0C).withOpacity(0.9),
        border: Border(
          right: BorderSide(color: Colors.white.withOpacity(0.08), width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          // BRAND
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: AppColors.leverage2, // Cyan
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.leverage2.withOpacity(0.5),
                            blurRadius: 10)
                      ]),
                ),
                const SizedBox(width: 12),
                Text("PLAYBOOK",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 20)),
              ],
            ),
          ),
          const SizedBox(height: 60),

          // NAV ITEMS
          _buildNavItem('The Lab', 'lab'),
          _buildNavItem('The Hub', 'hub'),
          _buildNavItem('Archive', 'archive'),

          const Spacer(),
          // Dark Mode Toggle Mock
          Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode",
                    style: Theme.of(context).textTheme.bodyMedium),
                Icon(Icons.toggle_on, color: Colors.white, size: 28),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String id) {
    final bool active = _activeTab == id;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = id),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          border: active
              ? Border(left: BorderSide(color: AppColors.leverage2, width: 3))
              : null,
          color: active ? Colors.white.withOpacity(0.05) : Colors.transparent,
        ),
        child: Text(
          label.toUpperCase(),
          style: active
              ? Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 14) // Impact
              : Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildFusionPanel() {
    // Content Switcher
    Widget content;
    switch (_activeTab) {
      case 'lab':
        // Simplified Lab for Fusion View
        break;
      case 'hub':
        content = const TheHub();
        break;
      default:
        content = Center(
          child: Text("ARCHIVE LOCKED",
              style: Theme.of(context).textTheme.displayLarge),
        );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 24, 24, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F14).withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40), // Fusion shape
        ),
        border: Border.all(color: Colors.white.withOpacity(0.08), width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: content,
      ),
    );
  }
}
