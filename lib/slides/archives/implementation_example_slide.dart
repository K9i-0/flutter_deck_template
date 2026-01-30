import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_template/config/theme_config.dart';

class ImplementationExampleSlide extends FlutterDeckSlideWidget {
  const ImplementationExampleSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/implementation-example',
          title: 'Implementation Example',
          header: FlutterDeckHeaderConfiguration(title: '実装例'),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Marionette用
              Expanded(
                child: _buildCodeExample(
                  context,
                  title: 'Marionette (ValueKey)',
                  subtitle: 'Flutter専用・確実に特定',
                  color: ThemeConfig.accentBlue,
                  codeLines: [
                    (false, "ElevatedButton("),
                    (true, "  key: const ValueKey('submit_btn'),"),
                    (false, "  onPressed: _onSubmit,"),
                    (false, "  child: const Text('送信'),"),
                    (false, ")"),
                  ],
                  mcpCode: step >= 2 ? "tap(key: 'submit_btn')" : null,
                ),
              ),
              const SizedBox(width: 32),
              // Maestro用
              Expanded(
                child: _buildCodeExample(
                  context,
                  title: 'Maestro MCP (Semantics)',
                  subtitle: 'iOS/Android・resource-idとして認識',
                  color: ThemeConfig.accentOrange,
                  codeLines: [
                    (false, "Semantics("),
                    (true, "  identifier: 'submit_btn',"),
                    (false, "  label: '送信ボタン',"),
                    (false, "  child: ElevatedButton("),
                    (false, "    onPressed: _onSubmit,"),
                    (false, "    child: const Text('送信'),"),
                    (false, "  ),"),
                    (false, ")"),
                  ],
                  mcpCode: step >= 2 ? "tap_on(id: 'submit_btn')" : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeExample(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
    required List<(bool highlight, String code)> codeLines,
    String? mcpCode,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.subtitle.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall.copyWith(
            color: ThemeConfig.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        // コードブロック
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: codeLines.map((line) {
              final isHighlight = line.$1;
              final code = line.$2;
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 2),
                color: isHighlight
                    ? color.withValues(alpha: 0.2)
                    : Colors.transparent,
                child: Text(
                  code,
                  style: TextStyle(
                    color: isHighlight ? color : Colors.white70,
                    fontSize: 20,
                    fontFamily: 'monospace',
                    fontWeight: isHighlight
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        if (mcpCode != null) ...[
          const Spacer(),
          // MCP呼び出し例
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.play_arrow, color: color, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'MCP呼び出し',
                      style: theme.textTheme.bodyMedium.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    mcpCode,
                    style: TextStyle(
                      color: color,
                      fontSize: 22,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
