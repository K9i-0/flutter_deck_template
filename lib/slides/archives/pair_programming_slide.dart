import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class PairProgrammingSlide extends FlutterDeckSlideWidget {
  const PairProgrammingSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/pair-programming',
            title: 'Pair Programming Style',
            header: FlutterDeckHeaderConfiguration(
              title: '従来: ペアプログラミング的',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.split(
      leftBuilder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIcon(context, Icons.person, '人間'),
                const SizedBox(width: 24),
                Icon(
                  Icons.sync_alt,
                  size: 48,
                  color: theme.materialTheme.colorScheme.primary,
                ),
                const SizedBox(width: 24),
                _buildIcon(context, Icons.smart_toy, 'AI'),
              ],
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.materialTheme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '毎ステップで確認・判断',
                style: theme.textTheme.bodyLarge.copyWith(
                  color: theme.materialTheme.colorScheme.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
      ),
      rightBuilder: (context) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '問題点',
              style: theme.textTheme.subtitle.copyWith(
                color: theme.materialTheme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            _buildProblemItem(context, '人間とAIの1対1'),
            const SizedBox(height: 16),
            _buildProblemItem(context, '毎ステップで人間の判断が必要'),
            const SizedBox(height: 16),
            _buildProblemItem(context, '人間がボトルネックになる'),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.materialTheme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'AIの生産性を活かしきれない',
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, IconData icon, String label) {
    final theme = FlutterDeckTheme.of(context);
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.materialTheme.colorScheme.primaryContainer,
          ),
          child: Icon(
            icon,
            size: 48,
            color: theme.materialTheme.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: theme.textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildProblemItem(BuildContext context, String text) {
    final theme = FlutterDeckTheme.of(context);
    return Row(
      children: [
        Icon(
          Icons.warning_amber,
          color: theme.materialTheme.colorScheme.error,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: theme.textTheme.bodyLarge),
        ),
      ],
    );
  }
}
