import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:marionette_flutter/marionette_flutter.dart';

import 'config/presentation_config.dart';
import 'config/speaker_info.dart';
import 'config/theme_config.dart';
import 'slides/slides.dart';
import 'utils/slide_navigation.dart';
import 'widgets/presentation_timer.dart';

void main() {
  if (kDebugMode) {
    MarionetteBinding.ensureInitialized();
    _registerDeckNavigationExtensions();
  }
  runApp(const PresentationApp());
}

void _registerDeckNavigationExtensions() {
  registerExtension('ext.flutter.deckNavigation.goToSlide',
      (method, params) async {
    final slideNumberStr = params['slideNumber'];
    if (slideNumberStr == null) {
      return ServiceExtensionResponse.error(
        -1,
        'Missing required parameter: slideNumber',
      );
    }
    final slideNumber = int.tryParse(slideNumberStr);
    if (slideNumber == null) {
      return ServiceExtensionResponse.error(
        -1,
        'Invalid slideNumber: $slideNumberStr',
      );
    }
    if (!SlideNavigation.isAvailable) {
      return ServiceExtensionResponse.error(
        -1,
        'SlideNavigation not yet registered. Is a slide being displayed?',
      );
    }
    SlideNavigation.goToSlide(slideNumber);
    return ServiceExtensionResponse.result(
      '{"status":"Success","slideNumber":$slideNumber}',
    );
  });

  registerExtension('ext.flutter.deckNavigation.getSlideInfo',
      (method, params) async {
    if (!SlideNavigation.isAvailable) {
      return ServiceExtensionResponse.error(
        -1,
        'SlideNavigation not yet registered. Is a slide being displayed?',
      );
    }
    final current = SlideNavigation.currentSlide;
    final total = SlideNavigation.slideCount;
    return ServiceExtensionResponse.result(
      '{"status":"Success","currentSlide":$current,"slideCount":$total}',
    );
  });
}

const showTimer = bool.fromEnvironment('SHOW_TIMER', defaultValue: true);

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          FlutterDeckApp(
            configuration: FlutterDeckConfiguration(
              slideSize: PresentationConfig.slideSize,
              transition: PresentationConfig.transition,
              background: PresentationConfig.backgroundConfiguration,
              header: PresentationConfig.headerConfiguration,
              footer: PresentationConfig.footerConfiguration,
              progressIndicator: PresentationConfig.progressIndicator,
              marker: const FlutterDeckMarkerConfiguration(
                color: ThemeConfig.accentBlue,
                strokeWidth: 4,
              ),
            ),
            lightTheme: ThemeConfig.lightTheme,
            darkTheme: ThemeConfig.darkTheme,
            themeMode: ThemeMode.dark,
            speakerInfo: const FlutterDeckSpeakerInfo(
              name: SpeakerInfo.name,
              description: SpeakerInfo.description,
              socialHandle: SpeakerInfo.socialHandle,
              imagePath: SpeakerInfo.avatarPath,
            ),
            slides: const [
              TitleSlide(),
              ProblemSlide(),
              ArchitectureSlide(),
              DemoSlide(),
              SummarySlide(),
            ],
          ),
          if (showTimer)
            const Positioned(
              top: 16,
              right: 16,
              child: PresentationTimer(),
            ),
        ],
      ),
    );
  }
}
