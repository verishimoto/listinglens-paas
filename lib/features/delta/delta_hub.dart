import 'package:flutter/material.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class DeltaHub extends StatelessWidget {
  const DeltaHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHubHeader(),
          const SizedBox(height: 48),
          Expanded(
            child: Row(
              children: [
                // LEFT: Performance Chart
                Expanded(
                  flex: 3,
                  child: _buildPerformancePanel(),
                ),
                const SizedBox(width: 32),
                // RIGHT: Project Feed
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

  Widget _buildHubHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("PERFORMANCE HUB",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
                    letterSpacing: -1,
                    color: Colors.white)),
            const SizedBox(height: 8),
            Text("Real-time market velocity and intelligence.",
                style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
          ],
        ),
        _buildProfileTile(),
      ],
    );
  }

  Widget _buildProfileTile() {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("ALEXANDER V.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white)),
            Text("PRO OPERATIVE",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    color: AppColors.leverage4)),
          ],
        ),
        const SizedBox(width: 16),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
                colors: [AppColors.leverage1, AppColors.leverage2]),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                  color: AppColors.leverage1.withValues(alpha: 0.3),
                  blurRadius: 10)
            ],
          ),
          child: const Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildPerformancePanel() {
    return LiquidGlass(
      borderRadius: 32,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("AUDIT VELOCITY",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white38,
                        letterSpacing: 2)),
                Text("+24% WEEKLY",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        color: AppColors.leverage4)),
              ],
            ),
            const Spacer(),
            // MOCK BARS
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBar(0.4),
                _buildBar(0.6),
                _buildBar(0.3),
                _buildBar(0.9),
                _buildBar(0.5),
                _buildBar(0.7),
                _buildBar(0.8),
              ],
            ),
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("MON",
                    style: TextStyle(fontSize: 10, color: Colors.white24)),
                Text("SUN",
                    style: TextStyle(fontSize: 10, color: Colors.white24)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(double height) {
    return Container(
      width: 24,
      height: 200 * height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.white.withValues(alpha: 0.1),
            AppColors.leverage2.withValues(alpha: 0.6)
          ],
        ),
        borderRadius: BorderRadius.circular(8),
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
        _buildLogItem("System", "Deployed Prototype Zeta v1.0.", false),
        _buildLogItem(
            "Alexander V.", "Mounted new asset for lifestyle audit.", false),
      ],
    );
  }

  Widget _buildLogItem(String user, String msg, bool isAI) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: isAI
                ? AppColors.leverage1.withValues(alpha: 0.2)
                : Colors.white10,
            radius: 12,
            child: Icon(isAI ? Icons.auto_awesome : Icons.person,
                size: 12, color: Colors.white38),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.white38)),
                Text(msg,
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
