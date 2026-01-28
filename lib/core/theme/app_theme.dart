import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFF050505);
  static const Color surface = Color(0xFF101010);
  static const Color surfaceHighlight = Color(0xFF1A1A1A);

  static const Color primary = Color(0xFFFF5100);
  static const Color secondary = Color(0xFF7E00FF);
  static const Color cyan = Color(0xFF00C7FF);
  static const Color success = Color(0xFF1CFF00);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onSurface: Colors.white,
      ),
      textTheme: TextTheme(
        // Ultra Condensed Display (Numbers & Huge Text)
        displayLarge: GoogleFonts.antonio(
          fontSize: 80,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
          color: Colors.white,
          height: 0.9,
        ),
        displayMedium: GoogleFonts.antonio(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          color: Colors.white,
        ),
        // Logic & Titles (San Francisco / Inter)
        headlineMedium: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5, // Tighter for SF feel
          color: cyan,
        ),
        // UI Text
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white.withValues(alpha: 0.9),
          letterSpacing: -0.2,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
