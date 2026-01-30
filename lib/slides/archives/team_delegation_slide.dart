import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class TeamDelegationSlide extends FlutterDeckSlideWidget {
  const TeamDelegationSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/team-delegation',
            title: 'Team Delegation Style',
            header: FlutterDeckHeaderConfiguration(
              title: '目指す姿: チームメンバーへの委任',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.split(
      leftBuilder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRoleBox(
              context,
              Icons.person,
              '人間',
              'リードエンジニア',
              theme.materialTheme.colorScheme.primaryContainer,
            ),
            const SizedBox(height: 24),
            Icon(
              Icons.arrow_downward,
              size: 32,
              color: theme.materialTheme.colorScheme.primary,
            ),
            Text(
              'タスク依頼',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            _buildRoleBox(
              context,
              Icons.smart_toy,
              'AI',
              'チームメンバー',
              theme.materialTheme.colorScheme.secondaryContainer,
            ),
          ],
        ),
      ),
      rightBuilder: (context) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AIが自律的に実行',
              style: theme.textTheme.subtitle.copyWith(
                color: theme.materialTheme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            _buildStepItem(context, '1', '実装'),
            const SizedBox(height: 12),
            _buildStepItem(context, '2', '動作確認'),
            const SizedBox(height: 12),
            _buildStepItem(context, '3', 'セルフレビュー'),
            const SizedBox(height: 12),
            _buildStepItem(context, '4', '完成度を高めてから報告'),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.materialTheme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: theme.materialTheme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '人間がボトルネックにならない',
                      style: theme.textTheme.bodyLarge.copyWith(
                        color: theme.materialTheme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
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

  Widget _buildRoleBox(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color backgroundColor,
  ) {
    final theme = FlutterDeckTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48),
          const SizedBox(height: 8),
          Text(title, style: theme.textTheme.bodyLarge),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium.copyWith(
              color: theme.materialTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(BuildContext context, String number, String text) {
    final theme = FlutterDeckTheme.of(context);
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.materialTheme.colorScheme.primary,
          ),
          child: Center(
            child: Text(
              number,
              style: theme.textTheme.bodyMedium.copyWith(
                color: theme.materialTheme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(text, style: theme.textTheme.bodyLarge),
      ],
    );
  }
}
