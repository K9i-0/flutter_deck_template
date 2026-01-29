import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class AndroidApproachesSlide extends FlutterDeckSlideWidget {
  const AndroidApproachesSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/android-approaches',
          title: 'Android Approaches',
          header: FlutterDeckHeaderConfiguration(
            title: '外部アプローチ：Android通信の仕組み',
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
                  // Maestro MCP方式
                  Expanded(
                    child: _buildApproachCard(
                      context,
                      title: 'Maestro MCP',
                      subtitle: 'Instrumentation Test + gRPC',
                      color: ThemeConfig.accentOrange,
                      diagram: _buildMaestroDiagram(context),
                      features: const [
                        ('通信方式', 'gRPC（接続維持）'),
                        ('デバイス側', 'APK 2つインストール'),
                        ('API', 'UiAutomator直接アクセス'),
                        ('速度', '高速（接続再利用）'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Mobile MCP方式
                  Expanded(
                    child: _buildApproachCard(
                      context,
                      title: 'Mobile MCP',
                      subtitle: 'コマンド直接実行型',
                      color: ThemeConfig.accentGreen,
                      diagram: _buildMobileMcpDiagram(context),
                      features: const [
                        ('通信方式', 'ADB shell（毎回実行）'),
                        ('デバイス側', 'インストール不要'),
                        ('API', 'adb shell input'),
                        ('速度', '毎回プロセス起動'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
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
                  const Icon(
                    Icons.info_outline,
                    color: ThemeConfig.accentBlue,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'UIAutomator: Android公式UIテストFW（アプリ内部に直接アクセス）  |  ADB: デバッグ用CLI（外部からコマンドで操作）',
                      style: theme.textTheme.bodyMedium.copyWith(
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

  Widget _buildApproachCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
    required Widget diagram,
    required List<(String, String)> features,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: theme.textTheme.title.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            subtitle,
            style: theme.textTheme.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(child: diagram),
        if (features.isNotEmpty) ...[
          const SizedBox(height: 8),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 160,
                    child: Text(
                      feature.$1,
                      style: theme.textTheme.bodySmall.copyWith(
                        color: ThemeConfig.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      feature.$2,
                      style: theme.textTheme.bodyMedium.copyWith(
                        color: ThemeConfig.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMaestroDiagram(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBox('Maestro CLI', ThemeConfig.accentOrange, subtitle: 'ホストPC'),
        const SizedBox(height: 4),
        _buildConnectionLine('gRPC（接続維持）', ThemeConfig.accentOrange),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ThemeConfig.textSecondary.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Android端末',
                style: TextStyle(
                  color: ThemeConfig.textSecondary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              _buildBox(
                'Instrumentation Test',
                ThemeConfig.accentOrange,
                subtitle: '@Test内でgRPCサーバー起動',
                smaller: true,
              ),
              const SizedBox(height: 4),
              const Icon(
                Icons.arrow_downward,
                color: ThemeConfig.textSecondary,
                size: 16,
              ),
              const SizedBox(height: 4),
              _buildBox(
                'UIAutomator',
                Colors.grey,
                subtitle: 'Android公式',
                smaller: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileMcpDiagram(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBox('mobilecli', ThemeConfig.accentGreen, subtitle: 'ホストPC'),
        const SizedBox(height: 4),
        _buildConnectionLine('ADB shell（毎回実行）', ThemeConfig.accentGreen),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ThemeConfig.textSecondary.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Android端末',
                style: TextStyle(
                  color: ThemeConfig.textSecondary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: ThemeConfig.accentGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: ThemeConfig.accentGreen, width: 2),
                ),
                child: const Column(
                  children: [
                    Text(
                      'input tap 100 200',
                      style: TextStyle(
                        color: ThemeConfig.accentGreen,
                        fontSize: 16,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '実行して終了',
                      style: TextStyle(
                        color: ThemeConfig.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBox(
    String label,
    Color color, {
    String? subtitle,
    bool smaller = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: smaller ? 16 : 24,
        vertical: smaller ? 10 : 14,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: smaller ? 18 : 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: ThemeConfig.textSecondary,
                fontSize: smaller ? 14 : 16,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildConnectionLine(String label, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 2, height: 20, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Container(width: 2, height: 20, color: color),
      ],
    );
  }
}
