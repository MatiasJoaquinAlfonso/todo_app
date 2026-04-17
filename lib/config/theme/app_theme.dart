import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Stitch "Azure Precision Framework" Design Tokens ────────────────────────
// Primary: #0040A1 (deep blue)
// Surface: #F7F9FB (near-white)
// No-Line Rule: zero Border.all. Depth via surface container tones.
// Typography: Manrope (headings) + Inter (body / labels)
// ─────────────────────────────────────────────────────────────────────────────

class StitchColors {
  // Primary blue spectrum (exact from Stitch JSON)
  static const primary          = Color(0xFF0040A1);
  static const primaryContainer = Color(0xFF0056D2);
  static const onPrimary        = Color(0xFFFFFFFF);
  static const primaryFixed     = Color(0xFFDAE2FF);
  static const primaryFixedDim  = Color(0xFFB2C5FF);

  // Surface hierarchy
  static const surface                 = Color(0xFFF7F9FB);
  static const surfaceContainerLowest  = Color(0xFFFFFFFF);
  static const surfaceContainerLow     = Color(0xFFF2F4F6);
  static const surfaceContainer        = Color(0xFFECEEF0);
  static const surfaceContainerHigh    = Color(0xFFE6E8EA);
  static const surfaceContainerHighest = Color(0xFFE0E3E5);

  // On-surface
  static const onSurface        = Color(0xFF191C1E);
  static const onSurfaceVariant = Color(0xFF424654);

  // Secondary
  static const secondary          = Color(0xFF4F5E7E);
  static const secondaryContainer = Color(0xFFCADAFF);
  static const onSecondaryContainer = Color(0xFF505F7F);

  // Tertiary (teal accent)
  static const tertiary          = Color(0xFF004E5F);
  static const tertiaryContainer = Color(0xFF00687E);

  // Outline
  static const outline        = Color(0xFF737785);
  static const outlineVariant = Color(0xFFC3C6D6);

  // Error
  static const error          = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);

  // Inverse
  static const inverseSurface   = Color(0xFF2D3133);
  static const onInverseSurface = Color(0xFFEFF1F3);
  static const inversePrimary   = Color(0xFFB2C5FF);

  // Swipe actions
  static const swipeComplete = Color(0xFF388E3C);
  static const swipeDelete   = Color(0xFFC62828);
}

class AppColors {
  static const seed = Color(0xFF0056D2);
}

class AppTheme {
  final bool isDarkMode;
  final int selectedColor;

  const AppTheme({
    this.isDarkMode = false,
    this.selectedColor = 0,
  });

  ColorScheme _scheme() {
    if (!isDarkMode) {
      // Use exact Stitch-specified colors for light mode
      return const ColorScheme(
        brightness: Brightness.light,
        primary: StitchColors.primary,
        onPrimary: StitchColors.onPrimary,
        primaryContainer: StitchColors.primaryContainer,
        onPrimaryContainer: StitchColors.onPrimary,
        secondary: StitchColors.secondary,
        onSecondary: StitchColors.onPrimary,
        secondaryContainer: StitchColors.secondaryContainer,
        onSecondaryContainer: StitchColors.onSecondaryContainer,
        tertiary: StitchColors.tertiary,
        onTertiary: StitchColors.onPrimary,
        tertiaryContainer: StitchColors.tertiaryContainer,
        onTertiaryContainer: Color(0xFF95E5FF),
        error: StitchColors.error,
        onError: StitchColors.onPrimary,
        errorContainer: StitchColors.errorContainer,
        onErrorContainer: Color(0xFF93000A),
        surface: StitchColors.surface,
        onSurface: StitchColors.onSurface,
        onSurfaceVariant: StitchColors.onSurfaceVariant,
        outline: StitchColors.outline,
        outlineVariant: StitchColors.outlineVariant,
        inverseSurface: StitchColors.inverseSurface,
        onInverseSurface: StitchColors.onInverseSurface,
        inversePrimary: StitchColors.inversePrimary,
        surfaceContainerLowest: StitchColors.surfaceContainerLowest,
        surfaceContainerLow: StitchColors.surfaceContainerLow,
        surfaceContainer: StitchColors.surfaceContainer,
        surfaceContainerHigh: StitchColors.surfaceContainerHigh,
        surfaceContainerHighest: StitchColors.surfaceContainerHighest,
      );
    }
    // Dark mode — generate from seed
    return ColorScheme.fromSeed(
      seedColor: const Color(0xFF0056D2),
      brightness: Brightness.dark,
    );
  }

