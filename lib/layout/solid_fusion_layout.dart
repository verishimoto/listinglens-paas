import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/components/repulsion_background.dart';
import 'package:listing_lens_paas/layout/fused_glass_shell.dart';
import 'package:listing_lens_paas/features/lab/lab_view.dart';
import 'package:listing_lens_paas/features/hub/hub_view.dart';
import 'package:listing_lens_paas/layout/glass_tab_bar.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';

class SolidFusionLayout extends StatefulWidget {
  const SolidFusionLayout({super.key});

  @override
  State<SolidFusionLayout> createState() => _SolidFusionLayoutState();
}

class _SolidFusionLayoutState extends State<SolidFusionLayout> {
  String _activeView = 'lab';
  int _activeSlide = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      "id": 1,
      "title": "Hero Cover",
      "role": "Primary Impact",
      "check": "Visual dominance anchor <1.2s."
    },
    {
      "id": 2,
      "title": "Flat Proof",
      "role": "QA",
      "check": "Alpha integrity & 300 DPI."
    },
    {
      "id": 3,
      "title": "Video Retention",
      "role": "SEO",
      "check": "Loop physics optimization."
    },
    {
      "id": 4,
      "title": "Technical Specs",
      "role": "Data",
      "check": "4500px compliance."
    },
    {
      "id": 5,
      "title": "Lifestyle Fit",
      "role": "Proof",
      "check": "Fabric deformation realism."
    },
    {
      "id": 6,
      "title": "Packaging",
      "role": "UX",
      "check": "Topology transparency."
    },
    {
      "id": 7,
      "title": "Licensing",
      "role": "Revenue",
      "check": "Commercial upsell logic."
    },
    {
      "id": 8,
      "title": "Quick Start",
      "role": "Retention",
      "check": "Onboarding friction."
    },
  ];

  final List<bool> _slideStatus = List.filled(8, false);
  String? _mountedImage;

  void _toggleView(String view) {
    setState(() => _activeView = view);
  }

  void _onSlideComplete(int index) {
    setState(() {
      _slideStatus[index] = true;
    });
  }

  void _mountImage(String path) {
    setState(() {
      _mountedImage = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepSpace, // DARK MODE BASE
      body: Stack(
        children: [
          // 1. PHYSICS (Reverse Repulsion)
          const Positioned.fill(child: RepulsionBackground()),

          // 2. SHELL
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Center(
                  child: FusedGlassShell(
                    sidebarWidth: 260,
                    sidebar: GlassTabBar(
                      tabs: _slides,
                      activeIndex: _activeSlide,
                      onTabSelected: (index) {
                        setState(() {
                          _activeSlide = index;
                          if (_activeView != 'lab') _toggleView('lab');
                        });
                      },
                      isVertical: true,
                    ),
                    content: _activeView == 'lab'
                        ? Padding(
                            padding: const EdgeInsets.all(32),
                            child: LabView(
                              slide: _slides[_activeSlide],
                              isPassed: _slideStatus[_activeSlide],
                              mountedImage: _mountedImage,
                              onMount: _mountImage,
                              onAudit: () => _onSlideComplete(_activeSlide),
                            ),
                          )
                        : _buildHubView(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final headerTabs = [
      {'title': 'The Lab', 'id': 'lab', 'icon': Icons.science},
      {'title': 'Hub', 'id': 'hub', 'icon': Icons.grid_view},
    ];

    final activeIndex = headerTabs.indexWhere((t) => t['id'] == _activeView);

    return LiquidGlass(
        borderRadius: 0,
        blurSigma: 20,
        frostOpacity: 0.05,
        hasBorder: false,
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
          ),
          child: Row(
            children: [
              // LOGO
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                    border: Border(
                  left: BorderSide(color: AppColors.mellowOrange, width: 4),
                  bottom: BorderSide(color: AppColors.mellowCyan, width: 4),
                )),
              ),
              const SizedBox(width: 16),
              const Text('LISTINGLENS',
                  style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.white)),

              const Spacer(flex: 1),

              // NAV (Centered effectively)
              SizedBox(
                height: 60,
                child: GlassTabBar(
                  tabs: headerTabs,
                  activeIndex: activeIndex,
                  onTabSelected: (index) {
                    _toggleView(headerTabs[index]['id'] as String);
                  },
                  isVertical: false,
                  showIndex: false,
                ),
              ),

              const Spacer(flex: 2),

              // PRO BADGE
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.appleGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: AppColors.appleGreen.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            color: AppColors.appleGreen,
                            shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    const Text('PRO SYSTEM',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: AppColors.appleGreen)),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildNavBarItem(String label, String key, IconData icon) {
    final isActive = _activeView == key;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _toggleView(key),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color:
                isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: isActive
                ? Border.all(color: Colors.white.withOpacity(0.2))
                : null,
          ),
          child: Row(
            children: [
              Icon(icon,
                  size: 16, color: isActive ? Colors.white : Colors.white54),
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    color: isActive ? Colors.white : Colors.white54,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHubView() {
    return const HubView();
  }
}
