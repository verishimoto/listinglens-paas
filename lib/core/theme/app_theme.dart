import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Phoenix Protocol Colors
  static const Color background = Color(0xFF09090b); // Zinc 950
  static const Color surface = Color(0xFF18181b); // Zinc 900
  static const Color surfaceHighlight = Color(0xFF27272a); // Zinc 800

  static const Color primary = Color(0xFF06b6d4); // Cyan 500
  static const Color onPrimary = Colors.black;

  static const Color secondary = Color(0xFF8b5cf6); // Violet 500
  static const Color onSecondary = Colors.white;

  static const Color error = Color(0xFFef4444); // Red 500

  static ThemeData get darkTheme {
    final baseTheme = ThemeData.dark();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        surface: surface,
        onSurface: Colors.white,
        error: error,
      ),
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surfaceHighlight.withValues(alpha: 0.5),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
        margin: EdgeInsets.zero,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: background,
        indicatorColor: primary,
        labelType: NavigationRailLabelType.all,
        selectedLabelTextStyle: GoogleFonts.inter(
            color: primary, fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelTextStyle:
            GoogleFonts.inter(color: Colors.white54, fontSize: 12),
        selectedIconTheme: const IconThemeData(color: Colors.black),
        unselectedIconTheme: const IconThemeData(color: Colors.white54),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white.withValues(alpha: 0.1),
        thickness: 1,
      ),
    );
  }
}
