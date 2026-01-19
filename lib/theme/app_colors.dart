import 'package:flutter/material.dart';

abstract class AppColors {
  // --- GOOGLE CRYSTAL PALETTE (GEMINI ERA) ---
  
  // The Prismatic Lab (Light Mode)
  static const Color voidColor = Color(0xFFF9FAFB);      // Zinc-50 (Main Background)
  static const Color structureColor = Color(0xFFFFFFFF); // White (Cards/Structure)
  static const Color borderColor = Color(0xFFE4E4E7);    // Zinc-200 (Soft Borders)
  
  // The Guide
  static const Color signalColor = Color(0xFFF97316);    // Orange-500 (Kept as accent)
  static const Color signalDim = Color(0xFFFFF7ED);      // Orange-50 (Light Tint for backgrounds)
  
  // Text (Inverted for Light Mode)
  static const Color textMain = Color(0xFF09090B);       // Zinc-950 (Deep Black)
  static const Color textMute = Color(0xFF71717A);       // Zinc-500 (Mid Gray)
  static const Color textDark = Color(0xFFA1A1AA);       // Zinc-400 (Light Gray)

  // Interaction (Crystal)
  static const Color hoverOverlay = Color(0x0A000000);   // Black 4% opacity (Subtle shadow)
}
