import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class McpSolutionSlide extends FlutterDeckSlideWidget {
  const McpSolutionSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/mcp-solution',
            title: 'MCP Solution',
            header: FlutterDeckHeaderConfiguration(
              title: '解決策: MCP (Model Context Protocol)',
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
              'MCPとは',
              style: theme.textTheme.subtitle,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.materialTheme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'AIとツールを繋ぐ\n標準プロトコル',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToolBox(context, 'Claude Code', Icons.terminal),
                const SizedBox(width: 16),
                Icon(
                  Icons.sync_alt,
                  color: theme.materialTheme.colorScheme.primary,
                ),
                const SizedBox(width: 16),
                _buildToolBox(context, 'MCP Server', Icons.dns),
              ],
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
            Text(
              'Flutter向けMCP',
              style: theme.textTheme.subtitle.copyWith(
                color: theme.materialTheme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 32),
            _buildMcpItem(
              context,
              'Dart MCP Server',
              'アプリ起動・ホットリロード・\nウィジェットツリー取得',
              Icons.flutter_dash,
            ),
            const SizedBox(height: 24),
            _buildMcpItem(
              context,
              'Maestro MCP',
              'UI操作・要素取得・\nスクリーンショット',
              Icons.touch_app,
            ),
            const SizedBox(height: 24),
            _buildMcpItem(
              context,
              'Mobile MCP',
              'ADB/シミュレーター操作\n(フォールバック)',
              Icons.phone_android,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolBox(BuildContext context, String label, IconData icon) {
    final theme = FlutterDeckTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.materialTheme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 32,
            color: theme.materialTheme.colorScheme.onPrimaryContainer,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildMcpItem(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    final theme = FlutterDeckTheme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.materialTheme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 28,
            color: theme.materialTheme.colorScheme.onSecondaryContainer,
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
              const SizedBox(height: 4),
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
