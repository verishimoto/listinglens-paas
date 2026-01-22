import 'package:flutter/material.dart';
import 'package:listing_lens_paas/shared/theme/obsidian_theme.dart';

class HubLayout extends StatelessWidget {
  const HubLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090b), // Deep Background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'THE HUB',
          style: ObsidianTheme.themeData.textTheme.labelLarge?.copyWith(
            color: const Color(0xFFF97316), // Signal Orange
            letterSpacing: 4.0,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white54),
            onPressed: () {
              // TODO: Sign Out
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'PORTFOLIO TRAJECTORY',
              style: ObsidianTheme.themeData.textTheme.bodyMedium?.copyWith(
                color: Colors.white38,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 16),

            // Velocity Chart Placeholder (Graphite Card)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF18181b), // Graphite
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: Center(
                child: Text(
                  'VELOCITY VISUALIZATION',
                  style: ObsidianTheme.themeData.textTheme.bodyMedium?.copyWith(
                    color: Colors.white24,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            Text(
              'AUDIT LOGS',
              style: ObsidianTheme.themeData.textTheme.bodyMedium?.copyWith(
                color: Colors.white38,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 16),

            // Audit Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                ),
                itemCount: 6, // Mock Data
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF18181b), // Graphite
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white10),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF97316)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: const Color(0xFFF97316)
                                          .withValues(alpha: 0.3)),
                                ),
                                child: Text(
                                  index % 2 == 0 ? 'SCORE: 42' : 'SCORE: 88',
                                  style: ObsidianTheme
                                      .themeData.textTheme.bodyMedium
                                      ?.copyWith(
                                    color: const Color(0xFFF97316),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '2h ago',
                                style: ObsidianTheme
                                    .themeData.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: Colors.white24,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'Listing_${100 + index}.jpg',
                            style: ObsidianTheme.themeData.textTheme.labelLarge
                                ?.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
