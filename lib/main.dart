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
        background: PresentationConfig.backgroundConfiguration,
        header: PresentationConfig.headerConfiguration,
        footer: PresentationConfig.footerConfiguration,
        progressIndicator: PresentationConfig.progressIndicator,
        marker: const FlutterDeckMarkerConfiguration(
          color: Color(0xFFef4444),
          strokeWidth: 4,
        ),
      ),
      lightTheme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      themeMode: ThemeMode.dark,
      speakerInfo: SpeakerInfo.avatarPath != null
          ? FlutterDeckSpeakerInfo(
              name: SpeakerInfo.name,
              description: SpeakerInfo.description,
              socialHandle: SpeakerInfo.socialHandle,
              imagePath: SpeakerInfo.avatarPath!,
            )
          : null,
      slides: const [
        TitleSlide(),
        AboutSlide(),
        FeaturesSlide(),
        SlideTypesSlide(),
        ClaudeIntegrationSlide(),
        HowToUseSlide(),
        // CodeHighlightSlide(),
        // InteractiveCounterSlide(),
        ThankYouSlide(),
      ],
    );
  }
}
