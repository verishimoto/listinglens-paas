import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:listing_lens_paas/features/core_system/side_menu.dart';
import 'package:listing_lens_paas/features/core_system/lab_view.dart';
import 'package:listing_lens_paas/features/core_system/hub_view.dart';
import 'package:listing_lens_paas/features/shared/visual_flux/liquid_glass_card.dart';
import 'package:listing_lens_paas/features/shared/visual_flux/iridescent_border.dart';

// --- SOLID FUSION SHELL (Lighter, Web-Optimized) ---
// --- SOLID FUSION SHELL (v11.7) ---
class EpsilonShell extends StatefulWidget {
  const EpsilonShell({super.key});

  @override
  State<EpsilonShell> createState() => _EpsilonShellState();
}

class _EpsilonShellState extends State<EpsilonShell> {
  String _activeTab = 'lab';
  int _activeSlideIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030304), // Deep Void Background
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400, maxHeight: 900),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. BRAND HEADER (Minimal)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 24.0),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(
                              color: const Color(0xFFFF5100), width: 4),
                          bottom: BorderSide(
                              color: const Color(0xFFFF5100), width: 4),
                        )),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LISTINGLENS",
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFFFF5100),
                                  letterSpacing: -0.5)),
                          Text("EPSILON SHELL 11.7",
                              style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white.withValues(alpha: 0.4),
                                  letterSpacing: 2.0)),
                        ],
                      ),
                    ],
                  ),
                ),

                // 2. SOLID FUSION ENTITY
                Expanded(
                  child: IridescentBorder(
                    borderRadius: 24.0,
                    isReactive: true,
                    child: LiquidGlassCard(
                      child: Row(
                        children: [
                          // A. Sidebar
                          SideMenu(
                            activeTab: _activeTab,
                            activeIndex: _activeSlideIndex,
                            onTabChange: (tab) =>
                                setState(() => _activeTab = tab),
                            onSelect: (index) =>
                                setState(() => _activeSlideIndex = index),
                          ),

                          // B. Divider
                          Container(
                              width: 1,
                              color: Colors.white.withValues(alpha: 0.1)),

                          // C. Content Area
                          Expanded(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _activeTab == 'hub'
                                  ? const HubView()
                                  : LabView(
                                      activeSlideIndex: _activeSlideIndex),
                            ),
                          ),
                        ],
                      ),
                    ),
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
