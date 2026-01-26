import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class Archives extends StatelessWidget {
  const Archives({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: AppColors.leverage6.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(color: AppColors.leverage6.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HERITAGE ARCHIVE",
                style: TextStyle(
                  color: AppColors.leverage6,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "Universal store,\nBrazilian grit.",
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.0,
                  letterSpacing: -2.0,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.leverage6,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "\"Born from the Shopify RIP era, we deliver the gold standard in digital asset semiotics. Built on Brazilian grit and prompt engineering.\"",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.white.withValues(alpha: 0.6),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.leverage6,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("COPY BRAND BIO",
                      style: TextStyle(
                          fontWeight: FontWeight.w900, letterSpacing: 2.0)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
