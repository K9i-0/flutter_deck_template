import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class SummarySlide extends FlutterDeckSlideWidget {
  const SummarySlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/summary',
            title: 'Summary',
            header: FlutterDeckHeaderConfiguration(title: 'まとめ'),
            steps: 2,
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
                'ユースケース別おすすめ',
                style: theme.textTheme.title.copyWith(
                  color: ThemeConfig.textPrimary,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildRecommendationCard(
                        context,
                        icon: Icons.phone_android,
                        title: 'iOS/Android\nモバイルアプリ',
                        tools: 'Maestro / Mobile MCP',
                        reasons: [
                          'ネイティブAPI経由で操作',
                          'アプリ改修不要',
                          'リリースビルドも対応',
                        ],
                        color: ThemeConfig.accentOrange,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildRecommendationCard(
                        context,
                        icon: Icons.desktop_mac,
                        title: 'Flutter\nデスクトップアプリ',
                        tools: 'Marionette MCP',
                        reasons: [
                          'デスクトップ専用',
                          'Hot Reload連携',
                          '軽量・高速',
                        ],
                        color: ThemeConfig.accentBlue,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildRecommendationCard(
                        context,
                        icon: Icons.build,
                        title: 'CI/CD\n自動テスト',
                        tools: 'Maestro MCP',
                        reasons: [
                          'YAMLフロー再利用',
                          '安定した接続',
                          '豊富な機能',
                        ],
                        color: ThemeConfig.accentGreen,
                      ),
                    ),
                  ],
                ),
              ),
              if (step >= 2) ...[
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ThemeConfig.accentBlue.withValues(alpha: 0.15),
                        ThemeConfig.accentGreen.withValues(alpha: 0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: ThemeConfig.accentBlue.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'MCPでUI検証フィードバックループを回そう！',
                        style: theme.textTheme.subtitle.copyWith(
                          color: ThemeConfig.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '階層構造を優先、スクショは最終手段\n'
                        'ValueKey / Semantics で確実に要素を特定',
                        style: theme.textTheme.bodyMedium.copyWith(
                          color: ThemeConfig.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String tools,
    required List<String> reasons,
    required Color color,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyLarge.copyWith(
                    color: ThemeConfig.textPrimary,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              tools,
              style: theme.textTheme.bodyMedium.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          ...reasons.map(
            (reason) => Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: color,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      reason,
                      style: theme.textTheme.bodySmall.copyWith(
                        color: ThemeConfig.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
