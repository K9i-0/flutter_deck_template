import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/theme_config.dart';

class FlowComparisonSlide extends FlutterDeckSlideWidget {
  const FlowComparisonSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/flow-comparison',
            title: 'Flow Comparison',
            header: FlutterDeckHeaderConfiguration(
              title: 'UI検証の有無での開発フローの違い',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const _FlowComparisonContent(),
    );
  }
}

class _FlowComparisonContent extends StatelessWidget {
  const _FlowComparisonContent();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _BeforeColumn()),
                SizedBox(width: 48),
                Expanded(child: _AfterColumn()),
              ],
            ),
          ),
          SizedBox(height: 16),
          _ConclusionMessage(),
        ],
      ),
    );
  }
}

class _BeforeColumn extends StatelessWidget {
  const _BeforeColumn();

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: ThemeConfig.textSecondary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                'Before',
                style: theme.textTheme.bodyLarge.copyWith(
                  color: ThemeConfig.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '(UI検証なし)',
                style: theme.textTheme.bodySmall.copyWith(
                  color: ThemeConfig.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Flow steps - 6行構造（After側と縦位置を揃える）
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _FlowStep(
                text: 'Planモードで仕様決定',
                color: ThemeConfig.textPrimary,
              ),
              const _ArrowDown(),
              _FlowStep(
                text: 'AIが実装',
                color: ThemeConfig.textPrimary,
              ),
              const _ArrowDown(),
              _FlowStep(
                text: 'lint等の最低限検証',
                color: ThemeConfig.textPrimary,
              ),
              const _ArrowDown(),
              const _EmptyStep(), // After側のAI UI検証に対応する空ステップ
              const _ArrowDown(),
              _FlowStep(
                text: '人間が動作確認',
                color: ThemeConfig.textPrimary,
              ),
              const _ArrowDown(),
              _WarningStep(text: '実装ミスが発覚'),
            ],
          ),
        ),
      ],
    );
  }
}

class _AfterColumn extends StatelessWidget {
  const _AfterColumn();

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: ThemeConfig.accentGreen.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ThemeConfig.accentGreen,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                'After',
                style: theme.textTheme.bodyLarge.copyWith(
                  color: ThemeConfig.accentGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '(UI検証あり)',
                style: theme.textTheme.bodySmall.copyWith(
                  color: ThemeConfig.accentGreen,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Flow steps
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _FlowStep(
                text: 'Planモードで仕様決定',
                color: ThemeConfig.textPrimary,
              ),
              const _ArrowDown(),
              _FlowStep(
                text: 'AIが実装',
                color: ThemeConfig.textPrimary,
              ),
              const _ArrowDown(),
              _FlowStep(
                text: 'lint等の最低限検証',
                color: ThemeConfig.textPrimary,
              ),
              const _ArrowDown(),
              const _SuccessStep(text: 'AIがUI検証で確認'),
              const _ArrowDown(),
              _FlowStep(
                text: '人間が動作確認',
                color: ThemeConfig.textPrimary,
              ),
              const _ArrowDown(),
              const _SuccessStep(text: 'ミスは事前解消済み'),
            ],
          ),
        ),
      ],
    );
  }
}

class _FlowStep extends StatelessWidget {
  const _FlowStep({
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ThemeConfig.outline,
          width: 2,
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium.copyWith(
          color: color,
        ),
      ),
    );
  }
}

class _WarningStep extends StatelessWidget {
  const _WarningStep({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: ThemeConfig.accentOrange.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ThemeConfig.accentOrange,
          width: 3,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: ThemeConfig.accentOrange,
            size: 28,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: theme.textTheme.bodyMedium.copyWith(
              color: ThemeConfig.accentOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessStep extends StatelessWidget {
  const _SuccessStep({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: ThemeConfig.accentGreen.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ThemeConfig.accentGreen,
          width: 3,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: ThemeConfig.accentGreen,
            size: 28,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: theme.textTheme.bodyMedium.copyWith(
              color: ThemeConfig.accentGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowDown extends StatelessWidget {
  const _ArrowDown();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_downward,
      color: ThemeConfig.textSecondary.withValues(alpha: 0.5),
      size: 20,
    );
  }
}

class _EmptyStep extends StatelessWidget {
  const _EmptyStep();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ThemeConfig.textSecondary.withValues(alpha: 0.3),
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: Text(
        '―',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ThemeConfig.textSecondary.withValues(alpha: 0.5),
          fontSize: 20,
        ),
      ),
    );
  }
}

class _ConclusionMessage extends StatelessWidget {
  const _ConclusionMessage();

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ThemeConfig.accentGreen.withValues(alpha: 0.15),
            ThemeConfig.accentGreen.withValues(alpha: 0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ThemeConfig.accentGreen.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: ThemeConfig.accentGreen,
            size: 32,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              'AI駆動開発で一番ボトルネックになる人間の介入を抑える',
              style: theme.textTheme.subtitle.copyWith(
                color: ThemeConfig.accentGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
