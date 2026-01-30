import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class MaestroMcpSlide extends FlutterDeckSlideWidget {
  const MaestroMcpSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/maestro-mcp',
            title: 'Maestro MCP',
            header: FlutterDeckHeaderConfiguration(
              title: 'Maestro MCP',
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
                    'tap_on',
                    'ID/テキストで要素をタップ',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    context,
                    'inspect_view_hierarchy',
                    'UI要素一覧を取得（軽量）',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    context,
                    'take_screenshot',
                    'スクリーンショット取得',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    context,
                    'input_text',
                    'テキスト入力',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    context,
                    'run_flow',
                    'YAMLフロー実行',
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
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color:
                          theme.materialTheme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.accessibility_new,
                              size: 18,
                              color: theme.materialTheme.colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Semantics = UIの名札',
                              style: theme.textTheme.bodySmall.copyWith(
                                color: theme.materialTheme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '''Semantics(
  identifier: 'submit-button',
  child: ElevatedButton(...),
)''',
                          style: theme.textTheme.bodySmall.copyWith(
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '※ アクセシビリティ機能を活用',
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.materialTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Icon(
                    Icons.arrow_downward,
                    color: theme.materialTheme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.materialTheme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Maestro MCPで操作',
                          style: theme.textTheme.bodySmall.copyWith(
                            color: theme.materialTheme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'tap_on(id="submit-button")',
                          style: theme.textTheme.bodySmall.copyWith(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.materialTheme.colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '座標計算不要！',
                      style: theme.textTheme.bodyMedium.copyWith(
                        color: theme.materialTheme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
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
