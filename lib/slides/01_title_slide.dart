import 'package:flutter_deck/flutter_deck.dart';

import '../config/speaker_info.dart';

class TitleSlide extends FlutterDeckSlideWidget {
  const TitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/title',
            title: 'Title',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.title(
      title: SpeakerInfo.presentationTitle,
      subtitle: SpeakerInfo.presentationSubtitle,
    );
  }
}
