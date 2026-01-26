import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class AiDrivenDevSlide extends FlutterDeckSlideWidget {
  const AiDrivenDevSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/ai-driven-dev',
          title: 'AI Driven Development',
          steps: 3,
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);
    return FlutterDeckSlide.blank(
      builder: (context) => FlutterDeckSlideStepsBuilder(
        builder: (context, step) => switch (step) {
          1 => Center(
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
                    'Claude Code / Cursor / Codex CLI ...',
                    style: theme.textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          2 => Padding(
            padding: const EdgeInsets.all(64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '私は',
                  style: theme.textTheme.title,
                ),
                const SizedBox(height: 32),
                Text(
                  '9割くらいAIエージェントに書かせてる',
                  style: theme.textTheme.header,
                ),
                const SizedBox(height: 16),
                Text(
                  '（制約がややこしいUI組むときとかだけ手書き）',
                  style: theme.textTheme.bodyLarge.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          3 => Padding(
            padding: const EdgeInsets.all(64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Claude Code + VS Code',
                  style: theme.textTheme.title,
                ),
                const SizedBox(height: 48),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Claude Code',
                            style: theme.textTheme.subtitle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '基本全部',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 64),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'VS Code',
                            style: theme.textTheme.subtitle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '手書きするときだけ\nAI機能はあえて使わず',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _ => throw UnimplementedError(),
        },
      ),
    );
  }
}
