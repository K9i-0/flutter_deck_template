import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class HumanAnalogySlide extends FlutterDeckSlideWidget {
  const HumanAnalogySlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/human-analogy',
            title: 'Human Team Analogy',
            header: FlutterDeckHeaderConfiguration(
              title: '人間のチーム運営と同じ',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'シニア1人が複数のジュニアを見れる理由',
              style: theme.textTheme.subtitle,
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPersonCard(
                  context,
                  'シニア',
                  Icons.engineering,
                  theme.materialTheme.colorScheme.primaryContainer,
                ),
                const SizedBox(width: 32),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      size: 32,
                      color: theme.materialTheme.colorScheme.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'レビュー',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(width: 32),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildPersonCard(
                      context,
                      'ジュニアA',
                      Icons.person,
                      theme.materialTheme.colorScheme.secondaryContainer,
                    ),
                    const SizedBox(height: 16),
                    _buildPersonCard(
                      context,
                      'ジュニアB',
                      Icons.person,
                      theme.materialTheme.colorScheme.secondaryContainer,
                    ),
                    const SizedBox(height: 16),
                    _buildPersonCard(
                      context,
                      'ジュニアC',
                      Icons.person,
                      theme.materialTheme.colorScheme.secondaryContainer,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.materialTheme.colorScheme.primary,
                    theme.materialTheme.colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'ジュニアがセルフチェックできるから',
                style: theme.textTheme.bodyLarge.copyWith(
                  color: theme.materialTheme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'AIも同じ。セルフチェック能力がスケーラビリティの鍵',
              style: theme.textTheme.bodyLarge.copyWith(
                color: theme.materialTheme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonCard(
    BuildContext context,
    String label,
    IconData icon,
    Color backgroundColor,
  ) {
    final theme = FlutterDeckTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 4),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
