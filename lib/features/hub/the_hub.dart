import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class TheHub extends StatelessWidget {
  const TheHub({super.key});

  @override
  Widget build(BuildContext context) {
    final assets = [
      {"rank": "#1", "name": "Leo Cyber-Zodiac Elite", "score": "99.1"},
      {"rank": "#2", "name": "Kinetic Flow Abstract", "score": "96.4"},
      {"rank": "#3", "name": "Brazilian Grit Heritage", "score": "94.2"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "BRANDING HUB",
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -2.0,
          ),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: ListView.builder(
            itemCount: assets.length,
            itemBuilder: (context, index) {
              final item = assets[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.white.withValues(alpha: 0.1))),
                ),
                child: Row(
                  children: [
                    Text(
                      item['rank']!,
                      style: const TextStyle(
                        color: AppColors.leverage6,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: Text(
                        item['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.leverage4.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        "SCORE ${item['score']}",
                        style: const TextStyle(
                          color: AppColors.leverage4,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
