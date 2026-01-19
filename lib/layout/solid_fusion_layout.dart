import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/theme/fluid_background.dart';
import 'package:listing_lens_paas/layout/meniscus_tab.dart';
import 'package:listing_lens_paas/features/lab/lab_view.dart';
import 'package:listing_lens_paas/features/hub/hub_view.dart';

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
    {"id": 1, "title": "Hero Cover", "role": "Primary Impact", "check": "Visual dominance anchor. Must capture interest in <1.2s via thumb-stop semiotics."},
    {"id": 2, "title": "Flat Proof", "role": "Quality Assurance", "check": "Verification of alpha channel integrity and 300 DPI edge crispness."},
    {"id": 3, "title": "Video Retention", "role": "Motion SEO", "check": "Loop physics and engagement cues optimized for social discovery."},
    {"id": 4, "title": "Technical Specs", "role": "Data Integrity", "check": "Explicit 4500px square, 300 DPI compliance check for professional POD."},
    {"id": 5, "title": "Lifestyle Context", "role": "Social Proof", "check": "Fabric deformation and scale realism. Match environmental lighting."},
    {"id": 6, "title": "Packaging Structure", "role": "UX Delivery", "check": "Standard vs Commercial folder topology transparency."},
    {"id": 7, "title": "Licensing Tiers", "role": "Revenue Logic", "check": "Clear commercial upsell value proposition."},
    {"id": 8, "title": "Quick Start Guide", "role": "Retention", "check": "Frictionless onboarding guide. Digital download disclaimer."},
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
          // 1. FLUID MOTION BACKGROUND
          const Positioned.fill(child: FluidBackground()),

          // 2. MAIN LAYOUT GRID
          Column(
            children: [
              // HEADER (Translucent)
              _buildHeader(),

              // WORKSPACE
              Expanded(
                child: Row(
                  children: [
                    // LEFT SIDEBAR (Meniscus)
                    SizedBox(
                      width: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // View Toggles
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 32, 40, 32),
                            child: Row(
                              children: [
                                _buildViewToggle('The Lab', 'lab'),
                                const SizedBox(width: 16),
                                _buildViewToggle('Performance Hub', 'hub'),
                              ],
                            ),
                          ),

                          // SIDEBAR CONTENT
                          Expanded(
                            child: _activeView == 'lab' 
                              ? _buildLabSidebar()
                              : _buildHubSidebar(),
                          ),
                        ],
                      ),
                    ),

                    // RIGHT CONTENT CANVAS (Solid Panel)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: _activeView == 'lab' ? 0 : 24),
                        decoration: const BoxDecoration(
                          color: AppColors.structureColor, // Solid Fusion Panel
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.black54, blurRadius: 40, offset: Offset(-10, 0))
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: _activeView == 'lab'
                            ? LabView(
                                slide: _slides[_activeSlide],
                                isPassed: _slideStatus[_activeSlide],
                                mountedImage: _mountedImage,
                                onMount: _mountImage,
                                onAudit: () => _onSlideComplete(_activeSlide),
                              )
                            : const HubView(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
        color: AppColors.voidColor.withOpacity(0.5), // Semi-transparent
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LOGO AREA
          Row(
            children: [
               Container(
                 width: 40, height: 40,
                 decoration: BoxDecoration(
                   border: Border(
                     left: const BorderSide(color: AppColors.signalColor, width: 8),
                     bottom: const BorderSide(color: AppColors.signalColor, width: 8),
                     top: BorderSide(color: AppColors.signalColor.withOpacity(0), width: 0), // transparent
                     right: BorderSide(color: AppColors.signalColor.withOpacity(0), width: 0),
                   )
                 ),
               ),
               const SizedBox(width: 24),
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: const [
                   Text('LISTINGLENS', style: TextStyle(fontFamily: 'Agency FB', fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1, color: AppColors.signalColor)),
                   Text('HIGH FIDELITY PROTOTYPE 3.0', style: TextStyle(fontSize: 10, letterSpacing: 3, fontWeight: FontWeight.bold, color: AppColors.textMute)),
                 ],
               )
            ],
          ),
          
          // UTILS
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF1CFF00), shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    const Text('PRO PLAN ACTIVE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF1CFF00))),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildViewToggle(String label, String viewKey) {
    final isActive = _activeView == viewKey;
    return GestureDetector(
      onTap: () => _toggleView(viewKey),
      child: Container(
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: isActive ? AppColors.signalColor : Colors.transparent, width: 2))
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  Widget _buildLabSidebar() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 40),
      itemCount: _slides.length,
      itemBuilder: (context, index) {
        return MeniscusTab(
          index: index,
          label: _slides[index]['title'],
          isActive: _activeSlide == index,
          passed: _slideStatus[index],
          onTap: () => setState(() => _activeSlide = index),
        );
      },
    );
  }

  Widget _buildHubSidebar() {
    // Simplified menu for Hub
    final items = ['Market Pulse', 'Portfolio', 'Intelligence Log', 'Settings'];
    return Padding(
      padding: const EdgeInsets.only(right: 32),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          children: items.map((item) => ListTile(
            title: Text(item, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            trailing: const Icon(Icons.chevron_right, color: Colors.white24, size: 16),
            contentPadding: EdgeInsets.zero,
            onTap: () {},
          )).toList(),
        ),
      ),
    );
  }
}
