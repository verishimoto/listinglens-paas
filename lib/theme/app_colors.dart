import 'package:flutter/material.dart';

abstract class AppColors {
  // --- SOLID FUSION PALETTE ---
  
  // The Quiet Room
  static const Color voidColor = Color(0xFF09090B);      // Zinc-950
  static const Color structureColor = Color(0xFF18181B); // Zinc-900
  static const Color borderColor = Color(0xFF27272A);    // Zinc-800
  
  // The Guide
  static const Color signalColor = Color(0xFFF97316);    // Orange-500
  static const Color signalDim = Color(0xFF9A3412);      // Orange-900 (for backgrounds)
  
  // Text
  static const Color textMain = Color(0xFFFAFAFA);       // Zinc-50
  static const Color textMute = Color(0xFFA1A1AA);       // Zinc-400
  static const Color textDark = Color(0xFF52525B);       // Zinc-600

  // Interaction
  static const Color hoverOverlay = Color(0x1FFFFFFF);   // White 12% opacity
}
