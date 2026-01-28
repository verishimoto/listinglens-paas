import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:listing_lens_paas/features/core_system/lab_view.dart';
import 'package:listing_lens_paas/features/core_system/hub_view.dart';
import 'package:listing_lens_paas/features/shared/visual_flux/liquid_components.dart';

// --- LISTINGLENS V13.0 SHELL (Bicameral Architecture) ---
class EpsilonShell extends StatefulWidget {
  const EpsilonShell({super.key});

  @override
  State<EpsilonShell> createState() => _EpsilonShellState();
}

class _EpsilonShellState extends State<EpsilonShell> {
  // Routes: 'lab' (Default) | 'hub'
  String _activeRoute = 'lab';
  bool _isDarkMode = true; // Theme State

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030304), // Deep Void
      body: Column(
        children: [
          // 1. GLOBAL HEADER (Persistent)
          _buildGlobalHeader(),

          // 2. THE VIEWPORT (Dynamic)
          Expanded(
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _activeRoute == 'hub'
                    ? const HubView() // The Archive
                    : LabView(
                        activeSlideIndex: 0) // The Engine (Reset to 0 for now)
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlobalHeader() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: const Color(0xFF030304),
        border: Border(
            bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // A. LOGO (Left)
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFF5100), width: 3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    color: const Color(0xFFFF5100),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("LISTINGLENS",
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFFF5100),
                          letterSpacing: -0.5)),
                  Text("V13.0 BICAMERAL",
                      style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withValues(alpha: 0.4),
                          letterSpacing: 2.0)),
                ],
              ),
            ],
          ),

          // B. MENU (Center-Right)
          Row(
            children: [
              _buildMenuLink("THE LAB", "lab", Icons.science),
              const SizedBox(width: 48),
              _buildMenuLink("THE HUB", "hub", Icons.grid_view),
            ],
          ),

          // C. SETTINGS (Right)
          Row(
            children: [
              // Theme Toggle
              Row(
                children: [
                  Icon(Icons.dark_mode,
                      size: 14, color: Colors.white.withValues(alpha: 0.4)),
                  const SizedBox(width: 8),
                  LiquidToggle(
                    value: _isDarkMode,
                    onChanged: (val) => setState(() => _isDarkMode = val),
                  ),
                ],
              ),
              const SizedBox(width: 32),
              // User Avatar with Settings Dropdown (Placeholder for now)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                      colors: [Color(0xFF7E00FF), Color(0xFF00C7FF)]),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: const Icon(Icons.person, size: 20, color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMenuLink(String label, String id, IconData icon) {
    final isActive = _activeRoute == id;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _activeRoute = id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isActive
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(icon,
                  size: 16,
                  color: isActive
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.4)),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isActive
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.4),
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
