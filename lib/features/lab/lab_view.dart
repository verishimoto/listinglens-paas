import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';
import 'dart:ui';

class LabView extends StatelessWidget {
  final Map<String, dynamic> slide;
  final bool isPassed;
  final String? mountedImage;
  final VoidCallback onMount;
  final VoidCallback onAudit;

  const LabView({
    super.key,
    required this.slide,
    required this.isPassed,
    required this.mountedImage,
    required this.onMount,
    required this.onAudit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05),
      child: Column(
        children: [
          // 1. PROTOCOL HEADER (Liquid Glass)
          Padding(
            padding: const EdgeInsets.all(24),
            child: LiquidGlass(
              borderRadius: 24,
              child: Container(
                padding: const EdgeInsets.all(32),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Phoenix Protocol: V-Align
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          slide['role'].toString().toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.textMain,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                                color: AppColors.signalColor,
                                shape: BoxShape.circle)), // Dot
                        const SizedBox(width: 16),
                        Text(
                          'PROTOCOL 0${slide['id']}',
                          style: const TextStyle(
                            color: AppColors.textMute,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      slide['check'],
                      style: const TextStyle(
                        fontSize: 56, // Omega: Hero Size
                        fontWeight: FontWeight.w900,
                        height: 1.0,
                        letterSpacing: -2,
                        color: AppColors.textMain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
  
          // 2. CANVAS AREA
          Expanded(
            child: Center(
              child:
                  mountedImage != null ? _buildWorkArea() : _buildMountAssetUI(),
            ),
          ),
  
          // ...
          // ...
  }

  Widget _buildMountAssetUI() {
    return GestureDetector(
      onTap: onMount,
      child: Container(
        width: 600,
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white.withOpacity(0.1), width: 1, style: BorderStyle.none), // Dashed border implied or just subtle
          // Omega: Dashed border simulation or just glass drop zone
          color: Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Omega: Glowing Mount Button
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7E00FF), Color(0xFF4A00E0)], // Indigo Gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFF7E00FF).withOpacity(0.5),
                      blurRadius: 60,
                      spreadRadius: -5,
                      offset: const Offset(0, 10)),
                  BoxShadow(
                      color: Colors.white.withOpacity(0.2), // Inner light
                      blurRadius: 0,
                      spreadRadius: 1, // Border simulation
                      offset: Offset.zero
                  )
                ],
              ),
              child: const Icon(Icons.add, size: 60, color: Colors.white),
            ),
            // ...
          ],
        ),
      ),
    );
  }

  Widget _buildWorkArea() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter( // Omega: True Refraction
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 800,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4), // More transparent for refraction
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: Colors.white.withOpacity(0.1), width: 1),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 50,
                  offset: const Offset(0, 10)),
            ],
          ),
          child: Stack(
          alignment: Alignment.center,
          children: [
            // Grid Overlay
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Image.network(
                    'https://grainy-gradients.vercel.app/noise.svg',
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) =>
                        const SizedBox()), // Fallback noise if possible, or just ignore
              ),
            ),

            const Icon(Icons.hub,
                size: 80,
                color:
                    Colors.white10), // Changed icon to represent 'Processing'

            if (isPassed)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black.withOpacity(0.8), // Darken background
                  ),
                  child: Stack(
                    children: [
                      // BLURRED CONTENT (The "Why")
                      // We simulate a detailed report that is obfuscated
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFakeReportLine(width: 200),
                              const SizedBox(height: 12),
                              _buildFakeReportLine(width: 400),
                              const SizedBox(height: 12),
                              _buildFakeReportLine(width: 350),
                              const SizedBox(height: 12),
                              _buildFakeReportLine(width: 150),
                              const SizedBox(height: 32),
                              _buildFakeReportLine(width: 300),
                              const SizedBox(height: 12),
                              _buildFakeReportLine(width: 250),
                            ],
                          ),
                        ),
                      ),

                      // THE FILTER (Glass Blur)
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(color: Colors.transparent),
                        ),
                      ),

                      // THE HOOK (Clear Overlay)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock_outline,
                                size: 60, color: AppColors.mellowOrange),
                            const SizedBox(height: 16),
                            const Text('CRITICAL FAILURE DETECTED',
                                style: TextStyle(
                                    color: AppColors.mellowOrange,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14)),
                            const SizedBox(height: 8),
                            Text('SCORE: 45/100',
                                style: TextStyle(
                                    fontFamily: 'Agency FB',
                                    color: Colors.white.withOpacity(0.9),
                                    letterSpacing: 4,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 24),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.mellowCyan,
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text("UNLOCK ANALYSIS"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildFakeReportLine({required double width}) {
    return Container(
      width: width,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
