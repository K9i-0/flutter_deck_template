import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

/// Sample split slide demonstrating 2-column layout.
///
/// This slide shows how to:
/// - Use FlutterDeckSlide.split() for side-by-side content
/// - Use FlutterDeckCodeHighlight for code display
/// - Use FlutterDeckBulletList for bullet points
class SampleSplitSlide extends FlutterDeckSlideWidget {
  const SampleSplitSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/sample-split',
          title: 'Sample Split',
          header: FlutterDeckHeaderConfiguration(title: 'Sample Split Slide'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.all(32),
          child: FlutterDeckBulletList(
            items: const [
              'split() で2カラムレイアウト',
              'leftBuilder / rightBuilder',
              'コードと説明の並列表示に最適',
            ],
          ),
        );
      },
      rightBuilder: (context) {
        return const Padding(
          padding: EdgeInsets.all(32),
          child: FlutterDeckCodeHighlight(
            code: '''
class MySlide extends FlutterDeckSlideWidget {
  const MySlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/my-slide',
          title: 'My Slide',
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => ...,
      rightBuilder: (context) => ...,
    );
  }
}''',
            fileName: 'my_slide.dart',
            language: 'dart',
          ),
        );
      },
    );
  }
}
