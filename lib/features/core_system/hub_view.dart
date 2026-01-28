import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listing_lens_paas/features/shared/visual_flux/liquid_components.dart';

class HubView extends StatelessWidget {
  const HubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. HEADER (Performance & ROI)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("THE ARCHIVE",
                      style: GoogleFonts.antonio(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -1.0)),
                  Text("Central Intelligence Feed. 12 Active Audits.",
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white.withValues(alpha: 0.5))),
                ],
              ),
              _buildROIWidget(),
            ],
          ),

          const SizedBox(height: 48),

          // 2. OPAL CARD GRID
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 1.4,
              children: [
                _buildOpalCard("Geometrica Bundle", "94.2", false),
                _buildOpalCard("Organic Textures", "88.1", false),
                _buildOpalCard("Neo-Brutalism UI", "98.5", false),
                _buildOpalCard("Vintage Logo Kit", "76.4", false),
                _buildOpalCard(
                    "Foliage Brushes", "LOCKED", true), // Premium Gate
                _buildOpalCard(
                    "Mockup Scene 04", "LOCKED", true), // Premium Gate
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildROIWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("GLOBAL ROI VELOCITY",
            style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF1CFF00),
                letterSpacing: 1.5)),
        Text("↗ 95.2",
            style: GoogleFonts.inter(
                fontSize: 64,
                fontWeight: FontWeight.w100,
                color: const Color(0xFF1CFF00),
                height: 1.0)),
      ],
    );
  }

  Widget _buildOpalCard(String title, String score, bool isLocked) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isLocked
                            ? Colors.red.withValues(alpha: 0.1)
                            : const Color(0xFF00C7FF).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(isLocked ? Icons.lock : Icons.grid_view,
                          color: isLocked
                              ? const Color(0xFFFF0055)
                              : const Color(0xFF00C7FF),
                          size: 20),
                    ),
                    Text(score,
                        style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isLocked
                                ? Colors.white.withValues(alpha: 0.2)
                                : Colors.white)),
                  ],
                ),
                const Spacer(),
                Text(title,
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(height: 8),
                Text(isLocked ? "PREMIUM ARCHIVE" : "LAST UPDATED: 2h AGO",
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withValues(alpha: 0.4),
                        letterSpacing: 1.0)),
              ],
            ),
          ),
          if (isLocked)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.black.withValues(alpha: 0.6),
                  backgroundBlendMode: BlendMode.darken,
                ),
                child: Center(
                  child: LiquidButton(
                    label: "UNLOCK PRO",
                    onTap: () {},
                    isPrimary: false,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
