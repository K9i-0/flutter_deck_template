import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class DartMcpComplementSlide extends FlutterDeckSlideWidget {
  const DartMcpComplementSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/dart-mcp-complement',
          title: 'Recommended MCP Combination',
          header: FlutterDeckHeaderConfiguration(title: 'Dart MCP について'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRoleComparison(context, theme),
            const SizedBox(height: 24),
            _buildTokenSummary(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleComparison(
    BuildContext context,
    FlutterDeckThemeData theme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // UI検証MCP
        Expanded(
          child: _buildRoleCard(
            context,
            title: 'UI検証 MCP',
            subtitle: '(Maestro MCP / Mobile MCP / Marionette MCP)',
            color: ThemeConfig.accentOrange,
            icon: Icons.touch_app,
            features: ['タップ・入力操作', 'スクロール', 'スクリーンショット'],
          ),
        ),
        const SizedBox(width: 24),
        // Plus sign
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
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
            title: 'Dart MCP',
            subtitle: '(SDK連携)',
            color: ThemeConfig.accentBlue,
            icon: Icons.build,
            features: [
              'ランタイムエラー取得',
              'ウィジェットツリー',
              'dart fix / format',
              'hot reload/restart',
              '（cliで良くない？ってツールも割とある）',
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
      padding: const EdgeInsets.all(24),
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
              Icon(icon, color: color, size: 36),
              const SizedBox(width: 12),
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
          const SizedBox(height: 16),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: color, size: 22),
                  const SizedBox(width: 10),
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

  Widget _buildTokenSummary(BuildContext context, FlutterDeckThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConfig.accentGreen.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.analytics,
                color: ThemeConfig.accentGreen,
                size: 24,
              ),
              const SizedBox(width: 10),
              Text(
                'トークン消費量まとめ（Claude Codeの200kトークンとの比較）',
                style: theme.textTheme.bodyLarge.copyWith(
                  color: ThemeConfig.accentGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // UI検証MCP
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UI検証MCP',
                      style: theme.textTheme.bodyMedium.copyWith(
                        color: ThemeConfig.accentOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildTokenRow(
                      context,
                      'Marionette MCP',
                      '9ツール',
                      '1,290',
                      '0.65%',
                    ),
                    _buildTokenRow(
                      context,
                      'Maestro MCP',
                      '14ツール',
                      '2,325',
                      '1.16%',
                    ),
                    _buildTokenRow(
                      context,
                      'Mobile MCP',
                      '19ツール',
                      '3,143',
                      '1.57%',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // 開発支援MCP
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SDK連携',
                      style: theme.textTheme.bodyMedium.copyWith(
                        color: ThemeConfig.accentBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildTokenRow(
                      context,
                      'Dart MCP',
                      '24ツール',
                      '6,832',
                      '3.42%',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 全部載せてもOKメッセージ
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: ThemeConfig.accentGreen.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: ThemeConfig.accentGreen,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  'いずれかのUI検証MCPとDart MCPを合わせて5%くらい',
                  style: theme.textTheme.bodyLarge.copyWith(
                    color: ThemeConfig.accentGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenRow(
    BuildContext context,
    String name,
    String tools,
    String tokens,
    String percent,
  ) {
    final theme = FlutterDeckTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: theme.textTheme.bodySmall.copyWith(
                color: ThemeConfig.textPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              tools,
              style: theme.textTheme.bodySmall.copyWith(
                color: ThemeConfig.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '$tokens tokens ($percent)',
              style: theme.textTheme.bodySmall.copyWith(
                color: ThemeConfig.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
