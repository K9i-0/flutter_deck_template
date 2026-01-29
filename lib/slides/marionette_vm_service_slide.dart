import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class MarionetteVmServiceSlide extends FlutterDeckSlideWidget {
  const MarionetteVmServiceSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/marionette-vm-service',
            title: 'Marionette VM Service',
            header: FlutterDeckHeaderConfiguration(title: 'Marionette: VM Service Protocol'),
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
                    const SizedBox(height: 32),
                    Expanded(
                      child: _buildDiagram(context, step),
                    ),
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
                    _buildFeatureSection(
                      context,
                      icon: Icons.speed,
                      title: '軽量',
                      description: '約1,700行の実装\nMaestro MCP: ~50,000行',
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureSection(
                      context,
                      icon: Icons.widgets,
                      title: 'Widget Tree直接操作',
                      description: 'RenderObjectから座標取得\nControllerを直接更新',
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureSection(
                      context,
                      icon: Icons.refresh,
                      title: 'Hot Reload連携',
                      description: 'コード変更→即反映\n開発効率UP',
                    ),
                    if (step >= 2) ...[
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              ThemeConfig.accentOrange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: ThemeConfig.accentOrange,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning_amber,
                              color: ThemeConfig.accentOrange,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'デバッグビルド専用\nリリースビルドでは使用不可',
                                style: theme.textTheme.bodyMedium.copyWith(
                                  color: ThemeConfig.accentOrange,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiagram(BuildContext context, int step) {
    return Column(
      children: [
        // 比較: 通常の使い方 vs Marionette
        Row(
          children: [
            Expanded(
              child: _buildUsageBox(
                context,
                title: '通常の使い方',
                items: ['VS Code', 'Android Studio'],
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildUsageBox(
                context,
                title: 'Marionetteの使い方',
                items: ['AIエージェント'],
                color: ThemeConfig.accentBlue,
                highlight: step >= 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // 共通の矢印
        Row(
          children: [
            Expanded(
              child: Center(
                child: Icon(
                  Icons.arrow_downward,
                  color: Colors.grey,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Center(
                child: Icon(
                  Icons.arrow_downward,
                  color: ThemeConfig.accentBlue,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // 共通: VM Service Protocol
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
          decoration: BoxDecoration(
            color: ThemeConfig.accentBlue.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ThemeConfig.accentBlue,
              width: 3,
            ),
          ),
          child: Column(
            children: [
              Text(
                'VM Service Protocol',
                style: TextStyle(
                  color: ThemeConfig.accentBlue,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'WebSocket (ws://127.0.0.1:PORT/ws)',
                style: TextStyle(
                  color: ThemeConfig.textSecondary,
                  fontSize: 18,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Icon(
          Icons.arrow_downward,
          color: ThemeConfig.textSecondary,
          size: 32,
        ),
        const SizedBox(height: 16),
        // Flutterアプリ
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ThemeConfig.accentBlueLight.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ThemeConfig.accentBlueLight,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone_android,
                    color: ThemeConfig.accentBlueLight,
                    size: 36,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Flutterアプリ',
                    style: TextStyle(
                      color: ThemeConfig.textPrimary,
                      fontSize: 24,
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
                child: Text(
                  'MarionetteBinding (カスタム拡張)',
                  style: TextStyle(
                    color: ThemeConfig.accentBlue,
                    fontSize: 18,
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: highlight ? 0.15 : 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color,
          width: highlight ? 3 : 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Text(
              item,
              style: TextStyle(
                color: ThemeConfig.textPrimary,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
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
          child: Icon(
            icon,
            color: ThemeConfig.accentBlue,
            size: 28,
          ),
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
