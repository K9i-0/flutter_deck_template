import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class FeedbackLoopSlide extends FlutterDeckSlideWidget {
  const FeedbackLoopSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/feedback-loop',
            title: 'Feedback Loop',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.bigFact(
      title: 'フィードバックループ\nが重要',
      subtitle: 'Claude Code作者: 自己検証能力が生産性向上の鍵',
    );
  }
}
