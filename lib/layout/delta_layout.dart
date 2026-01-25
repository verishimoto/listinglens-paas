import 'package:flutter/material.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/features/delta/delta_dashboard.dart';
import 'package:listing_lens_paas/features/delta/delta_lab.dart';
import 'package:listing_lens_paas/features/delta/delta_hub.dart';

class DeltaLayout extends StatefulWidget {
  const DeltaLayout({super.key});

  @override
  State<DeltaLayout> createState() => _DeltaLayoutState();
}

class _DeltaLayoutState extends State<DeltaLayout> {
  String _activeTab = 'lab'; // lab, hub, dash
  bool _isDark = true;

  void _switchTab(String tab) {
    setState(() => _activeTab = tab);
  }

  @override
  Widget build(BuildContext context) {
    final theme = _isDark ? _buildDarkTheme() : _buildLightTheme();

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Stack(
          children: [
            // 1. BACKGROUND MOTION (Simplified Liquid Engine)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.5,
                    colors: [
                      _isDark
                          ? AppColors.leverage1.withValues(alpha: 0.1)
                          : Colors.blue.withValues(alpha: 0.05),
                      _isDark ? Colors.black : Colors.white,
                    ],
                  ),
                ),
              ),
            ),

            // 2. MAIN SHELL
            SafeArea(
              child: Row(
                children: [
                  // RAIL / SIDEBAR
                  _buildSidebar(),

                  // CONTENT AREA
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: LiquidGlass(
                        borderRadius: 32,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: _buildActiveContent(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          _SidebarIcon(
            icon: Icons.science_outlined,
            label: "LAB",
            isActive: _activeTab == 'lab',
            onTap: () => _switchTab('lab'),
          ),
          const SizedBox(height: 32),
          _SidebarIcon(
            icon: Icons.hub_outlined,
            label: "HUB",
            isActive: _activeTab == 'hub',
            onTap: () => _switchTab('hub'),
          ),
          const SizedBox(height: 32),
          _SidebarIcon(
            icon: Icons.dashboard_customize_outlined,
            label: "DASH",
            isActive: _activeTab == 'dash',
            onTap: () => _switchTab('dash'),
          ),
          const Spacer(),
          // THEME TOGGLE
          IconButton(
            onPressed: () => setState(() => _isDark = !_isDark),
            icon: Icon(
                _isDark ? Icons.wb_sunny_outlined : Icons.nightlight_outlined),
            color: _isDark ? Colors.white30 : Colors.black26,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveContent() {
    switch (_activeTab) {
      case 'hub':
        return const DeltaHub(key: ValueKey('hub'));
      case 'dash':
        return const DeltaDashboard(key: ValueKey('dash'));
      default:
        return const DeltaLab(key: ValueKey('lab'));
    }
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF050505),
      primaryColor: AppColors.leverage6,
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: const Color(0xFFF5F5F7),
      primaryColor: AppColors.leverage6,
    );
  }
}

class _SidebarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarIcon({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          LiquidGlass(
            borderRadius: 16,
            blurSigma: isActive ? 10 : 0,
            frostOpacity: isActive ? 0.2 : 0,
            hasBorder: isActive,
            isIridescent: isActive,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isActive
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.transparent,
              ),
              child: Icon(
                icon,
                color: isActive ? AppColors.leverage6 : Colors.white38,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: isActive ? AppColors.leverage6 : Colors.white24,
            ),
          ),
        ],
      ),
    );
  }
}
