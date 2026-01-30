import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class UiOperationComparisonSlide extends FlutterDeckSlideWidget {
  const UiOperationComparisonSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/ui-operation-comparison',
          title: 'UI Operation Comparison',
          header: FlutterDeckHeaderConfiguration(title: 'UI操作の対応状況比較'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(48, 32, 48, 32),
        child: Column(
          children: [
            // 対応操作数ランキング
            _buildRankingSection(context),
            const SizedBox(height: 20),
            // 主要操作の対応表
            Expanded(child: _buildComparisonTable(context)),
            const SizedBox(height: 16),
            // 補足
            _buildNoteSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRankingSection(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '対応操作数ランキング',
          style: theme.textTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: ThemeConfig.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildRankingBar(
              context,
              label: 'Maestro MCP',
              count: 6,
              total: 8,
              color: ThemeConfig.accentOrange,
            ),
            const SizedBox(width: 24),
            _buildRankingBar(
              context,
              label: 'Mobile MCP',
              count: 7,
              total: 8,
              color: ThemeConfig.accentGreen,
            ),
            const SizedBox(width: 24),
            _buildRankingBar(
              context,
              label: 'Marionette MCP',
              count: 5,
              total: 8,
              color: ThemeConfig.accentBlue,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRankingBar(
    BuildContext context, {
    required String label,
    required int count,
    required int total,
    required Color color,
  }) {
    final theme = FlutterDeckTheme.of(context);
    final percentage = count / total;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: theme.textTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              Text(
                '$count/$total',
                style: theme.textTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ThemeConfig.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 16,
            decoration: BoxDecoration(
              color: ThemeConfig.surfaceSecondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    // bool? : true=✅, false=❌, null=⚠️(部分対応)
    final operations = <(String, bool?, bool?, bool?)>[
      ('タップ / スクロール / テキスト入力', true, true, true),
      ('ロングタップ', true, true, false),
      ('スワイプ', true, true, null),
      ('ダブルタップ', true, true, null),
      ('ピンチ/ズーム', false, false, false),
      ('ドラッグ&ドロップ', false, false, null),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ThemeConfig.outline, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '操作対応表',
            style: theme.textTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: ThemeConfig.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          // ヘッダー行
          _buildTableHeader(context),
          const SizedBox(height: 8),
          const Divider(color: ThemeConfig.outline, thickness: 1),
          const SizedBox(height: 4),
          // データ行
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: operations
                  .map(
                    (op) => _buildTableRow(
                      context,
                      operation: op.$1,
                      maestro: op.$2,
                      mobile: op.$3,
                      marionette: op.$4,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '操作',
            style: theme.textTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: ThemeConfig.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Maestro',
              style: theme.textTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: ThemeConfig.accentOrange,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Mobile',
              style: theme.textTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: ThemeConfig.accentGreen,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Marionette',
              style: theme.textTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: ThemeConfig.accentBlue,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableRow(
    BuildContext context, {
    required String operation,
    required bool? maestro,
    required bool? mobile,
    required bool? marionette,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              operation,
              style: theme.textTheme.bodySmall.copyWith(
                color: ThemeConfig.textPrimary,
              ),
            ),
          ),
          Expanded(child: Center(child: _buildStatusIcon(maestro))),
          Expanded(child: Center(child: _buildStatusIcon(mobile))),
          Expanded(child: Center(child: _buildStatusIcon(marionette))),
        ],
      ),
    );
  }

  /// bool? : true=✅, false=❌, null=⚠️(部分対応)
  Widget _buildStatusIcon(bool? supported) {
    final Color bgColor;
    final String icon;

    if (supported == true) {
      bgColor = ThemeConfig.accentGreen.withValues(alpha: 0.15);
      icon = '✅';
    } else if (supported == false) {
      bgColor = Colors.red.withValues(alpha: 0.15);
      icon = '❌';
    } else {
      bgColor = ThemeConfig.accentOrange.withValues(alpha: 0.15);
      icon = '⚠️';
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Center(child: Text(icon, style: const TextStyle(fontSize: 16))),
    );
  }

  Widget _buildNoteSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ThemeConfig.outline, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline,
            color: ThemeConfig.accentBlue,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildNoteItem(
                  context,
                  icon: '✅',
                  text: 'UI検証としては必要十分（基本操作は全MCP対応）',
                ),
                const SizedBox(height: 6),
                _buildNoteItem(context, icon: '⚠️', text: '= 内部実装あり（MCP未公開）'),
                const SizedBox(height: 6),
                _buildNoteItem(
                  context,
                  icon: '🎯',
                  text: 'Maestro MCP: run_flowでYAML全機能が使える（他MCPにない力技が可能）',
                  color: ThemeConfig.accentOrange,
                ),
                const SizedBox(height: 6),
                _buildNoteItem(
                  context,
                  icon: '📝',
                  text: 'Mobile MCP: CLIレベルではピンチ/D&D可能（MCP未公開）',
                  color: ThemeConfig.accentGreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(
    BuildContext context, {
    required String icon,
    required String text,
    Color? color,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall.copyWith(
              color: color ?? ThemeConfig.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
