import 'dart:ui';

class AppColors {
  // ===========================================================================
  // PALETTE: UI-LEVERAGE (Listing Lens PaaS v11.5)
  // ===========================================================================

  static const Color leverage1 =
      Color(0xFF7E00FF); // rgb='7E00FF' (Indigo/Purple)
  static const Color leverage2 = Color(0xFF00C7FF); // rgb='00C7FF' (Cyan)
  static const Color leverage3 = Color(0xFF00FFC8); // rgb='00FFC8' (Teal)
  static const Color leverage4 = Color(0xFF1CFF00); // rgb='1CFF00' (Lime Green)
  static const Color leverage5 = Color(0xFFDCFF00); // rgb='DCFF00' (Yellow)
  static const Color leverage6 = Color(0xFFFF5100); // rgb='FF5100' (Orange)

  static const Color leverage7 = Color(0xFF000000); // rgb='000000' (Black)
  static const Color leverage8 =
      Color(0xFF120808); // rgb='120808' (Dark Accent 1)
  static const Color leverage9 =
      Color(0xFF290808); // rgb='290808' (Dark Accent 2)

  static const Color leverage10 = Color(0xFFD8FFE5); // rgb='D8FFE5'
  static const Color leverage11 = Color(0xFFDEFFFB); // rgb='DEFFFB'
  static const Color leverage12 = Color(0xFFEEDEFF); // rgb='EEDEFF'
  static const Color leverage13 = Color(0xFFFFE8DE); // rgb='FFE8DE'
  static const Color leverage14 = Color(0xFFFFFFDE); // rgb='FFFFDE'
  static const Color leverage15 = Color(0xFFFFFFFF); // rgb='FFFFFF' (White)

  // ===========================================================================
  // SEMANTIC MAPPINGS (Epsilon Prototype)
  // ===========================================================================

  static const Color backgroundDark = leverage7;
  static const Color surfaceGlassDark =
      Color(0x99120808); // Leverage 8 with opacity
  static const Color textPrimaryDark = leverage15;
  static const Color backgroundLight = leverage15;
  static const Color surfaceGlassLight =
      Color(0x99DEFFFB); // Leverage 11 with opacity

  static const Color accentCyan = leverage2;
  static const Color accentOrange = leverage6;
  static const Color accentGreen = leverage4;
  static const Color accentPurple = leverage1;

  // ===========================================================================
  // LEGACY COMPATIBILITY (Fixing Build Errors)
  // ===========================================================================

  // 'voidColor' was main background #050505 -> using Leverage 7 (Black) or 8
  static const Color voidColor = leverage7;

  // 'signalColor' was likely an accent -> using Leverage 6 (Orange)
  static const Color signalColor = leverage6;

  // 'glass' -> often white with low opacity
  static const Color glass = Color(0x1AFFFFFF);

  // 'obsidian' -> Darker than void? Using Leverage 8
  static const Color obsidian = leverage8;

  // 'plasma' -> Likely cyan or purple? Using Leverage 2 (Cyan)
  static const Color plasma = leverage2;

  // 'textPrimary'
  static const Color textPrimary = leverage15;

  // 'textSecondary'
  static const Color textSecondary = Color(0x99FFFFFF);

  // 'error'
  static const Color error = Color(0xFFFF3B30);

  // 'surface'
  static const Color surface = leverage8;

  // 'primary'
  static const Color primary = leverage6; // Orange as primary

  // ===========================================================================
  // RECOVERED MISSING GETTERS (From @current_problems)
  // ===========================================================================

  static const Color mellowOrange = leverage6;
  static const Color mellowCyan = leverage2;
  static const Color textMute = Color(0x99FFFFFF); // Muted text
  static const Color textMain = leverage15; // Main text
  static const Color crystalSurface = surfaceGlassDark;
  static const Color structureColor = leverage8;
  static const Color appleGreen = leverage4;
}
