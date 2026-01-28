import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class DartMcpComplementSlide extends FlutterDeckSlideWidget {
  const DartMcpComplementSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/dart-mcp-complement',
            title: 'dart-mcp: Development Support MCP',
            header: FlutterDeckHeaderConfiguration(title: 'dart-mcp: 開発支援MCP'),
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
              // Step 1: Role comparison
              _buildRoleComparison(context, theme),
              const SizedBox(height: 48),
              // Step 2: dart-mcp key points
              if (step >= 2) _buildDartMcpPoints(context, theme),
              if (step < 2) const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleComparison(BuildContext context, FlutterDeckThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // UI検証MCP
        Expanded(
          child: _buildRoleCard(
              context,
              title: 'UI検証 MCP',
              subtitle: '(Maestro / Mobile MCP / Marionette)',
              color: ThemeConfig.accentOrange,
              icon: Icons.touch_app,
              features: [
                'タップ・入力操作',
                'スクロール',
                'スクリーンショット',
              ],
            ),
          ),
          const SizedBox(width: 24),
          // Plus sign
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ThemeConfig.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: Text(
              '+',
              style: theme.textTheme.title.copyWith(
                color: ThemeConfig.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 24),
          // dart-mcp
        Expanded(
          child: _buildRoleCard(
            context,
            title: 'dart-mcp',
            subtitle: '(開発支援)',
            color: ThemeConfig.accentBlue,
            icon: Icons.build,
            features: [
              'ランタイムエラー取得',
              'ウィジェットツリー',
              'dart fix / format',
              'テスト実行',
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required List<String> features,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 40),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.subtitle.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall.copyWith(
                        color: ThemeConfig.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: color, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: theme.textTheme.bodyMedium.copyWith(
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

  Widget _buildDartMcpPoints(BuildContext context, FlutterDeckThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConfig.accentBlue.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: ThemeConfig.accentBlue,
                size: 32,
              ),
              const SizedBox(width: 16),
              Text(
                '実プロジェクト推奨構成',
                style: theme.textTheme.bodyLarge.copyWith(
                  color: ThemeConfig.accentBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildPointItem(
            context,
            '24ツール / 6,832 tokens (3.42%)',
            Icons.numbers,
          ),
          const SizedBox(height: 12),
          _buildPointItem(
            context,
            'UI操作機能はない → UI検証MCPと併用が前提',
            Icons.link,
          ),
          const SizedBox(height: 12),
          _buildPointItem(
            context,
            'DTD連携でFlutter固有情報を取得',
            Icons.info_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildPointItem(BuildContext context, String text, IconData icon) {
    final theme = FlutterDeckTheme.of(context);

    return Row(
      children: [
        Icon(icon, color: ThemeConfig.textSecondary, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium.copyWith(
              color: ThemeConfig.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
