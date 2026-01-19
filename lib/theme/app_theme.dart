import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.voidColor,
      primaryColor: AppColors.signalColor,
      
      // Font Family
      fontFamily: 'Roboto', // Fallback
      
      textTheme: const TextTheme(
        // Headings
        displayLarge: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold),
        
        // Body
        bodyLarge: TextStyle(color: AppColors.textMain),
        bodyMedium: TextStyle(color: AppColors.textDark),
        
        // Mono/Tech
        labelSmall: TextStyle(fontFamily: 'Courier New', color: AppColors.textMute, fontSize: 10, letterSpacing: 1.5),
        labelMedium: TextStyle(fontFamily: 'Courier New', color: AppColors.textMain, fontSize: 12),
      ),

      colorScheme: const ColorScheme.dark(
        primary: AppColors.signalColor,
        surface: AppColors.structureColor,
        background: AppColors.voidColor,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.borderColor,
        thickness: 1,
      ),
    );
  }
}
