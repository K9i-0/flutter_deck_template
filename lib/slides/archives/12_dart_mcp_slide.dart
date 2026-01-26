import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class DartMcpSlide extends FlutterDeckSlideWidget {
  const DartMcpSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/dart-mcp',
            title: 'Dart MCP Server',
            header: FlutterDeckHeaderConfiguration(
              title: 'Dart MCP Server',
            ),
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
                  Text(
                    '主要機能',
                    style: theme.textTheme.subtitle,
                  ),
                  const SizedBox(height: 24),
                  _buildFeatureItem(
                    context,
                    'launch_app',
                    'Flutterアプリ起動',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    context,
                    'hot_reload',
                    '変更を即時反映',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    context,
                    'hot_restart',
                    '状態をリセットして再起動',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    context,
                    'get_widget_tree',
                    'ウィジェット構造取得',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    context,
                    'get_runtime_errors',
                    'ランタイムエラー取得',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.materialTheme.colorScheme.primaryContainer,
                          theme.materialTheme.colorScheme.secondaryContainer,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.flutter_dash,
                          size: 64,
                          color: theme.materialTheme.colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Dart Tooling Daemon',
                          style: theme.textTheme.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Flutter SDK標準機能を\nMCP経由で利用',
                          style: theme.textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          theme.materialTheme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: theme.materialTheme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Maestro MCPと組み合わせて\n完全な自動化を実現',
                          style: theme.textTheme.bodySmall.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    String name,
    String description,
  ) {
    final theme = FlutterDeckTheme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: theme.materialTheme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            name,
            style: theme.textTheme.bodySmall.copyWith(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
