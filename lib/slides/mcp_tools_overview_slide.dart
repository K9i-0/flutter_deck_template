import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class McpToolsOverviewSlide extends FlutterDeckSlideWidget {
  const McpToolsOverviewSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/mcp-tools-overview',
            title: 'MCP Tools Overview',
            header: FlutterDeckHeaderConfiguration(title: '3つのUI検証MCP'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: _buildToolCard(
                    context,
                    name: 'Maestro MCP',
                    developer: 'Mobile Dev, Inc.',
                    icon: Icons.music_note,
                    color: ThemeConfig.accentOrange,
                    features: [
                      'iOS / Android',
                      'e2e実績のあるCLIツールのMCP版',
                      'maestro CLIに統合済み',
                      'e2eシナリオのYAML再利用可',
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _buildToolCard(
                    context,
                    name: 'Mobile MCP',
                    developer: 'Mobile Next',
                    icon: Icons.phone_android,
                    color: ThemeConfig.accentGreen,
                    features: [
                      'iOS / Android',
                      'マルチプラットフォームMCPの先駆者',
                      'npxでインストール（常に最新版）',
                      'アップデート頻度が高い',
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _buildToolCard(
                    context,
                    name: 'Marionette MCP',
                    developer: 'LeanCode',
                    icon: Icons.desktop_mac,
                    color: ThemeConfig.accentBlue,
                    features: [
                      '全プラットフォーム対応',
                      'Flutterパッケージとして実装',
                      'Flutter内部の仕組みで動作',
                      '他とアプローチが異なる',
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              'それぞれ触った結果、これ一択という感じではなかった',
              style: theme.textTheme.bodyLarge.copyWith(
                color: ThemeConfig.textSecondary,
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildToolCard(
    BuildContext context, {
    required String name,
    required String developer,
    required IconData icon,
    required Color color,
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
              Icon(icon, color: color, size: 48),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: theme.textTheme.subtitle.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            developer,
            style: theme.textTheme.bodyMedium.copyWith(
              color: ThemeConfig.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: color,
                    size: 24,
                  ),
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
}
