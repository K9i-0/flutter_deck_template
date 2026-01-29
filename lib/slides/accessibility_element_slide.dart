import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class AccessibilityElementSlide extends FlutterDeckSlideWidget {
  const AccessibilityElementSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/accessibility-element',
            title: 'Accessibility Element',
            header:
                FlutterDeckHeaderConfiguration(title: '外部アプローチのUI要素取得'),
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
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 左カラム: アクセシビリティツリーの図解
                  Expanded(
                    child: _buildLeftColumn(context, theme),
                  ),
                  const SizedBox(width: 32),
                  // 右カラム: Flutter側の対応
                  Expanded(
                    child: _buildRightColumn(context, theme),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 下部インフォボックス
            _buildInfoBox(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftColumn(BuildContext context, FlutterDeckThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Accessibility Tree',
          style: theme.textTheme.title.copyWith(
            color: ThemeConfig.accentOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: ThemeConfig.accentOrange.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'スクリーンリーダーと同じ技術',
            style: theme.textTheme.bodyMedium.copyWith(
              color: ThemeConfig.accentOrange,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: _buildAccessibilityTreeDiagram(theme),
        ),
      ],
    );
  }

  Widget _buildAccessibilityTreeDiagram(FlutterDeckThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ThemeConfig.accentOrange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConfig.accentOrange.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTreeNode('App', 0, theme),
          _buildTreeNode('TodoListScreen', 1, theme),
          _buildTreeNode('todo-fab-add', 2, theme, isHighlighted: true),
          _buildTreeNode('"Add new todo"', 3, theme, isLabel: true),
          _buildTreeNode('todo-tile-1', 2, theme, isHighlighted: true),
          _buildTreeNode('"買い物リスト"', 3, theme, isLabel: true),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.accessibility_new,
                  color: ThemeConfig.accentOrange,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'OS標準APIで外部から取得可能',
                    style: theme.textTheme.bodyMedium.copyWith(
                      color: ThemeConfig.textPrimary,
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

  Widget _buildTreeNode(
    String text,
    int depth,
    FlutterDeckThemeData theme, {
    bool isHighlighted = false,
    bool isLabel = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 24.0, bottom: 8),
      child: Row(
        children: [
          if (depth > 0) ...[
            Text(
              '└─ ',
              style: TextStyle(
                color: ThemeConfig.textSecondary,
                fontSize: 20,
                fontFamily: 'monospace',
              ),
            ),
          ],
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isHighlighted
                  ? ThemeConfig.accentOrange.withValues(alpha: 0.3)
                  : isLabel
                      ? ThemeConfig.accentBlue.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
              border: isHighlighted
                  ? Border.all(color: ThemeConfig.accentOrange, width: 2)
                  : null,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isHighlighted
                    ? ThemeConfig.accentOrange
                    : isLabel
                        ? ThemeConfig.accentBlue
                        : ThemeConfig.textPrimary,
                fontSize: 18,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                fontFamily: isLabel ? null : 'monospace',
                fontStyle: isLabel ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightColumn(BuildContext context, FlutterDeckThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter側の対応',
          style: theme.textTheme.title.copyWith(
            color: ThemeConfig.accentBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: ThemeConfig.accentBlue.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '必要に応じてSemanticsを追加',
            style: theme.textTheme.bodyMedium.copyWith(
              color: ThemeConfig.accentBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: _buildCodeExample(theme),
        ),
      ],
    );
  }

  Widget _buildCodeExample(FlutterDeckThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConfig.accentBlue.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 自動生成の説明
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: ThemeConfig.textSecondary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Text, Button等は自動でlabelが設定される\n→ 実際のツリーを確認して必要なら追加',
              style: theme.textTheme.bodySmall.copyWith(
                color: ThemeConfig.textPrimary,
              ),
            ),
          ),
          _buildCodeBlock(
            '// identifierで要素を特定可能に',
            '''Semantics(
  identifier: 'todo-fab-add',
  child: FloatingActionButton(...),
)''',
            theme,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ThemeConfig.accentBlue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildKeyPoint('identifier', 'resource-id（テスト用ID）', theme),
                const SizedBox(height: 4),
                _buildKeyPoint('label', 'accessibilityText（読み上げ）', theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBlock(
    String comment,
    String code,
    FlutterDeckThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comment,
          style: TextStyle(
            color: ThemeConfig.textSecondary,
            fontSize: 16,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          code,
          style: TextStyle(
            color: ThemeConfig.accentBlue,
            fontSize: 18,
            fontFamily: 'monospace',
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildKeyPoint(String key, String value, FlutterDeckThemeData theme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: ThemeConfig.accentBlue,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            key,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: theme.textTheme.bodySmall.copyWith(
            color: ThemeConfig.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox(FlutterDeckThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ThemeConfig.accentGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ThemeConfig.accentGreen.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: ThemeConfig.accentGreen,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium.copyWith(
                  color: ThemeConfig.textPrimary,
                ),
                children: [
                  const TextSpan(text: '調査開始時点: '),
                  TextSpan(
                    text: 'Maestro MCP充実',
                    style: TextStyle(
                      color: ThemeConfig.accentOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' / '),
                  TextSpan(
                    text: 'Mobile MCP欠けあり',
                    style: TextStyle(
                      color: ThemeConfig.accentGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: '  →  現在: '),
                  const TextSpan(
                    text: '両者ほとんど差がない',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