  TextTheme _textTheme(ColorScheme cs) {
    return GoogleFonts.interTextTheme().copyWith(
      displayLarge:   GoogleFonts.manrope(fontSize: 57, fontWeight: FontWeight.w800, color: cs.onSurface),
      displayMedium:  GoogleFonts.manrope(fontSize: 45, fontWeight: FontWeight.w700, color: cs.onSurface),
      displaySmall:   GoogleFonts.manrope(fontSize: 36, fontWeight: FontWeight.w700, color: cs.onSurface),
      headlineLarge:  GoogleFonts.manrope(fontSize: 32, fontWeight: FontWeight.w800, color: cs.primary),
      headlineMedium: GoogleFonts.manrope(fontSize: 28, fontWeight: FontWeight.w800, color: cs.primary),
      headlineSmall:  GoogleFonts.manrope(fontSize: 24, fontWeight: FontWeight.w700, color: cs.onSurface),
      titleLarge:     GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w700, color: cs.onSurface),
      titleMedium:    GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: cs.onSurface),
      titleSmall:     GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: cs.onSurface),
      bodyLarge:      GoogleFonts.inter(fontSize: 16, color: cs.onSurface),
      bodyMedium:     GoogleFonts.inter(fontSize: 14, color: cs.onSurface),
      bodySmall:      GoogleFonts.inter(fontSize: 12, color: cs.onSurfaceVariant),
      labelLarge:     GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: cs.onSurface),
      labelMedium:    GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: cs.onSurface, letterSpacing: 0.5),
      labelSmall:     GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: cs.onSurface, letterSpacing: 0.5),
    );
  }

  ThemeData getTheme() {
    final cs = _scheme();
    final tt = _textTheme(cs);

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      textTheme: tt,

      // Scaffold base: near-white surface
      scaffoldBackgroundColor: isDarkMode ? cs.surface : StitchColors.surface,

      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: cs.onSurface),
        titleTextStyle: GoogleFonts.manrope(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: cs.onSurface,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: isDarkMode ? cs.surfaceContainer : StitchColors.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 4),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDarkMode
            ? cs.surfaceContainerHigh
            : StitchColors.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: GoogleFonts.inter(
          color: StitchColors.onSurfaceVariant,
          fontSize: 14,
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: isDarkMode
            ? cs.surfaceContainerHigh
            : StitchColors.surfaceContainerHigh,
        selectedColor: isDarkMode ? cs.primaryContainer : StitchColors.tertiaryContainer,
        labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
        side: BorderSide.none,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 0,
        showCheckmark: false,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDarkMode
            ? cs.surfaceContainer
            : StitchColors.surfaceContainerLowest,
        indicatorColor: isDarkMode
            ? cs.primaryContainer
            : StitchColors.primaryFixed,
        indicatorShape: const StadiumBorder(),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return GoogleFonts.inter(
            fontSize: 11,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? cs.primary : cs.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? cs.primary : cs.onSurfaceVariant,
            size: 24,
          );
        }),
        elevation: 0,
        height: 64,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return cs.onPrimary;
          return cs.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return cs.primary;
          return cs.surfaceContainerHighest;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      datePickerTheme: DatePickerThemeData(
        backgroundColor: isDarkMode ? cs.surfaceContainerHigh : cs.surface,
        headerBackgroundColor: cs.primary,
        headerForegroundColor: cs.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        dayOverlayColor: WidgetStateProperty.all(cs.primary.withAlpha(20)),
        todayBorder: BorderSide(color: cs.primary, width: 1),
      ),

      timePickerTheme: TimePickerThemeData(
        backgroundColor: isDarkMode ? cs.surfaceContainerHigh : cs.surface,
        dialBackgroundColor: isDarkMode
            ? cs.surfaceContainerHighest
            : StitchColors.surfaceContainerLow,
        dialHandColor: cs.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: cs.inverseSurface,
        contentTextStyle: GoogleFonts.inter(color: cs.onInverseSurface, fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      dividerTheme: DividerThemeData(
        color: StitchColors.outlineVariant.withAlpha(40),
        thickness: 1,
        space: 1,
      ),

      // Dialogs
      dialogTheme: DialogThemeData(
        backgroundColor: isDarkMode ? cs.surfaceContainerHigh : cs.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 4,
      ),
    );
  }

  AppTheme copyWith({int? selectedColor, bool? isDarkMode}) => AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}