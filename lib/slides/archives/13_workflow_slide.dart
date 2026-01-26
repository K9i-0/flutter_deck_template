import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class WorkflowSlide extends FlutterDeckSlideWidget {
  const WorkflowSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/workflow',
            title: 'Practical Workflow',
            header: FlutterDeckHeaderConfiguration(
              title: '実践ワークフロー',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'フィードバックループの実装',
              style: theme.textTheme.bodyMedium.copyWith(
                color: theme.materialTheme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildWorkflowStep(context, '1', 'Plan', Icons.edit_note),
                _buildArrow(context),
                _buildWorkflowStep(context, '2', 'Implement', Icons.code),
                _buildArrow(context),
                _buildWorkflowStep(context, '3', 'E2E Test', Icons.play_arrow),
                _buildArrow(context),
                _buildWorkflowStep(context, '4', 'Self Review', Icons.rate_review),
                _buildArrow(context),
                _buildWorkflowStep(context, '5', 'Git', Icons.commit),
              ],
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.materialTheme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    '効率的なE2Eテスト手順',
                    style: theme.textTheme.subtitle.copyWith(
                      color: theme.materialTheme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTestStep(context, 'hierarchy', true),
                      _buildTestArrow(context),
                      _buildTestStep(context, '操作', false),
                      _buildTestArrow(context),
                      _buildTestStep(context, 'hierarchy', true),
                      _buildTestArrow(context),
                      Text(
                        '...',
                        style: theme.textTheme.bodyLarge,
                      ),
                      _buildTestArrow(context),
                      _buildTestStep(context, 'screenshot', true),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'スクリーンショットは最終確認のみ（軽量化）',
                    style: theme.textTheme.bodySmall.copyWith(
                      color: theme.materialTheme.colorScheme.onSurfaceVariant,
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

  Widget _buildWorkflowStep(
    BuildContext context,
    String number,
    String label,
    IconData icon,
  ) {
    final theme = FlutterDeckTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.materialTheme.colorScheme.primaryContainer,
            theme.materialTheme.colorScheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.materialTheme.colorScheme.primary,
            ),
            child: Center(
              child: Text(
                number,
                style: theme.textTheme.bodySmall.copyWith(
                  color: theme.materialTheme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Icon(icon, size: 32),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrow(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(
        Icons.arrow_forward,
        color: theme.materialTheme.colorScheme.primary,
      ),
    );
  }

  Widget _buildTestStep(BuildContext context, String label, bool isHighlighted) {
    final theme = FlutterDeckTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isHighlighted
            ? theme.materialTheme.colorScheme.primaryContainer
            : theme.materialTheme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: isHighlighted
            ? Border.all(
                color: theme.materialTheme.colorScheme.primary,
                width: 2,
              )
            : null,
      ),
      child: Text(
        label,
        style: theme.textTheme.bodySmall.copyWith(
          fontFamily: 'monospace',
          fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTestArrow(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(
        Icons.arrow_right_alt,
        size: 20,
        color: theme.materialTheme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
