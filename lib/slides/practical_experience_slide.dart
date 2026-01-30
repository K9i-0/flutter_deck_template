import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class PracticalExperienceSlide extends FlutterDeckSlideWidget {
  const PracticalExperienceSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/practical-experience',
          title: 'Practical Experience',
          header: FlutterDeckHeaderConfiguration(title: '実際にやってみた感想'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(64, 32, 64, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ポジティブセクション
            _buildSectionHeader(
              context,
              icon: Icons.check_circle,
              title: 'Good',
              color: ThemeConfig.accentGreen,
            ),
            const SizedBox(height: 16),
            _buildBulletPoint(
              context,
              'サンプルアプリ程度なら全然機能する',
              color: ThemeConfig.accentGreen,
            ),
            _buildBulletPoint(
              context,
              '業務でもある程度使えた',
              color: ThemeConfig.accentGreen,
            ),
            _buildSubPoint(context, '本格導入はまだ。コミュニティで開拓していけるとよさそう'),
            const SizedBox(height: 32),

            // ハマりポイントセクション
            _buildSectionHeader(
              context,
              icon: Icons.warning_amber_rounded,
              title: 'ハマりポイント',
              color: ThemeConfig.accentOrange,
            ),
            const SizedBox(height: 16),
            _buildBulletPoint(
              context,
              '実装中アプリのビルド忘れ',
              color: ThemeConfig.accentOrange,
            ),
            _buildBulletPoint(
              context,
              'ログイン周りなどアプリ外の状況把握',
              color: ThemeConfig.accentOrange,
            ),
            const SizedBox(height: 32),

            // その他セクション
            _buildSectionHeader(
              context,
              icon: Icons.lightbulb_outline,
              title: 'その他',
              color: ThemeConfig.accentBlue,
            ),
            const SizedBox(height: 16),
            _buildBulletPoint(
              context,
              'MCPでの操作は結構遅い',
              color: ThemeConfig.accentBlue,
            ),
            _buildSubPoint(context, 'そもそもCLIが人間と比べて遅い'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Row(
      children: [
        Icon(icon, color: color, size: 36),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.title.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(
    BuildContext context,
    String text, {
    required Color color,
  }) {
    final theme = FlutterDeckTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 48, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge.copyWith(
                color: ThemeConfig.textPrimary,
                fontSize: 28,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubPoint(BuildContext context, String text) {
    final theme = FlutterDeckTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 96, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '→ ',
            style: theme.textTheme.bodyMedium.copyWith(
              color: ThemeConfig.textSecondary,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium.copyWith(
                color: ThemeConfig.textSecondary,
                fontSize: 24,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
