import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class FeedbackLoopDefinitionSlide extends FlutterDeckSlideWidget {
  const FeedbackLoopDefinitionSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/feedback-loop-definition',
          title: 'Feedback Loop Definition',
          header: FlutterDeckHeaderConfiguration(title: 'フィードバックループとは'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            // メイン説明
            Text(
              'AIエージェント自体に検証の方法を与えて、\n動作確認 → 修正のループを回すこと',
              style: theme.textTheme.subtitle,
            ),
            const SizedBox(height: 64),
            // 検証の種類セクション
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: theme.materialTheme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '検証の例',
                    style: theme.textTheme.title.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildVerificationItem(
                    context,
                    icon: Icons.code,
                    text: 'lint',
                  ),
                  const SizedBox(height: 16),
                  _buildVerificationItem(
                    context,
                    icon: Icons.science,
                    text: 'ユニットテスト',
                  ),
                  const SizedBox(height: 16),
                  _buildVerificationItemWithSuffix(
                    context,
                    icon: Icons.smartphone,
                    text: 'AIに実際にUI操作させる',
                    suffix: '← 今回はこれ',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationItem(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    final theme = FlutterDeckTheme.of(context);
    final color = theme.materialTheme.colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          Icon(icon, size: 36, color: color),
          const SizedBox(width: 16),
          Text(text, style: theme.textTheme.subtitle.copyWith(color: color)),
        ],
      ),
    );
  }

  Widget _buildVerificationItemWithSuffix(
    BuildContext context, {
    required IconData icon,
    required String text,
    required String suffix,
  }) {
    final theme = FlutterDeckTheme.of(context);
    final grayColor = theme.materialTheme.colorScheme.onSurfaceVariant;
    final blueColor = theme.materialTheme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          Icon(icon, size: 36, color: grayColor),
          const SizedBox(width: 16),
          Text(
            text,
            style: theme.textTheme.subtitle.copyWith(color: grayColor),
          ),
          const SizedBox(width: 12),
          Text(
            suffix,
            style: theme.textTheme.subtitle.copyWith(
              color: blueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
