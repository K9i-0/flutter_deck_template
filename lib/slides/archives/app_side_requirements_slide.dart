import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_template/config/theme_config.dart';

class AppSideRequirementsSlide extends FlutterDeckSlideWidget {
  const AppSideRequirementsSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/app-side-requirements',
          title: 'App Side Requirements',
          header: FlutterDeckHeaderConfiguration(title: 'アプリ側の対応'),
          steps: 3,
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => FlutterDeckSlideStepsBuilder(
        builder: (context, step) => Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AI がUIを識別するための工夫',
                style: theme.textTheme.title.copyWith(
                  color: ThemeConfig.textPrimary,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 優先度ピラミッド
                    Expanded(
                      flex: 2,
                      child: _buildPriorityPyramid(context, step),
                    ),
                    const SizedBox(width: 48),
                    // 説明
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (step >= 1)
                            _buildExplanationCard(
                              context,
                              number: '1',
                              title: 'ValueKey / Semantics',
                              description: '一意のキーで要素を特定\n最も確実で高速',
                              color: ThemeConfig.accentGreen,
                              code: "ValueKey('submit_button')",
                            ),
                          if (step >= 2) ...[
                            const SizedBox(height: 16),
                            _buildExplanationCard(
                              context,
                              number: '2',
                              title: 'テキスト / ウィジェット型',
                              description: '表示テキストや型名で検索\n一意でない場合は注意',
                              color: ThemeConfig.accentOrange,
                              code: "text: '送信する'",
                            ),
                          ],
                          if (step >= 3) ...[
                            const SizedBox(height: 16),
                            _buildExplanationCard(
                              context,
                              number: '3',
                              title: 'スクリーンショット解析',
                              description: '画像認識で座標を特定\n最終手段・トークン消費大',
                              color: Colors.grey,
                              code: 'coordinates: (x, y)',
                              isLastResort: true,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityPyramid(BuildContext context, int step) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '優先度',
          style: TextStyle(color: ThemeConfig.textSecondary, fontSize: 20),
        ),
        const SizedBox(height: 16),
        // ピラミッド
        if (step >= 1)
          _buildPyramidLevel(
            context,
            label: 'Key / Semantics',
            color: ThemeConfig.accentGreen,
            width: 200,
            rank: '高',
          ),
        const SizedBox(height: 8),
        if (step >= 2)
          _buildPyramidLevel(
            context,
            label: 'Text / Type',
            color: ThemeConfig.accentOrange,
            width: 280,
            rank: '中',
          ),
        const SizedBox(height: 8),
        if (step >= 3)
          _buildPyramidLevel(
            context,
            label: 'Screenshot',
            color: Colors.grey,
            width: 360,
            rank: '低',
          ),
      ],
    );
  }

  Widget _buildPyramidLevel(
    BuildContext context, {
    required String label,
    required Color color,
    required double width,
    required String rank,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              rank,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationCard(
    BuildContext context, {
    required String number,
    required String title,
    required String description,
    required Color color,
    required String code,
    bool isLastResort = false,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isLastResort) ...[
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '最終手段',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodySmall.copyWith(
                    color: ThemeConfig.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: ThemeConfig.surfaceSecondary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    code,
                    style: const TextStyle(
                      color: ThemeConfig.textPrimary,
                      fontSize: 18,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
