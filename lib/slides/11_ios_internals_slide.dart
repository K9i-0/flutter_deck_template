import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class IosInternalsSlide extends FlutterDeckSlideWidget {
  const IosInternalsSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/ios-internals',
            title: 'iOS Internals',
            header: FlutterDeckHeaderConfiguration(title: 'iOS通信の仕組み'),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (step >= 1) ...[
                Text(
                  'どちらも最終的にXCUITestを使用',
                  style: theme.textTheme.title.copyWith(
                    color: ThemeConfig.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Apple公式のリモートUI操作APIが無いため、迂回が必要',
                  style: theme.textTheme.bodyMedium.copyWith(
                    color: ThemeConfig.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),
              ],
              Expanded(
                child: Row(
                  children: [
                    // Maestro側
                    Expanded(
                      child: _buildArchitectureColumn(
                        context,
                        title: 'Maestro',
                        color: ThemeConfig.accentOrange,
                        layers: [
                          _LayerInfo('Maestro CLI', 'Kotlin製'),
                          _LayerInfo('独自XCUITestランナー', 'Swift製・ポート22087'),
                          _LayerInfo('XCUITest', 'Apple公式'),
                        ],
                        highlight: step >= 2,
                        highlightIndex: 1,
                      ),
                    ),
                    const SizedBox(width: 48),
                    // Mobile MCP側
                    Expanded(
                      child: _buildArchitectureColumn(
                        context,
                        title: 'Mobile MCP',
                        color: ThemeConfig.accentGreen,
                        layers: [
                          _LayerInfo('mobilecli', 'Go製'),
                          _LayerInfo('WDA (WebDriverAgent)', 'Appium管理・ポート8100'),
                          _LayerInfo('XCUITest', 'Apple公式'),
                        ],
                        highlight: step >= 2,
                        highlightIndex: 1,
                      ),
                    ),
                  ],
                ),
              ),
              if (step >= 2) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
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
                      Icon(
                        Icons.lightbulb_outline,
                        color: ThemeConfig.accentBlue,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          '中間層が異なる: Maestroは独自開発、Mobile MCPはAppium製WDAを使用',
                          style: theme.textTheme.bodyMedium.copyWith(
                            color: ThemeConfig.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArchitectureColumn(
    BuildContext context, {
    required String title,
    required Color color,
    required List<_LayerInfo> layers,
    bool highlight = false,
    int highlightIndex = -1,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Column(
      children: [
        Text(
          title,
          style: theme.textTheme.subtitle.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < layers.length; i++) ...[
                _buildLayerBox(
                  context,
                  layer: layers[i],
                  color: color,
                  isHighlighted: highlight && i == highlightIndex,
                  isAppleOfficial: i == layers.length - 1,
                ),
                if (i < layers.length - 1) ...[
                  const SizedBox(height: 8),
                  Icon(
                    Icons.arrow_downward,
                    color: ThemeConfig.textSecondary,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLayerBox(
    BuildContext context, {
    required _LayerInfo layer,
    required Color color,
    bool isHighlighted = false,
    bool isAppleOfficial = false,
  }) {
    final boxColor = isAppleOfficial ? Colors.grey : color;
    final borderWidth = isHighlighted ? 4.0 : 2.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: boxColor.withValues(alpha: isHighlighted ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlighted ? color : boxColor,
          width: borderWidth,
        ),
      ),
      child: Column(
        children: [
          Text(
            layer.name,
            style: TextStyle(
              color: isAppleOfficial ? ThemeConfig.textPrimary : color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            layer.description,
            style: TextStyle(
              color: ThemeConfig.textSecondary,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _LayerInfo {
  final String name;
  final String description;

  _LayerInfo(this.name, this.description);
}
