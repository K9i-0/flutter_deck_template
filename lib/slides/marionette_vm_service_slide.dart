import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class MarionetteVmServiceSlide extends FlutterDeckSlideWidget {
  const MarionetteVmServiceSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/marionette-vm-service',
          title: 'Marionette VM Service',
          header: FlutterDeckHeaderConfiguration(
            title: '内部アプローチ（Marionette MCP）での通信の仕組み',
          ),
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
                  // 左: 図解
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'IDEと同じ仕組みで接続',
                          style: theme.textTheme.title.copyWith(
                            color: ThemeConfig.accentBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Dart VMのデバッグ用プロトコルを使用',
                          style: theme.textTheme.bodyMedium.copyWith(
                            color: ThemeConfig.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(child: _buildDiagram(context)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 48),
                  // 右: ポイント
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIdeFeatureBox(context),
                        const SizedBox(height: 24),
                        _buildFeatureSection(
                          context,
                          icon: Icons.widgets,
                          title: 'Widget Tree直接操作',
                          description:
                              'Semantics不要（外部アプローチと異なる）\n例外: TextField等はValueKey必要',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildUriInfoBox(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagram(BuildContext context) {
    return Column(
      children: [
        // 比較: VS Code等 vs AIエージェント
        Row(
          children: [
            Expanded(
              child: _buildUsageBox(
                context,
                title: 'VS Code等',
                items: ['VS Code', 'Android Studio'],
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildUsageBox(
                context,
                title: 'AIエージェント',
                items: ['Marionette MCP'],
                color: ThemeConfig.accentBlue,
                highlight: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 共通の矢印
        const Row(
          children: [
            Expanded(
              child: Center(
                child: Icon(Icons.arrow_downward, color: Colors.grey, size: 28),
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Center(
                child: Icon(
                  Icons.arrow_downward,
                  color: ThemeConfig.accentBlue,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 共通: VM Service Protocol
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: ThemeConfig.accentBlue.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ThemeConfig.accentBlue, width: 3),
          ),
          child: const Column(
            children: [
              Text(
                'VM Service Protocol',
                style: TextStyle(
                  color: ThemeConfig.accentBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'WebSocket (ws://127.0.0.1:PORT/ws)',
                style: TextStyle(
                  color: ThemeConfig.textSecondary,
                  fontSize: 16,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Icon(
          Icons.arrow_downward,
          color: ThemeConfig.textSecondary,
          size: 28,
        ),
        const SizedBox(height: 12),
        // Flutterアプリ
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ThemeConfig.accentBlueLight.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ThemeConfig.accentBlueLight, width: 2),
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone_android,
                    color: ThemeConfig.accentBlueLight,
                    size: 32,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Flutterアプリ',
                    style: TextStyle(
                      color: ThemeConfig.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: ThemeConfig.accentBlue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'MarionetteBinding (カスタム拡張)',
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

  Widget _buildUsageBox(
    BuildContext context, {
    required String title,
    required List<String> items,
    required Color color,
    bool highlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: highlight ? 0.15 : 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: highlight ? 3 : 2),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          ...items.map(
            (item) => Text(
              item,
              style: const TextStyle(
                color: ThemeConfig.textPrimary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdeFeatureBox(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    final features = [
      'Hot Reload / Hot Restart',
      'デバッガ（ブレークポイント、変数監視）',
      'Widget Inspector',
      'DevTools連携',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.code, color: Colors.grey, size: 24),
              const SizedBox(width: 8),
              Text(
                'IDEの主な機能',
                style: theme.textTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ThemeConfig.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: ThemeConfig.accentGreen,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    feature,
                    style: theme.textTheme.bodySmall.copyWith(
                      color: ThemeConfig.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUriInfoBox(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: ThemeConfig.accentBlue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ThemeConfig.accentBlue.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.lightbulb_outline,
            color: ThemeConfig.accentBlue,
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '2種類のURI',
                            style: theme.textTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ThemeConfig.accentBlue,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(
                                child: _buildUriItem(
                                  context,
                                  label: 'VM Service URI',
                                  description: 'デバッガ・Marionette用',
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _buildUriItem(
                                  context,
                                  label: 'DTD URI',
                                  description: 'dart-mcp用（解析・Hot Reload）',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '💡 Tips',
                            style: theme.textTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ThemeConfig.accentGreen,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '認証トークンありだとプロセスから自動発見不可',
                            style: theme.textTheme.bodySmall.copyWith(
                              color: ThemeConfig.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '--disable-service-auth-codes',
                                  style: theme.textTheme.bodySmall.copyWith(
                                    color: ThemeConfig.accentGreen,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                                TextSpan(
                                  text: ' で',
                                  style: theme.textTheme.bodySmall.copyWith(
                                    color: ThemeConfig.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '起動中のアプリをMCPからそのまま操作可能',
                            style: theme.textTheme.bodySmall.copyWith(
                              color: ThemeConfig.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUriItem(
    BuildContext context, {
    required String label,
    required String description,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: ThemeConfig.textPrimary,
          ),
        ),
        Text(
          description,
          style: theme.textTheme.bodySmall.copyWith(
            color: ThemeConfig.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ThemeConfig.accentBlue.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: ThemeConfig.accentBlue, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyLarge.copyWith(
                  color: ThemeConfig.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: theme.textTheme.bodySmall.copyWith(
                  color: ThemeConfig.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
