import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_template/components/video_slide_content.dart';

class DemoSlide extends FlutterDeckSlideWidget {
  const DemoSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/demo',
          title: 'Demo',
          header: FlutterDeckHeaderConfiguration(title: 'デモ / 実例'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TODOアプリでの検証', style: theme.textTheme.subtitle),
                  const SizedBox(height: 24),
                  _buildDemoItem(context, '1', 'タスク依頼', '画像添付機能を追加して'),
                  const SizedBox(height: 16),
                  _buildDemoItem(
                    context,
                    '2',
                    'AI自律実行',
                    'Plan → 実装 → テスト → レビュー',
                  ),
                  const SizedBox(height: 16),
                  _buildDemoItem(context, '3', 'E2E確認', 'Maestro MCPでUI操作・検証'),
                  const SizedBox(height: 16),
                  _buildDemoItem(context, '4', '完了報告', 'スクリーンショット付きで報告'),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.materialTheme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: theme.materialTheme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '人間の介入なしで機能実装完了',
                          style: theme.textTheme.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color:
                      theme.materialTheme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.materialTheme.colorScheme.outline,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const VideoSlideContent(
                    assetPath: 'assets/videos/sample.mov',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoItem(
    BuildContext context,
    String number,
    String title,
    String description,
  ) {
    final theme = FlutterDeckTheme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.materialTheme.colorScheme.primary,
          ),
          child: Center(
            child: Text(
              number,
              style: theme.textTheme.bodyMedium.copyWith(
                color: theme.materialTheme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: theme.textTheme.bodySmall.copyWith(
                  color: theme.materialTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
