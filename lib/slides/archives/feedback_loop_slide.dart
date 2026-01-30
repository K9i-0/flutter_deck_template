import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class FeedbackLoopSlide extends FlutterDeckSlideWidget {
  const FeedbackLoopSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/feedback-loop',
            title: 'Feedback Loop',
            header: FlutterDeckHeaderConfiguration(
              title: 'フィードバックループが重要',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.split(
      leftBuilder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'フィードバックループとは',
              style: theme.textTheme.subtitle,
            ),
            const SizedBox(height: 24),
            _buildLoopDiagram(context),
            const SizedBox(height: 24),
            Text(
              'AIが自分で結果を確認し\n改善できる仕組み',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      rightBuilder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.materialTheme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.format_quote,
                        color: theme.materialTheme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Claude Code 開発者',
                        style: theme.textTheme.bodySmall.copyWith(
                          color: theme.materialTheme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '自己検証能力が\n生産性向上の鍵',
                    style: theme.textTheme.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildKeyPoint(
              context,
              '従来',
              '人間が毎回確認 → ボトルネック',
              Icons.person,
            ),
            const SizedBox(height: 16),
            _buildKeyPoint(
              context,
              '理想',
              'AIが自律的に検証 → スケール',
              Icons.smart_toy,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoopDiagram(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);
    final items = ['実装', '実行', '確認', '改善'];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.materialTheme.colorScheme.primary.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: theme.materialTheme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                items[i],
                style: theme.textTheme.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (i < items.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: theme.materialTheme.colorScheme.primary,
                ),
              ),
          ],
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              Icons.refresh,
              size: 24,
              color: theme.materialTheme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyPoint(
    BuildContext context,
    String label,
    String description,
    IconData icon,
  ) {
    final theme = FlutterDeckTheme.of(context);
    return Row(
      children: [
        Icon(icon, size: 28, color: theme.materialTheme.colorScheme.primary),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall.copyWith(
                color: theme.materialTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              description,
              style: theme.textTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
