import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class ApproachComparisonSlide extends FlutterDeckSlideWidget {
  const ApproachComparisonSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/approach-comparison',
          title: 'Approach Comparison',
          header: FlutterDeckHeaderConfiguration(title: '外部アプローチ vs 内部アプローチ'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(48),
        child: Row(
          children: [
            // 外部アプローチ
            Expanded(
              child: _buildApproachColumn(
                context,
                title: '外部アプローチ',
                subtitle: 'Maestro MCP / Mobile MCP',
                color: ThemeConfig.accentOrange,
                diagram: _buildExternalDiagram(context),
                points: [
                  'OS標準APIを経由',
                  'アプリ改修不要',
                  'リリースビルドも対応',
                  'iOS/Android対応',
                ],
              ),
            ),
            // 中央の区切り
            Container(
              width: 3,
              margin: const EdgeInsets.symmetric(horizontal: 32),
              color: ThemeConfig.textSecondary.withValues(alpha: 0.3),
            ),
            // 内部アプローチ
            Expanded(
              child: _buildApproachColumn(
                context,
                title: '内部アプローチ',
                subtitle: 'Marionette MCP',
                color: ThemeConfig.accentBlue,
                diagram: _buildInternalDiagram(context),
                points: [
                  'Flutter内部APIを使用',
                  'アプリに統合が必要',
                  'デバッグビルドのみ',
                  '全プラットフォーム対応',
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApproachColumn(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
    required Widget diagram,
    required List<String> points,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Column(
      children: [
        Text(
          title,
          style: theme.textTheme.title.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium.copyWith(
            color: ThemeConfig.textSecondary,
          ),
        ),
        const SizedBox(height: 32),
        Expanded(child: diagram),
        const SizedBox(height: 24),
        ...points.map(
          (point) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Icon(Icons.arrow_right, color: color, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    point,
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
    );
  }

  Widget _buildExternalDiagram(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBox(context, 'MCP Server', ThemeConfig.accentOrange),
        const SizedBox(height: 12),
        _buildArrowDown(),
        const SizedBox(height: 12),
        _buildBox(context, 'OS API', ThemeConfig.textSecondary),
        const Text(
          '(XCUITest / ADB)',
          style: TextStyle(color: ThemeConfig.textSecondary, fontSize: 18),
        ),
        const SizedBox(height: 12),
        _buildArrowDown(),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ThemeConfig.accentOrange.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.phone_android,
                color: ThemeConfig.accentOrange,
                size: 40,
              ),
              SizedBox(height: 4),
              Text(
                'アプリ（外部操作）',
                style: TextStyle(
                  color: ThemeConfig.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInternalDiagram(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBox(context, 'MCP Server', ThemeConfig.accentBlue),
        const SizedBox(height: 12),
        _buildArrowDown(),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ThemeConfig.accentBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ThemeConfig.accentBlue, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.phone_android,
                    color: ThemeConfig.accentBlue,
                    size: 40,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Flutterアプリ',
                    style: TextStyle(
                      color: ThemeConfig.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: ThemeConfig.accentBlue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'MarionetteBinding\n（Widget Tree直接操作）',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeConfig.accentBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBox(BuildContext context, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildArrowDown() {
    return const Icon(
      Icons.arrow_downward,
      color: ThemeConfig.textSecondary,
      size: 32,
    );
  }
}
