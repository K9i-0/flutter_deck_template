import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

/// Theme configuration for Flutter Deck.
///
/// Optimized for conference presentations with larger font sizes.
class ThemeConfig {
  ThemeConfig._();

  /// Primary seed color for theme generation.
  static const Color seedColor = Color(0xFF6366f1);

  /// Custom text theme with larger font sizes for conference presentations.
  ///
  /// Based on best practices:
  /// - Title/headers: 36-80pt
  /// - Body text: 24-32pt
  /// - Minimum readable: 20pt
  static const _textTheme = FlutterDeckTextTheme(
    display: TextStyle(fontSize: 103, fontWeight: FontWeight.bold),
    header: TextStyle(fontSize: 57, fontWeight: FontWeight.w400),
    title: TextStyle(fontSize: 54, fontWeight: FontWeight.w400),
    subtitle: TextStyle(fontSize: 42, fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
  );

  /// Light theme configuration.
  static FlutterDeckThemeData get lightTheme {
    final theme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );

    final textTheme = _textTheme.apply(color: theme.colorScheme.onSurface);

    return FlutterDeckThemeData(
      brightness: Brightness.light,
      theme: theme,
      textTheme: textTheme,
    ).copyWith(
      bigFactSlideTheme: FlutterDeckBigFactSlideThemeData(
        titleTextStyle: textTheme.display,
        subtitleTextStyle: textTheme.title, // 42pt → 54pt に拡大
      ),
    );
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

    final textTheme = _textTheme.apply(color: theme.colorScheme.onSurface);

    return FlutterDeckThemeData(
      brightness: Brightness.dark,
      theme: theme,
      textTheme: textTheme,
    ).copyWith(
      bigFactSlideTheme: FlutterDeckBigFactSlideThemeData(
        titleTextStyle: textTheme.display,
        subtitleTextStyle: textTheme.title, // 42pt → 54pt に拡大
      ),
    );
  }
}
