import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

/// Presentation configuration for Flutter Deck.
class PresentationConfig {
  PresentationConfig._();

  /// Slide size configuration (16:9 aspect ratio, FHD).
  static const slideSize = FlutterDeckSlideSize.ratio16x9;

  /// Default transition between slides.
  static const transition = FlutterDeckTransition.fade();

  /// Background configuration for light theme.
  static FlutterDeckBackground get lightBackground {
    return FlutterDeckBackground.gradient(
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white,
          Colors.grey.shade100,
        ],
      ),
    );
  }

  /// Background configuration for dark theme.
  static FlutterDeckBackground get darkBackground {
    return FlutterDeckBackground.gradient(
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF1a1a2e),
          const Color(0xFF16213e),
        ],
      ),
    );
  }

  /// Footer configuration.
  static FlutterDeckFooterConfiguration footerConfiguration({
    required String socialHandle,
  }) {
    return FlutterDeckFooterConfiguration(
      showFooter: true,
      showSlideNumbers: true,
      showSocialHandle: true,
      socialHandle: socialHandle,
    );
  }

  /// Header configuration.
  static const headerConfiguration = FlutterDeckHeaderConfiguration(
    showHeader: false,
  );

  /// Progress indicator configuration.
  static const progressIndicator = FlutterDeckProgressIndicator.gradient(
    gradient: LinearGradient(
      colors: [
        Color(0xFF6366f1),
        Color(0xFF8b5cf6),
      ],
    ),
  );
}
