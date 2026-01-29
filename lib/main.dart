import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:marionette_flutter/marionette_flutter.dart';

import 'config/presentation_config.dart';
import 'config/speaker_info.dart';
import 'config/theme_config.dart';
import 'slides/slides.dart';
import 'widgets/presentation_timer.dart';

void main() {
  if (kDebugMode) {
    MarionetteBinding.ensureInitialized();
  }
  runApp(const PresentationApp());
}

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
              SelfIntroSlide(),
              AiDrivenDevSlide(),
              AiPowerSlide(),
              FeedbackLoopDefinitionSlide(),
              DemoSlide(),
              MainTopicSlide(),
              UiVerificationArchitectureSlide(),
              FlowComparisonSlide(),
              McpToolsOverviewSlide(),
              DartMcpComplementSlide(),
              ApproachComparisonSlide(),
              IosInternalsSlide(),
              AndroidApproachesSlide(),
              MarionetteVmServiceSlide(),
              AppSideRequirementsSlide(),
              ImplementationExampleSlide(),
              ComparisonTableSlide(),
              SummarySlide(),
            ],
          ),
          const Positioned(top: 16, right: 16, child: PresentationTimer()),
        ],
      ),
    );
  }
}
