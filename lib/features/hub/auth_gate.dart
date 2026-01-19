import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/shared/theme/obsidian_theme.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background - Deep Void
          Container(color: Colors.black),
          
          // Spotlight Effect (Subtle Gradient)
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 400,
                  padding: const EdgeInsets.all(48),
                  decoration: ObsidianTheme.glassDecoration.copyWith(
                    color: Colors.white.withOpacity(0.03),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo / Brand
                      Text(
                        'LISTINGLENS',
                        style: ObsidianTheme.themeData.textTheme.labelLarge?.copyWith(
                          letterSpacing: 4.0,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'THE HUB',
                        style: ObsidianTheme.themeData.textTheme.bodyMedium?.copyWith(
                           color: const Color(0xFFF97316), // Signal Orange
                           letterSpacing: 6.0,
                           fontSize: 10,
                           fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 48),

                      // Sign In Button
                      _buildGlassButton(
                        label: 'ENTER THE VAULT',
                        onTap: () {
                          // TODO: Trigger Auth
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      Text(
                        'Professional Credentials Required',
                        style: ObsidianTheme.themeData.textTheme.bodyMedium?.copyWith(
                           fontSize: 10,
                           color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassButton({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF97316).withOpacity(0.1), // Orange Tint
          border: Border.all(
            color: const Color(0xFFF97316).withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: ObsidianTheme.themeData.textTheme.labelLarge?.copyWith(
               color: const Color(0xFFF97316),
               letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
