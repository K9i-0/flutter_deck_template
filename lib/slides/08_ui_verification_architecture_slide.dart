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
            initial: true,
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // AI Agent box
            _buildBox(
              context,
              icon: Icons.psychology,
              label: 'AIエージェント',
              color: ThemeConfig.accentBlue,
              width: 380,
              height: 120,
              fontSize: 42,
              iconSize: 48,
            ),
            const SizedBox(height: 20),
            _buildArrowDown(size: 56),
            const SizedBox(height: 20),
            // Skills container wrapping MCP and CLI
            Container(
              padding: const EdgeInsets.fromLTRB(48, 24, 48, 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
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
                    ),
                  ),
                  const SizedBox(height: 28),
                  // MCP and CLI boxes
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildBox(
                        context,
                        icon: Icons.dns,
                        label: 'MCP',
                        color: ThemeConfig.accentBlue,
                        width: 240,
                        height: 120,
                        fontSize: 42,
                        iconSize: 48,
                      ),
                      const SizedBox(width: 64),
                      _buildBox(
                        context,
                        icon: Icons.terminal,
                        label: 'CLI',
                        color: ThemeConfig.accentBlue,
                        width: 240,
                        height: 120,
                        fontSize: 42,
                        iconSize: 48,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildArrowDown(size: 56),
            const SizedBox(height: 20),
            // Flutter App box
            _buildBox(
              context,
              icon: Icons.phone_android,
              label: 'Flutterアプリ',
              color: ThemeConfig.accentBlueLight,
              width: 400,
              height: 120,
              fontSize: 42,
              iconSize: 48,
            ),
          ],
        ),
      ),
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
