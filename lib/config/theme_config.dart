import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

/// Theme configuration for Flutter Deck.
class ThemeConfig {
  ThemeConfig._();

  /// Primary seed color for theme generation.
  static const Color _seedColor = Color(0xFF6366f1);

  /// Light theme configuration.
  static FlutterDeckThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    );

    return FlutterDeckThemeData(
      brightness: Brightness.light,
      textTheme: _createTextTheme(colorScheme),
      slideTheme: _createSlideTheme(colorScheme),
      splitSlideTheme: _createSplitSlideTheme(colorScheme),
      speakerInfoWidgetTheme: _createSpeakerInfoTheme(colorScheme),
      footerTheme: _createFooterTheme(colorScheme),
      codeHighlightTheme: FlutterDeckCodeHighlightThemeData(
        textStyle: const TextStyle(
          fontFamily: 'JetBrains Mono',
          fontSize: 18,
        ),
      ),
    );
  }

  /// Dark theme configuration.
  static FlutterDeckThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    );

    return FlutterDeckThemeData(
      brightness: Brightness.dark,
      textTheme: _createTextTheme(colorScheme),
      slideTheme: _createSlideTheme(colorScheme),
      splitSlideTheme: _createSplitSlideTheme(colorScheme),
      speakerInfoWidgetTheme: _createSpeakerInfoTheme(colorScheme),
      footerTheme: _createFooterTheme(colorScheme),
      codeHighlightTheme: FlutterDeckCodeHighlightThemeData(
        textStyle: const TextStyle(
          fontFamily: 'JetBrains Mono',
          fontSize: 18,
        ),
      ),
    );
  }

  static FlutterDeckTextTheme _createTextTheme(ColorScheme colorScheme) {
    return FlutterDeckTextTheme(
      title: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      subtitle: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface.withValues(alpha: 0.8),
      ),
      header: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: 28,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 24,
        color: colorScheme.onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 20,
        color: colorScheme.onSurface.withValues(alpha: 0.8),
      ),
    );
  }

  static FlutterDeckSlideTheme _createSlideTheme(ColorScheme colorScheme) {
    return FlutterDeckSlideTheme(
      backgroundColor: colorScheme.surface,
      color: colorScheme.onSurface,
    );
  }

  static FlutterDeckSplitSlideTheme _createSplitSlideTheme(
    ColorScheme colorScheme,
  ) {
    return FlutterDeckSplitSlideTheme(
      leftBackgroundColor: colorScheme.primaryContainer,
      leftColor: colorScheme.onPrimaryContainer,
      rightBackgroundColor: colorScheme.surface,
      rightColor: colorScheme.onSurface,
    );
  }

  static FlutterDeckSpeakerInfoWidgetTheme _createSpeakerInfoTheme(
    ColorScheme colorScheme,
  ) {
    return FlutterDeckSpeakerInfoWidgetTheme(
      nameTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      descriptionTextStyle: TextStyle(
        fontSize: 18,
        color: colorScheme.onSurface.withValues(alpha: 0.8),
      ),
      socialHandleTextStyle: TextStyle(
        fontSize: 16,
        color: colorScheme.primary,
      ),
    );
  }

  static FlutterDeckFooterTheme _createFooterTheme(ColorScheme colorScheme) {
    return FlutterDeckFooterTheme(
      slideNumberColor: colorScheme.onSurface.withValues(alpha: 0.6),
      socialHandleColor: colorScheme.primary,
      slideNumberTextStyle: TextStyle(
        fontSize: 14,
        color: colorScheme.onSurface.withValues(alpha: 0.6),
      ),
      socialHandleTextStyle: TextStyle(
        fontSize: 14,
        color: colorScheme.primary,
      ),
    );
  }
}
