import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class NextStageSlide extends FlutterDeckSlideWidget {
  const NextStageSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/next-stage',
            title: 'Next Stage',
            header: FlutterDeckHeaderConfiguration(
              title: '次のステージへ',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'より生産性を高めるには\n何が必要か？',
                style: theme.textTheme.title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.materialTheme.colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Text(
                  '「AIを使う」から「AIに任せる」へ',
                  style: theme.textTheme.subtitle.copyWith(
                    color: theme.materialTheme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
