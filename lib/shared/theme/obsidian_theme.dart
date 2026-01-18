import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ObsidianTheme {
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.black, // Pure Black
      colorScheme: const ColorScheme.dark(
        background: Colors.black,
        surface: Colors.black, // Surface is black, glass sits on top
        primary: Colors.white,
        secondary: Color(0xFF27272a), // Zinc-800
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
        displayMedium: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
        displaySmall: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        bodyLarge: GoogleFonts.jetBrainsMono(
          color: const Color(0xFFa1a1aa), // Zinc-500
          fontSize: 14,
        ),
        bodyMedium: GoogleFonts.jetBrainsMono(
          color: const Color(0xFF71717a), // Zinc-400
          fontSize: 13,
        ),
        labelLarge: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  // Glass Physics
  static BoxDecoration get glassDecoration => BoxDecoration(
    color: Colors.white.withOpacity(0.08),
    border: Border.all(
      color: Colors.white.withOpacity(0.1),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(12),
  );
}
