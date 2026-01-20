import 'package:flutter/material.dart';

abstract class AppColors {
  // --- UI-LEVERAGE PALETTE (XML SOURCE) ---

  static const Color leverage1 = Color(0xFF7E00FF); // Purple
  static const Color leverage2 = Color(0xFF00C7FF); // Cyan
  static const Color leverage3 = Color(0xFF00FFC8); // Aqua
  static const Color leverage4 = Color(0xFF1CFF00); // Neon Green
  static const Color leverage5 = Color(0xFFDCFF00); // Lime
  static const Color leverage6 = Color(0xFFFF5100); // Orange
  static const Color leverage7 = Color(0xFF000000); // Black
  static const Color leverage8 = Color(0xFF120808); // Deep Dark (Main BG)
  static const Color leverage9 = Color(0xFF290808); // Dark Red-Brown
  static const Color leverage10 = Color(0xFFD8FFE5); // Pale Green
  static const Color leverage11 = Color(0xFFDEFFFB); // Pale Cyan
  static const Color leverage12 = Color(0xFFEEDEFF); // Pale Purple
  static const Color leverage13 = Color(0xFFFFE8DE); // Pale Orange
  static const Color leverage14 = Color(0xFFFFFFDE); // Pale Yellow
  static const Color leverage15 = Color(0xFFFFFFFF); // White

  // --- DARK MODE MAPPINGS (MellowPen / LEO OS) ---

  // Base Background -> Deep Space
  static const Color deepSpace = Color(0xFF050505);

  // The "Structure" (Panel Background) -> Dark Glass
  static const Color structureColor = Color(0xFF0C0C12);

  // Primary Brand (Focus) -> Orange
  static const Color mellowOrange = leverage6;

  // Secondary (Fluidity) -> Cyan
  static const Color mellowCyan = leverage2;

  // Positive/Success (Eco) -> Neon Green
  static const Color appleGreen = leverage4;

  // Text -> White (Dark Mode Default)
  static const Color textMain = leverage15;
  static const Color textMute = Color(0xFF86868B);

  static const Color glassBorder = Color(0xFF2C2C2E);

  // Legacy
  static const Color signalColor = mellowOrange;
}
