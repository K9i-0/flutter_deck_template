import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class FeaturesSlide extends FlutterDeckSlideWidget {
  const FeaturesSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/features',
            title: 'Features',
            header: FlutterDeckHeaderConfiguration(
              title: '主な機能',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '機能一覧',
              style: FlutterDeckTheme.of(context).textTheme.header,
            ),
            const SizedBox(height: 24),
            _buildFeatureItem(context, '豊富なスライドテンプレート'),
            _buildFeatureItem(context, 'ダーク/ライトテーマ'),
            _buildFeatureItem(context, 'ステップ機能'),
            _buildFeatureItem(context, 'コードハイライト'),
            _buildFeatureItem(context, 'キーボードショートカット'),
            _buildFeatureItem(context, 'マーカー機能'),
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
              '開発体験',
              style: FlutterDeckTheme.of(context).textTheme.header,
            ),
            const SizedBox(height: 24),
            Text(
              'Claude Code のスキル機能により、\n'
              '自然言語でスライドを追加・編集できます。',
              style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Text(
              '「新しいスライドを追加して」\n'
              '「コードブロックを挿入して」\n'
              '「テーマを変更して」',
              style: FlutterDeckTheme.of(context).textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF6366f1),
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
