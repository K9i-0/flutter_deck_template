import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class ClaudeIntegrationSlide extends FlutterDeckSlideWidget {
  const ClaudeIntegrationSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/claude-integration',
            title: 'Claude Integration',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.bigFact(
      title: 'Claude Code',
      subtitle: 'スキル機能でスライド作成を自動化',
    );
  }
}
