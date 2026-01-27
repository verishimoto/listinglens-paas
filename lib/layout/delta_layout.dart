import 'package:flutter/material.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';
import 'package:listing_lens_paas/core/theme/app_theme.dart';
import 'package:listing_lens_paas/features/delta/delta_dashboard.dart';
import 'package:listing_lens_paas/features/delta/delta_lab.dart';
import 'package:listing_lens_paas/features/delta/delta_hub.dart';

class DeltaLayout extends StatefulWidget {
  const DeltaLayout({super.key});

  @override
  State<DeltaLayout> createState() => _DeltaLayoutState();
}

class _DeltaLayoutState extends State<DeltaLayout> {
  String _activeTab = 'lab';
  bool _isDark = true;

  void _switchTab(String tab) {
    setState(() => _activeTab = tab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: Stack(
        children: [
          // 1. FLUID BACKGROUND
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    _isDark
                        ? const Color(0xFF1A0B2E)
                        : Colors.blue.withValues(alpha: 0.1),
                    _isDark ? Colors.black : Colors.white,
                  ],
                ),
              ),
            ),
          ),

          // 2. MAIN CONVERGENCE SHELL
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  _buildEpsilonHeader(),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Row(
                      children: [
                        _buildEpsilonTabs(),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              ),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              ),
                              child: Stack(
                                children: [
                                  const Positioned.fill(
                                    child: LiquidGlass(
                                      borderRadius: 0,
                                      blurSigma: 40,
                                      hasBorder: false,
                                      child: SizedBox.expand(),
                                    ),
                                  ),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 400),
                                    child: _buildActiveContent(),
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }

  Widget _buildEpsilonHeader() {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary, AppTheme.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "L",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "LISTINGLENS",
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    "LIQUID GLASS v4.0",
                    style: TextStyle(
                      fontSize: 10,
                      // opacity: 0.5, // This property is not available on TextStyle directly.
                      color:
                          Colors.white54, // Using a color with opacity instead.
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () => setState(() => _isDark = !_isDark),
            icon: Icon(
              _isDark ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEpsilonTabs() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          bottomLeft: Radius.circular(32),
        ),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
        child: Column(
          children: [
            _EpsilonTab(
              title: "Hero Cover",
              index: 1,
              isActive: _activeTab == 'lab',
              onTap: () => _switchTab('lab'),
            ),
            _EpsilonTab(
              title: "Performance Hub",
              index: 2,
              isActive: _activeTab == 'hub',
              onTap: () => _switchTab('hub'),
            ),
            _EpsilonTab(
              title: "Ecosystem Dashboard",
              index: 3,
              isActive: _activeTab == 'dash',
              onTap: () => _switchTab('dash'),
            ),
          ],
        ),
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
}

class _EpsilonTab extends StatelessWidget {
  final String title;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  const _EpsilonTab({
    required this.title,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4, right: -1),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.05) : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: isActive
              ? Border.all(color: Colors.white.withOpacity(0.15))
              : Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            Text(
              "0$index",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isActive ? AppTheme.primary : Colors.white24,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? Colors.white : Colors.white38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
