import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../utils/slide_navigation.dart';
import 'theme_config.dart';

/// Presentation configuration for Flutter Deck.
class PresentationConfig {
  PresentationConfig._();

  /// Slide size configuration (16:9 aspect ratio, FHD).
  static FlutterDeckSlideSize get slideSize =>
      FlutterDeckSlideSize.fromAspectRatio(
        aspectRatio: const FlutterDeckAspectRatio.ratio16x9(),
        resolution: const FlutterDeckResolution.fhd(),
      );

  /// Default transition between slides.
  static const transition = FlutterDeckTransition.fade();

  /// Light theme gradient.
  static const lightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white, Color(0xFFF5F5F5)],
  );

  /// Dark theme gradient (monochrome).
  static const darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ThemeConfig.background, ThemeConfig.surface],
  );

  /// Background configuration for light theme.
  static FlutterDeckBackground get lightBackground {
    return const FlutterDeckBackground.custom(
      child: SlideNavigationRegistrar(
        child: DecoratedBox(decoration: BoxDecoration(gradient: lightGradient)),
      ),
    );
  }

  /// Background configuration for dark theme.
  static FlutterDeckBackground get darkBackground {
    return const FlutterDeckBackground.custom(
      child: SlideNavigationRegistrar(
        child: DecoratedBox(decoration: BoxDecoration(gradient: darkGradient)),
      ),
    );
  }

  /// Background configuration.
  static FlutterDeckBackgroundConfiguration get backgroundConfiguration {
    return FlutterDeckBackgroundConfiguration(
      light: lightBackground,
      dark: darkBackground,
    );
  }

  /// Footer configuration.
  static const footerConfiguration = FlutterDeckFooterConfiguration(
    showFooter: true,
    showSlideNumbers: true,
    showSocialHandle: false,
  );

  /// Header configuration.
  static const headerConfiguration = FlutterDeckHeaderConfiguration(
    showHeader: false,
  );

  /// Progress indicator configuration (blue gradient).
  static const progressIndicator = FlutterDeckProgressIndicator.gradient(
    gradient: LinearGradient(
      colors: [ThemeConfig.accentBlue, ThemeConfig.accentBlueLight],
    ),
  );
}
