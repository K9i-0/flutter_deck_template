import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class AiDrivenDevSlide extends FlutterDeckSlideWidget {
  const AiDrivenDevSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/ai-driven-dev',
            title: 'AI Driven Development',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AI駆動開発が\n当たり前になった',
                style: theme.textTheme.display,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Text(
                'GitHub Copilot / Claude Code / Cursor ...',
                style: theme.textTheme.title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
