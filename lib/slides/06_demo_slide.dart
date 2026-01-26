import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class DemoSlide extends FlutterDeckSlideWidget {
  const DemoSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/demo',
            title: 'Demo',
            header: FlutterDeckHeaderConfiguration(title: 'デモ'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Container(
          width: 800,
          height: 500,
          decoration: BoxDecoration(
            color: theme.materialTheme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.materialTheme.colorScheme.outline,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_circle_outline,
                size: 80,
                color: theme.materialTheme.colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'デモ動画',
                style: theme.textTheme.title,
              ),
              const SizedBox(height: 8),
              Text(
                '（撮影予定）',
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
