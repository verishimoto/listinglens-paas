import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class TheArena extends StatefulWidget {
  const TheArena({super.key});

  @override
  State<TheArena> createState() => _TheArenaState();
}

class _TheArenaState extends State<TheArena> {
  double _userPrice = 25.0;
  double _competitorPrice = 22.0;
  double _winProbability = 0.45; // 45% chance initially

  void _calculateWinProb() {
    setState(() {
      // Game Theory Logic:
      // If user price > competitor, win prob drops UNLESS quality is high (simulated).
      final priceDiff = _competitorPrice - _userPrice;
      // Base logic: closer price = closer 50/50.
      // Every $1 cheaper adds 5% win chance.
      _winProbability = 0.5 + (priceDiff * 0.05);
      _winProbability = _winProbability.clamp(0.1, 0.9);
    });
  }

  @override
  Widget build(BuildContext context) {
    // "Split View" - The Arena
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("THE ARENA",
                  style: TextStyle(
                      color: AppColors.leverage6,
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      letterSpacing: 2.0)),
              Text("SIMULATION MODE",
                  style: TextStyle(
                      color: Colors.white24,
                      fontWeight: FontWeight.bold,
                      fontSize: 10)),
            ],
          ),
          const SizedBox(height: 24),

          // Split Cards
          Row(
            children: [
              // User (YOU)
              Expanded(
                child: _buildCombatantCard(
                  title: "YOUR LISTING",
                  price: _userPrice,
                  isUser: true,
                  onPriceChange: (val) {
                    _userPrice = val;
                    _calculateWinProb();
                  },
                ),
              ),

              // VS Badge
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CircleAvatar(
                  backgroundColor: AppColors.leverage6,
                  radius: 16,
                  child: Text("VS",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 10)),
                ),
              ),

              // Competitor (GHOST)
              Expanded(
                child: _buildCombatantCard(
                  title: "ARCHETYPE: TRENDY UPSTART",
                  price: _competitorPrice,
                  isUser: false,
                  onPriceChange: (val) {}, // Competitor is static for now
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Tug of War Bar (Win Probability)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("WIN PROBABILITY",
                      style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  Text("${(_winProbability * 100).toInt()}%",
                      style: TextStyle(
                          color: _winProbability > 0.5
                              ? AppColors.leverage4
                              : AppColors.error,
                          fontWeight: FontWeight.w900,
                          fontSize: 14)),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: MediaQuery.of(context).size.width *
                          0.3 *
                          _winProbability, // rough width calc
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          AppColors.error,
                          _winProbability > 0.5
                              ? AppColors.leverage4
                              : AppColors.leverage6
                        ]),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _winProbability > 0.5
                    ? "PARETO EFFICIENT: Your value proposition exceeds the price delta."
                    : "CRITICAL PREDICTION: You are overpriced relative to the Archetype.",
                style: TextStyle(
                  color: _winProbability > 0.5
                      ? AppColors.leverage4
                      : AppColors.error,
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCombatantCard(
      {required String title,
      required double price,
      required bool isUser,
      required Function(double) onPriceChange}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUser
            ? AppColors.leverage2.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isUser
                ? AppColors.leverage2.withValues(alpha: 0.2)
                : Colors.transparent),
      ),
      child: Column(
        children: [
          Text(title,
              style: TextStyle(
                  color: isUser ? AppColors.leverage2 : Colors.white24,
                  fontWeight: FontWeight.bold,
                  fontSize: 10)),
          const SizedBox(height: 16),
          // Price Slider
          Text("\$${price.toStringAsFixed(0)}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900)),
          if (isUser)
            Slider(
              value: price,
              min: 10,
              max: 100,
              activeColor: AppColors.leverage2,
              onChanged: onPriceChange,
            ),
        ],
      ),
    );
  }
}
