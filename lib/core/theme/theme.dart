import 'package:flutter/material.dart';

// ── Colors ────────────────────────────────────────────────────────────────────

class ZColors {
  ZColors._();

  // Primary Green
  static const primary    = Color(0xFF2E7D32);
  static const primary400 = Color(0xFF43A047);
  static const primary300 = Color(0xFF66BB6A);
  static const primary100 = Color(0xFFE8F5E9);

  // Secondary Orange
  static const orange     = Color(0xFFFF9800);
  static const orange300  = Color(0xFFFFB74D);
  static const orange100  = Color(0xFFFFF3E0);

  // Neutral
  static const gray900    = Color(0xFF222222);
  static const gray700    = Color(0xFF555555);
  static const gray500    = Color(0xFF888888);
  static const gray300    = Color(0xFFD6D6D6);
  static const gray100    = Color(0xFFF7F8FA);
  static const white      = Color(0xFFFFFFFF);

  // Status
  static const success    = Color(0xFF22C55E);
  static const warning    = Color(0xFFF59E0B);
  static const danger     = Color(0xFFEF4444);
  static const info       = Color(0xFF3B82F6);

  // Background
  static const background = Color(0xFFFFFFFF);
  static const surface    = Color(0xFFF7F8FA);
  static const border     = Color(0xFFE5E7EB);
}

// ── Spacing ───────────────────────────────────────────────────────────────────

class ZSpacing {
  ZSpacing._();

  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 12;
  static const double lg  = 16;
  static const double xl  = 24;
  static const double x2l = 32;
  static const double x3l = 48;
  static const double x4l = 64;
}

// ── Radius ────────────────────────────────────────────────────────────────────

class ZRadius {
  ZRadius._();

  static const double button      = 14;
  static const double card        = 16;
  static const double input       = 14;
  static const double bottomSheet = 24;
  static const double dialog      = 20;
  static const double badge       = 999;

  static BorderRadius get cardBorder   => BorderRadius.circular(card);
  static BorderRadius get buttonBorder => BorderRadius.circular(button);
  static BorderRadius get inputBorder  => BorderRadius.circular(input);
}

// ── Typography ────────────────────────────────────────────────────────────────

class ZTextStyle {
  ZTextStyle._();

  static const String _font = 'Estedad';

  static const display = TextStyle(
    fontFamily: _font, fontSize: 32, fontWeight: FontWeight.w700,
    color: ZColors.gray900,
  );
  static const heading = TextStyle(
    fontFamily: _font, fontSize: 24, fontWeight: FontWeight.w700,
    color: ZColors.gray900,
  );
  static const title = TextStyle(
    fontFamily: _font, fontSize: 20, fontWeight: FontWeight.w600,
    color: ZColors.gray900,
  );
  static const subtitle = TextStyle(
    fontFamily: _font, fontSize: 18, fontWeight: FontWeight.w500,
    color: ZColors.gray900,
  );
  static const body = TextStyle(
    fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w400,
    color: ZColors.gray900,
  );
  static const bodyMedium = TextStyle(
    fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w500,
    color: ZColors.gray900,
  );
  static const small = TextStyle(
    fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w400,
    color: ZColors.gray700,
  );
  static const smallMedium = TextStyle(
    fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w500,
    color: ZColors.gray700,
  );
  static const caption = TextStyle(
    fontFamily: _font, fontSize: 12, fontWeight: FontWeight.w500,
    color: ZColors.gray500,
  );
}

// ── Shadow ────────────────────────────────────────────────────────────────────

class ZShadow {
  ZShadow._();

  static final card = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      offset: const Offset(0, 4),
      blurRadius: 20,
    ),
  ];
}

// ── Theme ─────────────────────────────────────────────────────────────────────

class ZebiloTheme {
  ZebiloTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: 'Estedad',
    colorScheme: ColorScheme.fromSeed(
      seedColor: ZColors.primary,
      primary: ZColors.primary,
      surface: ZColors.background,
      background: ZColors.background,
      error: ZColors.danger,
    ),
    scaffoldBackgroundColor: ZColors.background,

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: ZColors.white,
      foregroundColor: ZColors.gray900,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: ZTextStyle.title,
    ),

    // ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ZColors.primary,
        foregroundColor: ZColors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: ZRadius.buttonBorder),
        textStyle: ZTextStyle.bodyMedium,
        elevation: 0,
      ),
    ),

    // OutlinedButton
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ZColors.primary,
        side: const BorderSide(color: ZColors.primary),
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: ZRadius.buttonBorder),
        textStyle: ZTextStyle.bodyMedium,
      ),
    ),

    // TextButton
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ZColors.primary,
        textStyle: ZTextStyle.bodyMedium,
      ),
    ),

    // InputDecoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ZColors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: ZSpacing.lg,
        vertical: ZSpacing.md,
      ),
      border: OutlineInputBorder(
        borderRadius: ZRadius.inputBorder,
        borderSide: const BorderSide(color: ZColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: ZRadius.inputBorder,
        borderSide: const BorderSide(color: ZColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: ZRadius.inputBorder,
        borderSide: const BorderSide(color: ZColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: ZRadius.inputBorder,
        borderSide: const BorderSide(color: ZColors.danger),
      ),
      hintStyle: ZTextStyle.body.copyWith(color: ZColors.gray500),
    ),

    // BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ZColors.white,
      selectedItemColor: ZColors.primary,
      unselectedItemColor: ZColors.gray500,
      selectedLabelStyle: TextStyle(
        fontFamily: 'Estedad', fontSize: 12, fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Estedad', fontSize: 12,
      ),
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    // Card
    cardTheme: CardThemeData(
      color: ZColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: ZRadius.cardBorder,
        side: const BorderSide(color: ZColors.border),
      ),
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: ZColors.surface,
      labelStyle: ZTextStyle.small,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZRadius.badge),
        side: const BorderSide(color: ZColors.border),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: ZSpacing.md,
        vertical: ZSpacing.xs,
      ),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: ZColors.border,
      thickness: 1,
      space: 0,
    ),

    // SnackBar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: ZColors.gray900,
      contentTextStyle: ZTextStyle.small.copyWith(color: ZColors.white),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // ProgressIndicator
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ZColors.primary,
    ),
  );
}
