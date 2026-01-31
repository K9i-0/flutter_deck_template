import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:google_fonts/google_fonts.dart';

/// Theme configuration for Flutter Deck.
///
/// Monochrome-based stylish design with blue accent color.
class ThemeConfig {
  ThemeConfig._();

  // === Color Palette ===

  /// Accent color (blue)
  static const Color accentBlue = Color(0xFF007AFF);

  /// Light accent blue (for gradients)
  static const Color accentBlueLight = Color(0xFF5AC8FA);

  /// Accent color (orange)
  static const Color accentOrange = Color(0xFFFF9500);

  /// Accent color (green)
  static const Color accentGreen = Color(0xFF34C759);

  /// Background gradient start
  static const Color background = Color(0xFF0A0A0A);

  /// Background gradient end / Surface
  static const Color surface = Color(0xFF121212);

  /// Container background
  static const Color surfaceContainer = Color(0xFF1E1E1E);

  /// Secondary surface background
  static const Color surfaceSecondary = Color(0xFF252525);

  /// Border / Divider
  static const Color outline = Color(0xFF2A2A2A);

  /// Primary text
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Secondary text
  static const Color textSecondary = Color(0xFFB0B0B0);

  // === Font Family ===

  /// Get Inter font family for alphanumeric text
  static String get _fontFamily => GoogleFonts.inter().fontFamily!;

  /// Get Noto Sans JP font family for Japanese text
  static List<String> get _fontFamilyFallback => [
        GoogleFonts.notoSansJp().fontFamily!,
      ];

  /// Custom text theme with larger font sizes for conference presentations.
  ///
  /// Based on best practices:
  /// - Title/headers: 36-80pt
  /// - Body text: 24-32pt
  /// - Minimum readable: 20pt
  static FlutterDeckTextTheme get _textTheme => FlutterDeckTextTheme(
        display: TextStyle(
          fontSize: 103,
          fontWeight: FontWeight.bold,
          fontFamily: _fontFamily,
          fontFamilyFallback: _fontFamilyFallback,
        ),
        header: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w500,
          fontFamily: _fontFamily,
          fontFamilyFallback: _fontFamilyFallback,
        ),
        title: TextStyle(
          fontSize: 54,
          fontWeight: FontWeight.w500,
          fontFamily: _fontFamily,
          fontFamilyFallback: _fontFamilyFallback,
        ),
        subtitle: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w400,
          fontFamily: _fontFamily,
          fontFamilyFallback: _fontFamilyFallback,
        ),
        bodyLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          fontFamily: _fontFamily,
          fontFamilyFallback: _fontFamilyFallback,
        ),
        bodyMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w400,
          fontFamily: _fontFamily,
          fontFamilyFallback: _fontFamilyFallback,
        ),
        bodySmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          fontFamily: _fontFamily,
          fontFamilyFallback: _fontFamilyFallback,
        ),
      );

  /// Custom ColorScheme for monochrome + blue accent design.
  static ColorScheme get _darkColorScheme => const ColorScheme(
        brightness: Brightness.dark,
        // Accent colors
        primary: accentBlue,
        onPrimary: textPrimary,
        primaryContainer: accentBlue,
        onPrimaryContainer: textPrimary,
        // Secondary (using lighter blue)
        secondary: accentBlueLight,
        onSecondary: background,
        secondaryContainer: surfaceContainer,
        onSecondaryContainer: textPrimary,
        // Tertiary
        tertiary: accentBlue,
        onTertiary: textPrimary,
        tertiaryContainer: surfaceContainer,
        onTertiaryContainer: textPrimary,
        // Error colors
        error: Color(0xFFCF6679),
        onError: background,
        errorContainer: Color(0xFF93000A),
        onErrorContainer: Color(0xFFFFDAD6),
        // Surface colors
        surface: surface,
        onSurface: textPrimary,
        surfaceContainerHighest: surfaceContainer,
        onSurfaceVariant: textSecondary,
        // Outline
        outline: outline,
        outlineVariant: outline,
        // Others
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: textPrimary,
        onInverseSurface: background,
        inversePrimary: accentBlue,
      );

  /// Light theme configuration (keeping for compatibility, but dark is primary).
  static FlutterDeckThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: accentBlue,
      brightness: Brightness.light,
    );

    final theme = ThemeData.from(
      colorScheme: colorScheme,
      useMaterial3: true,
    );

    final textTheme = _textTheme.apply(color: colorScheme.onSurface);

    return FlutterDeckThemeData(
      brightness: Brightness.light,
      theme: theme,
      textTheme: textTheme,
    ).copyWith(
      bigFactSlideTheme: FlutterDeckBigFactSlideThemeData(
        titleTextStyle: textTheme.display,
        subtitleTextStyle: textTheme.title,
      ),
    );
  }

  /// Dark theme configuration (monochrome + blue accent).
  static FlutterDeckThemeData get darkTheme {
    final colorScheme = _darkColorScheme;

    final theme = ThemeData.from(
      colorScheme: colorScheme,
      useMaterial3: true,
    ).copyWith(
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ),
    );

    final textTheme = _textTheme.apply(color: textPrimary);

    return FlutterDeckThemeData(
      brightness: Brightness.dark,
      theme: theme,
      textTheme: textTheme,
    ).copyWith(
      bigFactSlideTheme: FlutterDeckBigFactSlideThemeData(
        titleTextStyle: textTheme.display.copyWith(color: textPrimary),
        subtitleTextStyle: textTheme.title.copyWith(color: textSecondary),
      ),
    );
  }
}
