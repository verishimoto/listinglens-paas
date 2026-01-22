import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.voidColor,
      primaryColor: AppColors.signalColor,

      // Font Family
      fontFamily: 'San Francisco',
      fontFamilyFallback: const [
        'SF Pro Text',
        'Inter',
        'Roboto',
        'sans-serif'
      ],

      textTheme: const TextTheme(
        // Headings
        displayLarge:
            TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold),
        displayMedium:
            TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold),

        // Body
        bodyLarge: TextStyle(color: AppColors.textMain),
        bodyMedium: TextStyle(color: AppColors.textDark),

        // Mono/Tech
        labelSmall: TextStyle(
            fontFamily: 'Courier New',
            color: AppColors.textMute,
            fontSize: 10,
            letterSpacing: 1.5),
        labelMedium: TextStyle(
            fontFamily: 'Courier New', color: AppColors.textMain, fontSize: 12),
      ),

      colorScheme: const ColorScheme.dark(
        primary: AppColors.signalColor,
        surface: AppColors.structureColor,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.borderColor,
        thickness: 1,
      ),
    );
  }

  static ThemeData get lightIridescent {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor:
          const Color(0xFFF5F5FA), // Deep White / Off-White
      primaryColor: AppColors.signalColor,

      // Font Family
      fontFamily: 'San Francisco',
      fontFamilyFallback: const [
        'SF Pro Text',
        'Inter',
        'Roboto',
        'sans-serif'
      ],

      textTheme: const TextTheme(
        // Headings
        displayLarge: TextStyle(
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
            letterSpacing: -1.0),
        displayMedium: TextStyle(
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5),

        // Body
        bodyLarge: TextStyle(
            color: Color(0xFF333333)), // Dark Grey for readability on white
        bodyMedium: TextStyle(color: Color(0xFF666666)),

        // Mono/Tech
        labelSmall: TextStyle(
            fontFamily: 'Courier New',
            color: Color(0xFF999999),
            fontSize: 10,
            letterSpacing: 1.5),
        labelMedium: TextStyle(
            fontFamily: 'Courier New', color: Color(0xFF333333), fontSize: 12),
      ),

      colorScheme: const ColorScheme.light(
        primary: AppColors.signalColor,
        surface: Colors.white,
      ),

      dividerTheme: DividerThemeData(
        color: Colors.black.withValues(alpha: 0.05),
        thickness: 1,
      ),
    );
  }
}
