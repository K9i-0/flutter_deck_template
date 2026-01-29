import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_template/config/theme_config.dart';

class ComparisonTableSlide extends FlutterDeckSlideWidget {
  const ComparisonTableSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/comparison-table',
          title: 'Comparison Table',
          header: FlutterDeckHeaderConfiguration(title: '比較表'),
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
            Expanded(child: _buildComparisonTable(context)),
            const SizedBox(height: 24),
            // トークン効率の注釈
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ThemeConfig.accentBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ThemeConfig.accentBlue.withValues(alpha: 0.5),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: ThemeConfig.accentBlue,
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'トークン効率: MCPツール定義がコンテキストを消費する量。'
                      'Marionetteは最小限のツール数（9個）で0.65%と最も効率的',
                      style: theme.textTheme.bodySmall.copyWith(
                        color: ThemeConfig.textPrimary,
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

  Widget _buildComparisonTable(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    final headers = ['', 'Maestro MCP', 'Mobile MCP', 'Marionette MCP'];
    final rows = [
      ['対応OS', 'iOS / Android', 'iOS / Android', '全プラットフォーム'],
      ['アプリ改修', '不要', '不要', '必要'],
      ['リリースビルド', '○', '○', '×'],
      ['セットアップ', 'CLI install', 'npx', 'dart pub global'],
      ['ツール数', '14', '19', '9'],
      ['トークン占有率', '1.16%', '1.57%', '0.65%'],
    ];

    final toolColors = [
      ThemeConfig.accentOrange,
      ThemeConfig.accentGreen,
      ThemeConfig.accentBlue,
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConfig.textSecondary.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          children: [
            // ヘッダー行
            Container(
              color: ThemeConfig.surfaceSecondary,
              child: Row(
                children: [
                  for (var i = 0; i < headers.length; i++)
                    Expanded(
                      flex: i == 0 ? 2 : 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                        decoration: i > 0
                            ? BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: ThemeConfig.textSecondary.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                        child: Text(
                          headers[i],
                          style: theme.textTheme.bodyMedium.copyWith(
                            color: i > 0
                                ? toolColors[i - 1]
                                : ThemeConfig.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // データ行
            Expanded(
              child: Column(
                children: [
                  for (var rowIndex = 0; rowIndex < rows.length; rowIndex++)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: rowIndex.isEven
                              ? Colors.transparent
                              : ThemeConfig.surfaceSecondary.withValues(
                                  alpha: 0.3,
                                ),
                          border: Border(
                            top: BorderSide(
                              color: ThemeConfig.textSecondary.withValues(
                                alpha: 0.2,
                              ),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            for (
                              var colIndex = 0;
                              colIndex < rows[rowIndex].length;
                              colIndex++
                            )
                              Expanded(
                                flex: colIndex == 0 ? 2 : 3,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 12,
                                  ),
                                  decoration: colIndex > 0
                                      ? BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              color: ThemeConfig.textSecondary
                                                  .withValues(alpha: 0.2),
                                            ),
                                          ),
                                        )
                                      : null,
                                  child: _buildCellContent(
                                    context,
                                    rows[rowIndex][colIndex],
                                    isHeader: colIndex == 0,
                                    rowLabel: rows[rowIndex][0],
                                    colIndex: colIndex,
                                  ),
                                ),
                              ),
                          ],
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

  Widget _buildCellContent(
    BuildContext context,
    String value, {
    required bool isHeader,
    required String rowLabel,
    required int colIndex,
  }) {
    final theme = FlutterDeckTheme.of(context);

    // 特殊なセル表示
    if (value == '○') {
      return const Center(
        child: Icon(
          Icons.check_circle,
          color: ThemeConfig.accentGreen,
          size: 28,
        ),
      );
    }
    if (value == '×') {
      return Center(
        child: Icon(
          Icons.cancel,
          color: Colors.red.withValues(alpha: 0.7),
          size: 28,
        ),
      );
    }

    // トークン占有率のハイライト
    Color? highlightColor;
    if (rowLabel == 'トークン占有率') {
      if (value == '0.65%') {
        highlightColor = ThemeConfig.accentGreen;
      } else if (value == '1.57%') {
        highlightColor = Colors.red.withValues(alpha: 0.7);
      }
    }

    return Center(
      child: highlightColor != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: highlightColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                value,
                style: theme.textTheme.bodyMedium.copyWith(
                  color: highlightColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : Text(
              value,
              style: theme.textTheme.bodyMedium.copyWith(
                color: isHeader
                    ? ThemeConfig.textSecondary
                    : ThemeConfig.textPrimary,
                fontWeight: isHeader ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
    );
  }
}
