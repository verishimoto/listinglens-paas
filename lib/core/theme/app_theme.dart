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
        displayLarge: GoogleFonts.outfit(
          fontSize: 72,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.05,
          color: Colors.white,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 48,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.04,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: 2,
          color: primary,
        ),
        bodyLarge: GoogleFonts.ebGaramond(
          fontSize: 18,
          height: 1.6,
          color: Colors.white70,
        ),
        bodyMedium: GoogleFonts.ebGaramond(
          fontSize: 16,
          height: 1.6,
          color: Colors.white60,
        ),
      ),
    );
  }
}
