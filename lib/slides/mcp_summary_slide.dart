import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class McpSummarySlide extends FlutterDeckSlideWidget {
  const McpSummarySlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/mcp-summary',
          title: 'MCP Summary',
          header: FlutterDeckHeaderConfiguration(title: 'MCPまとめ'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(48, 32, 48, 48),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Maestro MCP
                Expanded(
                  child: _buildMcpCard(
                    context,
                    name: 'Maestro MCP',
                    color: ThemeConfig.accentOrange,
                    icon: Icons.play_circle_outline,
                    points: [
                      'run_flowでYAML実行が可能',
                      '→ 自由度の高さが強み',
                      'E2Eシナリオを参考にrun_flowしたりできる',
                      'E2Eと相互運用を狙うなら',
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Mobile MCP
                Expanded(
                  child: _buildMcpCard(
                    context,
                    name: 'Mobile MCP',
                    color: ThemeConfig.accentGreen,
                    icon: Icons.rocket_launch_outlined,
                    points: [
                      'npxなので簡単に最新版を使える',
                      '→ 導入面で楽',
                      '開発が他より積極的な印象',
                      'ネイティブでも使えるし機能も十分',
                      '→ 一番無難かも',
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Marionette MCP
                Expanded(
                  child: _buildMcpCard(
                    context,
                    name: 'Marionette MCP',
                    color: ThemeConfig.accentBlue,
                    icon: Icons.flutter_dash,
                    points: [
                      'Flutter特化',
                      'デスクトップアプリにも使えるのが便利',
                      'Flutterエンジニア的には',
                      'contributeも狙いやすそう',
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMcpCard(
    BuildContext context, {
    required String name,
    required Color color,
    required IconData icon,
    required List<String> points,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ヘッダー
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: theme.textTheme.title.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // ポイントリスト
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: points
                .map((point) => _buildPointItem(context, point, color))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPointItem(BuildContext context, String text, Color color) {
    final theme = FlutterDeckTheme.of(context);
    final isIndented = text.startsWith('→');

    return Padding(
      padding: EdgeInsets.only(bottom: 16, left: isIndented ? 28 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isIndented) ...[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge.copyWith(
                color: isIndented
                    ? ThemeConfig.textSecondary
                    : ThemeConfig.textPrimary,
                fontSize: isIndented ? 22 : 26,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
