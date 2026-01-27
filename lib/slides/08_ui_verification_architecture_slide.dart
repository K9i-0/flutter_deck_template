import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class UiVerificationArchitectureSlide extends FlutterDeckSlideWidget {
  const UiVerificationArchitectureSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/ui-verification-architecture',
            title: 'UI Verification Architecture',
            header: FlutterDeckHeaderConfiguration(title: 'UI検証を行う際の構成'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.split(
      splitRatio: const SplitSlideRatio(left: 3, right: 2),
      leftBuilder: (context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // AI Agent box
            _buildBox(
              context,
              icon: Icons.psychology,
              label: 'AIエージェント',
              color: ThemeConfig.accentBlue,
              width: 320,
              height: 100,
              fontSize: 36,
              iconSize: 40,
            ),
            const SizedBox(height: 16),
            _buildArrowDown(size: 48),
            const SizedBox(height: 16),
            // Skills container wrapping MCP and CLI
            Container(
              padding: const EdgeInsets.fromLTRB(32, 20, 32, 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ThemeConfig.textSecondary.withValues(alpha: 0.5),
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Column(
                children: [
                  // Skills label
                  Text(
                    'Skills (Option)',
                    style: theme.textTheme.subtitle.copyWith(
                      color: ThemeConfig.textSecondary,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // MCP and CLI boxes
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildBox(
                        context,
                        icon: Icons.dns,
                        label: 'MCP',
                        color: ThemeConfig.accentBlue,
                        width: 180,
                        height: 100,
                        fontSize: 36,
                        iconSize: 40,
                      ),
                      const SizedBox(width: 40),
                      _buildBox(
                        context,
                        icon: Icons.terminal,
                        label: 'CLI',
                        color: ThemeConfig.accentBlue,
                        width: 180,
                        height: 100,
                        fontSize: 36,
                        iconSize: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildArrowDown(size: 48),
            const SizedBox(height: 16),
            // Flutter App box
            _buildBox(
              context,
              icon: Icons.phone_android,
              label: 'Flutterアプリ',
              color: ThemeConfig.accentBlueLight,
              width: 340,
              height: 100,
              fontSize: 36,
              iconSize: 40,
            ),
          ],
        ),
      ),
      rightBuilder: (context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // UIの把握セクション
            Text(
              'UIの把握',
              style: theme.textTheme.subtitle.copyWith(
                color: ThemeConfig.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildBulletPoint(context, '画面要素の取得'),
            const SizedBox(height: 8),
            _buildBulletPoint(context, 'スクショ'),
            const SizedBox(height: 48),
            // UI操作セクション
            Text(
              'UI操作',
              style: theme.textTheme.subtitle.copyWith(
                color: ThemeConfig.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildBulletPoint(context, 'タップ操作'),
            const SizedBox(height: 8),
            _buildBulletPoint(context, 'テキスト入力'),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    final theme = FlutterDeckTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '• ',
          style: theme.textTheme.bodyLarge.copyWith(
            color: ThemeConfig.textPrimary,
          ),
        ),
        Text(
          text,
          style: theme.textTheme.bodyLarge.copyWith(
            color: ThemeConfig.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildBox(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required double width,
    required double height,
    double fontSize = 26,
    double iconSize = 24,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: iconSize),
          const SizedBox(width: 12),
          Text(
            label,
            style: theme.textTheme.bodyLarge.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrowDown({double size = 32}) {
    return Icon(
      Icons.arrow_downward,
      color: ThemeConfig.textSecondary,
      size: size,
    );
  }
}
