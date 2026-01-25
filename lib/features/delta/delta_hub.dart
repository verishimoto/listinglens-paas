import 'package:flutter/material.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';
import 'package:listing_lens_paas/core/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class DeltaHub extends StatelessWidget {
  const DeltaHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("PERFORMANCE HUB",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                  letterSpacing: -1,
                  color: Colors.white)),
          const SizedBox(height: 48),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildPerformancePanel(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 2,
                  child: _buildFeedPanel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformancePanel() {
    return LiquidGlass(
      borderRadius: 32,
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("PREDICTED SELLABILITY ROI",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: AppTheme.primary,
                    letterSpacing: 4)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("92.4",
                    style: GoogleFonts.outfit(
                        fontSize: 120,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        letterSpacing: -5)),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text("%",
                      style: GoogleFonts.outfit(
                          fontSize: 40,
                          fontWeight: FontWeight.w200,
                          color: Colors.white24)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
                "*This is a probabilistic model based on heuristic alignment, not a financial guarantee.",
                textAlign: TextAlign.center,
                style: GoogleFonts.ebGaramond(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.white24)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("INTELLIGENCE LOG",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white38,
                letterSpacing: 2)),
        const SizedBox(height: 24),
        _buildLogItem(
            "ListingLens AI", "Optimized Hero Cover for Protocol 01.", true),
        _buildLogItem("System", "Deployed Epsilon v4.0 UI.", false),
      ],
    );
  }

  Widget _buildLogItem(String user, String msg, bool isAI) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                isAI ? AppTheme.primary.withOpacity(0.2) : Colors.white10,
            radius: 12,
            child: Icon(isAI ? Icons.auto_awesome : Icons.person,
                size: 12, color: Colors.white38),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.white38)),
              Text(msg,
                  style: const TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}
