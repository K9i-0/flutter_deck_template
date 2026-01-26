import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class FlutterChallengeSlide extends FlutterDeckSlideWidget {
  const FlutterChallengeSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/flutter-challenge',
            title: 'Flutter Challenge',
            header: FlutterDeckHeaderConfiguration(
              title: 'Flutterでの課題',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone_android,
                    size: 80,
                    color: theme.materialTheme.colorScheme.primary,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.phone_iphone,
                    size: 80,
                    color: theme.materialTheme.colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'モバイルアプリは\n「動いているか」の確認が難しい',
                style: theme.textTheme.title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.materialTheme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 48,
                      color: theme.materialTheme.colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 24),
                    Text(
                      '従来は人間が目視で確認',
                      style: theme.textTheme.subtitle.copyWith(
                        color: theme.materialTheme.colorScheme.onErrorContainer,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Web: ブラウザMCP → Flutter: ???',
                style: theme.textTheme.bodyLarge.copyWith(
                  color: theme.materialTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
