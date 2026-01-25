import 'package:flutter/material.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class DeltaDashboard extends StatelessWidget {
  const DeltaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("DASHBOARD",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 48,
                  letterSpacing: -2,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Text("Unified intelligence oversight.",
              style: TextStyle(
                  fontSize: 18, color: Colors.white.withValues(alpha: 0.4))),

          const SizedBox(height: 48),

          // STAT CARDS
          Row(
            children: [
              _buildStatCard("ACTIVE AUDITS", "12", Icons.science_outlined,
                  AppColors.leverage6),
              const SizedBox(width: 24),
              _buildStatCard("PREDICTED ROI", "\$4.2K", Icons.trending_up,
                  AppColors.leverage4),
              const SizedBox(width: 24),
              _buildStatCard("EQUITY GAP", "18%", Icons.pie_chart_outline,
                  AppColors.leverage1),
            ],
          ),

          const SizedBox(height: 48),

          // SUMMARY PANELS
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildQuickActionPanel(),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildSystemStatusPanel(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color accent) {
    return Expanded(
      child: LiquidGlass(
        borderRadius: 24,
        isIridescent: true,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: accent, size: 24),
              const SizedBox(height: 24),
              Text(value,
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
              Text(label,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Colors.white24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("QUICK ACTIONS",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white38,
                letterSpacing: 2)),
        const SizedBox(height: 24),
        _buildActionItem("Launch Protocol Zeta",
            "Interactive deployment for primary assets.", Icons.rocket_launch),
        _buildActionItem(
            "Run Heatmap AI",
            "Visual fixation prediction on current gallery.",
            Icons.visibility_outlined),
        _buildActionItem("Sync Market Data",
            "Fetch latest Creative Market performance.", Icons.sync),
      ],
    );
  }

  Widget _buildActionItem(String title, String desc, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: LiquidGlass(
        borderRadius: 20,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.02),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white38),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white)),
                    Text(desc,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.white24)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 12, color: Colors.white10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSystemStatusPanel() {
    return LiquidGlass(
      borderRadius: 24,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.leverage1.withValues(alpha: 0.05),
          border: Border.all(color: AppColors.leverage1.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("SYSTEM HEALTH",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.leverage1,
                    letterSpacing: 2)),
            const SizedBox(height: 24),
            _buildStatusRow("CORE ENGINE", "OPTIMAL"),
            _buildStatusRow("LIQUID RENDER", "STABLE"),
            _buildStatusRow("GEMINI API", "CONNECTED"),
            const SizedBox(height: 24),
            const Text("Last Sync: 2m ago",
                style: TextStyle(fontSize: 10, color: Colors.white10)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, String status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 10, color: Colors.white38)),
          Text(status,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.leverage4)),
        ],
      ),
    );
  }
}
