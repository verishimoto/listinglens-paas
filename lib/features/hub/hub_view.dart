import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';

class HubView extends StatelessWidget {
  const HubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 48, right: 48, top: 24, bottom: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER & PROFILE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'PERFORMANCE ',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontFamilyFallback: ['Inter', 'Roboto'],
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: AppColors.leverage7, // Black
                            letterSpacing: -1,
                          ),
                        ),
                        TextSpan(
                          text: 'HUB',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontFamilyFallback: ['Inter', 'Roboto'],
                            fontSize: 32,
                            fontWeight: FontWeight.w100,
                            color: AppColors.leverage1, // Purple
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Velocity tracking and market intelligence.',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textMute,
                          fontFamily: 'Inter')),
                ],
              ),

              // PROFILE SVG / AVATAR
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('ALEXANDER V.',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.leverage7)),
                      SizedBox(height: 4),
                      Text('PRO TIER',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: AppColors.leverage4)), // Neon Green
                    ],
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.leverage2,
                          AppColors.leverage1
                        ], // Cyan -> Purple
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.leverage1.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4)),
                      ],
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: 40),

          // VELOCITY GRAPH (Custom Paint) & ROI
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. VELOCITY GRAPH
                Expanded(
                  flex: 3,
                  child: LiquidGlass(
                    borderRadius: 24,
                    blurSigma: 30,
                    frostOpacity: 0.05,
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('AUDIT VELOCITY',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                      color: AppColors.textMute)),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.leverage4.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text('+24% THIS WEEK',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.leverage4)),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // GRAPH BARS
                          SizedBox(
                            height: 150,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildBar(0.4),
                                _buildBar(0.6),
                                _buildBar(0.3),
                                _buildBar(0.8),
                                _buildBar(0.5),
                                _buildBar(0.9, isActive: true),
                                _buildBar(0.7),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('MON',
                                  style: TextStyle(
                                      fontSize: 10, color: AppColors.textMute)),
                              Text('TUE',
                                  style: TextStyle(
                                      fontSize: 10, color: AppColors.textMute)),
                              Text('WED',
                                  style: TextStyle(
                                      fontSize: 10, color: AppColors.textMute)),
                              Text('THU',
                                  style: TextStyle(
                                      fontSize: 10, color: AppColors.textMute)),
                              Text('FRI',
                                  style: TextStyle(
                                      fontSize: 10, color: AppColors.textMute)),
                              Text('SAT',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.leverage1,
                                      fontWeight: FontWeight.bold)),
                              Text('SUN',
                                  style: TextStyle(
                                      fontSize: 10, color: AppColors.textMute)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // 2. ROI CARD
                Expanded(
                  flex: 2,
                  child: LiquidGlass(
                    borderRadius: 24,
                    blurSigma: 30,
                    frostOpacity: 0.05,
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('PREDICTED ROI',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color: AppColors.textMute)),
                          const SizedBox(height: 16),
                          const Text('\$4,290',
                              style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.leverage7,
                                  letterSpacing: -1)),
                          const SizedBox(height: 8),
                          const Row(
                            children: [
                              Icon(Icons.trending_up,
                                  color: AppColors.leverage4, size: 20),
                              SizedBox(width: 8),
                              Text('High Confidence',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.leverage4)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Mini Gradient Line
                          Container(
                            height: 4,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              gradient: const LinearGradient(colors: [
                                AppColors.leverage1,
                                AppColors.leverage2
                              ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // INTELLIGENCE LOG
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildSection('ACTIVE PROJECTS', [
                    _buildListTile(
                        'Leo Zodiac Bundle', 'Creative Market', '92', true),
                    _buildListTile('Mystic Aura Pack', 'Etsy', '88', false),
                  ]),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: _buildSection('INTELLIGENCE LOG', [
                    _buildLogItem(
                        'ListingLens AI',
                        'Initiated rigorous audit for \'Leo Zodiac Bundle\'.',
                        true),
                    _buildLogItem(
                        'You',
                        'Adjusted Hero Cover based on heatmap feedback.',
                        false),
                  ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBar(double heightFactor, {bool isActive = false}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: heightFactor),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Container(
          width: 12,
          height: 150 * value,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.leverage1
                : AppColors.leverage2
                    .withOpacity(0.2), // Purple active, Cyan passive
            borderRadius: BorderRadius.circular(4),
            boxShadow: isActive
                ? [
                    BoxShadow(
                        color: AppColors.leverage1.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 2))
                  ]
                : [],
          ),
        );
      },
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.grid_view, size: 14, color: AppColors.textMute),
            const SizedBox(width: 8),
            Text(title,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: AppColors.textMute,
                    fontFamily: 'Inter')),
          ],
        ),
        const SizedBox(height: 16),
        ...children.map((c) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: c)),
      ],
    );
  }

  Widget _buildListTile(
      String title, String platform, String score, bool isHigh) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4), // Glassy white
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.8)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isHigh
                        ? AppColors.leverage4.withOpacity(0.1)
                        : AppColors.leverage6.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                      child: Text(score,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isHigh
                                  ? AppColors.leverage4
                                  : AppColors.leverage6))),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.leverage7)),
                    const SizedBox(height: 2),
                    Text(platform,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: AppColors.textMute)),
                  ],
                )
              ],
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.arrow_forward_ios,
                  size: 12, color: AppColors.textMute),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogItem(String user, String msg, bool isAI) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: isAI
              ? AppColors.leverage1.withOpacity(0.1)
              : AppColors.leverage7.withOpacity(0.05),
          radius: 14,
          child: Icon(isAI ? Icons.auto_awesome : Icons.person,
              size: 14, color: isAI ? AppColors.leverage1 : AppColors.textMute),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMute)),
              const SizedBox(height: 2),
              Text(msg,
                  style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.leverage7,
                      fontFamily: 'Inter',
                      height: 1.4)),
            ],
          ),
        )
      ],
    );
  }
}
