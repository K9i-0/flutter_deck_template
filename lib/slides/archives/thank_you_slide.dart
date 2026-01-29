import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class ThankYouSlide extends FlutterDeckSlideWidget {
  const ThankYouSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/thank-you',
            title: 'Thank You',
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
                'Thank You!',
                style: theme.textTheme.display,
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.materialTheme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      'まとめ',
                      style: theme.textTheme.subtitle.copyWith(
                        color: theme.materialTheme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryItem(
                      context,
                      '1',
                      'AIの自律性を高めることで生産性向上',
                    ),
                    const SizedBox(height: 8),
                    _buildSummaryItem(
                      context,
                      '2',
                      'フィードバックループが鍵',
                    ),
                    const SizedBox(height: 8),
                    _buildSummaryItem(
                      context,
                      '3',
                      'Flutter: Maestro MCP + Dart MCPで実現可能',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.code,
                    color: theme.materialTheme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'github.com/K9i-0/flutter_claude_sandbox',
                    style: theme.textTheme.bodyLarge.copyWith(
                      color: theme.materialTheme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String number,
    String text,
  ) {
    final theme = FlutterDeckTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.materialTheme.colorScheme.primary,
          ),
          child: Center(
            child: Text(
              number,
              style: theme.textTheme.bodySmall.copyWith(
                color: theme.materialTheme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
