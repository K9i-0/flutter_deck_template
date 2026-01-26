import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class MainTopicSlide extends FlutterDeckSlideWidget {
  const MainTopicSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/main-topic',
          title: 'Main Topic',
          header: FlutterDeckHeaderConfiguration(title: '本題'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(64),
          child: Text(
            'FlutterでもUI検証の\nフィードバックループを回そう',
            style: theme.textTheme.display.copyWith(height: 1.3),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
