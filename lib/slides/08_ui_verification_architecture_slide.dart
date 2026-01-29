import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

enum InteractionMode { none, uiGrab, uiOperate }

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
    return FlutterDeckSlide.blank(
      builder: (context) => const _InteractiveArchitectureContent(),
    );
  }
}

class _InteractiveArchitectureContent extends StatefulWidget {
  const _InteractiveArchitectureContent();

  @override
  State<_InteractiveArchitectureContent> createState() =>
      _InteractiveArchitectureContentState();
}

class _InteractiveArchitectureContentState
    extends State<_InteractiveArchitectureContent> {
  InteractionMode _mode = InteractionMode.none;

  void _onModeChanged(InteractionMode mode) {
    setState(() {
      _mode = _mode == mode ? InteractionMode.none : mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _LeftContent(mode: _mode),
        ),
        Expanded(
          flex: 2,
          child: _RightContent(
            mode: _mode,
            onModeChanged: _onModeChanged,
          ),
        ),
      ],
    );
  }
}

class _LeftContent extends StatelessWidget {
  const _LeftContent({required this.mode});

  final InteractionMode mode;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return Center(
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
          _buildBidirectionalArrow(size: 48),
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
          _buildBidirectionalArrow(size: 48),
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
    );
  }

  Widget _buildBidirectionalArrow({double size = 32}) {
    final upColor = mode == InteractionMode.uiGrab
        ? ThemeConfig.accentOrange
        : ThemeConfig.textSecondary.withValues(alpha: 0.3);
    final downColor = mode == InteractionMode.uiOperate
        ? ThemeConfig.accentGreen
        : ThemeConfig.textSecondary.withValues(alpha: 0.3);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.arrow_upward,
          color: upColor,
          size: size,
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.arrow_downward,
          color: downColor,
          size: size,
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
}

class _RightContent extends StatelessWidget {
  const _RightContent({
    required this.mode,
    required this.onModeChanged,
  });

  final InteractionMode mode;
  final ValueChanged<InteractionMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    final isUiGrabSelected = mode == InteractionMode.uiGrab;
    final isUiOperateSelected = mode == InteractionMode.uiOperate;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // UIの把握セクション
          GestureDetector(
            onTap: () => onModeChanged(InteractionMode.uiGrab),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isUiGrabSelected
                      ? ThemeConfig.accentOrange.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isUiGrabSelected
                        ? ThemeConfig.accentOrange
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity:
                      mode == InteractionMode.none || isUiGrabSelected ? 1.0 : 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isUiGrabSelected)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.arrow_upward,
                                color: ThemeConfig.accentOrange,
                                size: 32,
                              ),
                            ),
                          Text(
                            'UIの把握',
                            style: theme.textTheme.subtitle.copyWith(
                              color: isUiGrabSelected
                                  ? ThemeConfig.accentOrange
                                  : ThemeConfig.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildBulletPoint(
                        context,
                        '画面要素の取得',
                        isHighlighted: isUiGrabSelected,
                      ),
                      const SizedBox(height: 8),
                      _buildBulletPoint(
                        context,
                        'スクショ',
                        isHighlighted: isUiGrabSelected,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          // UI操作セクション
          GestureDetector(
            onTap: () => onModeChanged(InteractionMode.uiOperate),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isUiOperateSelected
                      ? ThemeConfig.accentGreen.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isUiOperateSelected
                        ? ThemeConfig.accentGreen
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: mode == InteractionMode.none || isUiOperateSelected
                      ? 1.0
                      : 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isUiOperateSelected)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.arrow_downward,
                                color: ThemeConfig.accentGreen,
                                size: 32,
                              ),
                            ),
                          Text(
                            'UI操作',
                            style: theme.textTheme.subtitle.copyWith(
                              color: isUiOperateSelected
                                  ? ThemeConfig.accentGreen
                                  : ThemeConfig.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildBulletPoint(
                        context,
                        'タップ操作',
                        isHighlighted: isUiOperateSelected,
                      ),
                      const SizedBox(height: 8),
                      _buildBulletPoint(
                        context,
                        'テキスト入力',
                        isHighlighted: isUiOperateSelected,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(
    BuildContext context,
    String text, {
    bool isHighlighted = false,
  }) {
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
}
