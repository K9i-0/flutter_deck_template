import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

/// Theme configuration for Flutter Deck.
class ThemeConfig {
  ThemeConfig._();

  /// Primary seed color for theme generation.
  static const Color seedColor = Color(0xFF6366f1);

  /// Light theme configuration.
  static FlutterDeckThemeData get lightTheme {
    final theme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );

    return FlutterDeckThemeData.fromTheme(theme);
  }

  /// Dark theme configuration.
  static FlutterDeckThemeData get darkTheme {
    final theme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );

    return FlutterDeckThemeData.fromTheme(theme);
  }
}
