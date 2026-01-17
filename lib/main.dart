import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import 'config/presentation_config.dart';
import 'config/speaker_info.dart';
import 'config/theme_config.dart';
import 'slides/slides.dart';

void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterDeckApp(
      configuration: FlutterDeckConfiguration(
        slideSize: PresentationConfig.slideSize,
        transition: PresentationConfig.transition,
        background: PresentationConfig.darkBackground,
        header: PresentationConfig.headerConfiguration,
        footer: PresentationConfig.footerConfiguration(
          socialHandle: SpeakerInfo.socialHandle,
        ),
        progressIndicator: PresentationConfig.progressIndicator,
        controls: const FlutterDeckControlsConfiguration(
          shortcuts: FlutterDeckShortcutsConfiguration(
            enabled: true,
            nextSlide: SingleActivator(LogicalKeyboardKey.arrowRight),
            previousSlide: SingleActivator(LogicalKeyboardKey.arrowLeft),
            toggleMarker: SingleActivator(
              LogicalKeyboardKey.keyM,
              control: true,
            ),
            toggleNavigationDrawer: SingleActivator(
              LogicalKeyboardKey.period,
              control: true,
            ),
          ),
        ),
        marker: const FlutterDeckMarkerConfiguration(
          color: Color(0xFFef4444),
          strokeWidth: 4,
        ),
      ),
      lightTheme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      themeMode: ThemeMode.dark,
      speakerInfo: FlutterDeckSpeakerInfo(
        name: SpeakerInfo.name,
        description: SpeakerInfo.description,
        socialHandle: SpeakerInfo.socialHandle,
        imagePath: SpeakerInfo.avatarPath,
      ),
      slides: const [
        TitleSlide(),
        AboutSlide(),
        FeaturesSlide(),
        SlideTypesSlide(),
        ClaudeIntegrationSlide(),
        HowToUseSlide(),
        ThankYouSlide(),
      ],
    );
  }
}
