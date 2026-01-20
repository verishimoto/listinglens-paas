import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/theme/fluid_background.dart';
import 'package:listing_lens_paas/layout/meniscus_tab.dart';
import 'package:listing_lens_paas/features/lab/lab_view.dart';
import 'package:listing_lens_paas/features/hub/hub_view.dart';
import 'package:listing_lens_paas/layout/glass_tab_bar.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';
import 'package:listing_lens_paas/features/workflow_viz/workflow_screen.dart';

class SolidFusionLayout extends StatefulWidget {
  const SolidFusionLayout({super.key});

  @override
  State<SolidFusionLayout> createState() => _SolidFusionLayoutState();
}

class _SolidFusionLayoutState extends State<SolidFusionLayout> {
  String _activeView = 'lab'; // 'lab' or 'hub'
  int _activeSlide = 0;

  // Mock Data for Slides
  final List<Map<String, dynamic>> _slides = [
    {
      "id": 1,
      "title": "Hero Cover",
      "role": "Primary Impact",
      "check":
          "Visual dominance anchor. Must capture interest in <1.2s via thumb-stop semiotics."
    },
    {
      "id": 2,
      "title": "Flat Proof",
      "role": "Quality Assurance",
      "check":
          "Verification of alpha channel integrity and 300 DPI edge crispness."
    },
    {
      "id": 3,
      "title": "Video Retention",
      "role": "Motion SEO",
      "check":
          "Loop physics and engagement cues optimized for social discovery."
    },
    {
      "id": 4,
      "title": "Technical Specs",
      "role": "Data Integrity",
      "check":
          "Explicit 4500px square, 300 DPI compliance check for professional POD."
    },
    {
      "id": 5,
      "title": "Lifestyle Context",
      "role": "Social Proof",
      "check":
          "Fabric deformation and scale realism. Match environmental lighting."
    },
    {
      "id": 6,
      "title": "Packaging Structure",
      "role": "UX Delivery",
      "check": "Standard vs Commercial folder topology transparency."
    },
    {
      "id": 7,
      "title": "Licensing Tiers",
      "role": "Revenue Logic",
      "check": "Clear commercial upsell value proposition."
    },
    {
      "id": 8,
      "title": "Quick Start Guide",
      "role": "Retention",
      "check": "Frictionless onboarding guide. Digital download disclaimer."
    },
  ];

  List<bool> _slideStatus = List.filled(8, false);
  String? _mountedImage; // Null = Show Upload UI

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
      backgroundColor: Colors.transparent, // Let FluidBackground show
      body: Stack(
        children: [
          // 1. FLUID MOTION BACKGROUND (Full Screen)
          const Positioned.fill(child: FluidBackground()),

          // 2. MAIN LAYOUT GRID (Centered & Constrained)
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Column(
                children: [
                  // HEADER (Translucent)
                  _buildHeader(),

                  // LAB TABS (Visible only in Lab View)
                  if (_activeView == 'lab')
                    GlassTabBar(
                      tabs: _slides,
                      activeIndex: _activeSlide,
                      onTabSelected: (index) =>
                          setState(() => _activeSlide = index),
                    ),

                  // WORKSPACE
                  Expanded(
                    child: Row(
                      children: [
                        // MAIN CONTENT CANVAS
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 0), // Merge with tabs
                            decoration: BoxDecoration(
                              color: _activeView == 'lab'
                                  ? Colors.transparent
                                  : AppColors.structureColor,
                            ),
                            child: _activeView == 'lab'
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 24), // Space inside the panel
                                    child: LabView(
                                      slide: _slides[_activeSlide],
                                      isPassed: _slideStatus[_activeSlide],
                                      mountedImage: _mountedImage,
                                      onMount: _mountImage,
                                      onAudit: () =>
                                          _onSlideComplete(_activeSlide),
                                    ),
                                  )
                                : _buildHubView(),
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

  Widget _buildHeader() {
    return LiquidGlass(
        borderRadius: 0,
        blurSigma: 20,
        frostOpacity: 0.02,
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
                decoration: BoxDecoration(
                    border: Border(
                  left:
                      const BorderSide(color: AppColors.signalColor, width: 4),
                  bottom:
                      const BorderSide(color: AppColors.signalColor, width: 4),
                )),
              ),
              const SizedBox(width: 16),
              const Text('LISTINGLENS',
                  style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: AppColors.signalColor)),

              const SizedBox(width: 80),

              // TOP NAVIGATION (The Detective "View Toggles")
              _buildNavBarItem('THE LAB', 'lab', Icons.science),
              const SizedBox(width: 24),
              _buildNavBarItem('HUB', 'hub', Icons.grid_view),

              const Spacer(),

              // UTILS
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1CFF00).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: const Color(0xFF1CFF00).withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            color: Color(0xFF1CFF00), shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    const Text('PRO SYSTEM',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1CFF00))),
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
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ]
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
