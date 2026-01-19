import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class LabView extends StatelessWidget {
  final Map<String, dynamic> slide;
  final bool isPassed;
  final String? mountedImage;
  final Function(String) onMount;
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
    return Column(
      children: [
        // 1. PROTOCOL HEADER (Glass Border Bottom)
        Container(
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white10)),
          ),
          child: Column(
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
                   Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.signalColor, shape: BoxShape.circle)), // Dot
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
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  letterSpacing: -1,
                  color: AppColors.textMain,
                ),
              ),
            ],
          ),
        ),

        // 2. CANVAS AREA
        Expanded(
          child: Center(
            child: mountedImage != null
                ? _buildWorkArea()
                : _buildMountAssetUI(),
          ),
        ),

        // 3. ACTION FOOTER (Glass Border Top)
        Container(
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white10)),
          ),
          alignment: Alignment.centerRight,
          child: mountedImage != null ? ElevatedButton.icon(
            onPressed: isPassed ? null : onAudit,
            icon: isPassed ? const Icon(Icons.check) : const Icon(Icons.flash_on),
            label: Text(isPassed ? 'PROTOCOL VERIFIED' : 'RUN HEURISTIC AUDIT'),
            style: ElevatedButton.styleFrom(
              backgroundColor: isPassed ? AppColors.structureColor : AppColors.signalColor,
              foregroundColor: isPassed ? AppColors.signalColor : Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
              textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 2),
            ),
          ) : const SizedBox(), // Hidden if no asset
        ),
      ],
    );
  }

  Widget _buildMountAssetUI() {
    return GestureDetector(
      onTap: () => onMount('assets/mock_image.png'), // Simulating file pick
      child: Container(
        width: 600,
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10, width: 2, style: BorderStyle.none),
          color: Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
               width: 120, height: 120,
               decoration: BoxDecoration(
                 color: const Color(0xFF7E00FF), // Indigo
                 borderRadius: BorderRadius.circular(30),
                 boxShadow: [
                   BoxShadow(color: const Color(0xFF7E00FF).withOpacity(0.4), blurRadius: 40, offset: const Offset(0, 20)),
                 ],
               ),
               child: const Icon(Icons.add, size: 60, color: Colors.white),
             ),
             const SizedBox(height: 32),
             const Text('MOUNT ASSET', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
             const SizedBox(height: 8),
             const Text('1820px × 1214px REQUIRED', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 2, color: AppColors.textMute)),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkArea() {
    return Container(
      width: 800,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 50, offset: Offset(0, 20))],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.image, size: 100, color: Colors.white10),
          if (isPassed)
             Positioned.fill(
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(24),
                   gradient: const LinearGradient(
                     colors: [Colors.transparent, Color(0x331CFF00)], // Green wash
                     begin: Alignment.topCenter,
                     end: Alignment.bottomCenter,
                   )
                 ),
                 child: const Center(
                   child: Icon(Icons.check_circle, size: 100, color: AppColors.signalColor),
                 ),
               ),
             )
        ],
      ),
    );
  }
}
