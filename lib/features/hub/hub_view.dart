import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';

class HubView extends StatelessWidget {
  const HubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('PERFORMANCE HUB', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: AppColors.textMain, height: 1)),
                  SizedBox(height: 8),
                  Text('Track velocity, intelligence logs, and strategy.', style: TextStyle(fontSize: 16, color: AppColors.textMute)),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('NEW AUDIT'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.signalColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                ),
              )
            ],
          ),
          
          const SizedBox(height: 48),

          // ROI WIDGET (Liquid Glass Upgrade)
          LiquidGlass(
            borderRadius: 32,
            blurSigma: 40,
            frostOpacity: 0.08,
            child: Container(
              padding: const EdgeInsets.all(40),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: const [
                           Text('ACTIVE ROI PREDICTION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2, color: AppColors.signalColor)),
                           SizedBox(height: 8),
                           Text('95.2%', style: TextStyle(fontSize: 64, fontWeight: FontWeight.w100, color: Colors.white, height: 1)),
                         ],
                       ),
                       Column(
                         children: const [
                           Text('CONFIDENCE LEVEL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2, color: AppColors.textMute)),
                           SizedBox(height: 4),
                           Text('High', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1CFF00))),
                         ],
                       )
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Progress Bar
                  Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2), // Darker trough for contrast
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.952,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(colors: [AppColors.signalColor, Color(0xFF1CFF00)])
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 48),
          
          // INTELLIGENCE LOG
          Expanded(
            child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Expanded(
                   child: _buildSection('ACTIVE PROJECTS', [
                     _buildListTile('Leo Zodiac Bundle', 'Creative Market', '92', true),
                     _buildListTile('Mystic Aura Pack', 'Etsy', '88', false),
                   ]),
                 ),
                 const SizedBox(width: 40),
                 Expanded(
                   child: _buildSection('INTELLIGENCE LOG', [
                     _buildLogItem('ListingLens AI', 'Initiated rigorous audit for \'Leo Zodiac Bundle\'.', true),
                     _buildLogItem('You', 'Adjusted Hero Cover based on heatmap feedback.', false),
                   ]),
                 ),
               ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.folder_open, size: 16, color: AppColors.textMute),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2, color: AppColors.textMute)),
          ],
        ),
        const SizedBox(height: 24),
        ...children.map((c) => Padding(padding: const EdgeInsets.only(bottom: 16), child: c)),
      ],
    );
  }

  Widget _buildListTile(String title, String platform, String score, bool isHigh) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Row(
             children: [
               Container(
                 width: 50, height: 50,
                 decoration: BoxDecoration(
                   color: isHigh ? const Color(0xFF1CFF00).withOpacity(0.2) : AppColors.signalColor.withOpacity(0.2),
                   borderRadius: BorderRadius.circular(16),
                 ),
                 child: Center(child: Text(score, style: TextStyle(fontWeight: FontWeight.bold, color: isHigh ? const Color(0xFF1CFF00) : AppColors.signalColor))),
               ),
               const SizedBox(width: 24),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                   const SizedBox(height: 4),
                   Text('$platform • 2d ago', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: AppColors.textMute, letterSpacing: 1)),
                 ],
               )
             ],
           ),
           const Icon(Icons.chevron_right, color: Colors.white24),
        ],
      ),
    );
  }

  Widget _buildLogItem(String user, String msg, bool isAI) {
     return Row(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
          CircleAvatar(
            backgroundColor: isAI ? const Color(0xFF7E00FF) : Colors.white10,
            radius: 16,
            child: Icon(isAI ? Icons.bolt : Icons.person, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textMute, letterSpacing: 1)),
                const SizedBox(height: 4),
                Text(msg, style: TextStyle(fontSize: 14, color: isAI ? Colors.white : Colors.white70, fontStyle: isAI ? FontStyle.italic : null)),
              ],
            ),
          )
       ],
     );
  }
}
