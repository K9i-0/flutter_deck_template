import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class DemoSlide extends FlutterDeckSlideWidget {
  const DemoSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/demo',
          title: 'Demo',
          header: FlutterDeckHeaderConfiguration(title: 'デモ'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.live_tv,
              size: 80,
              color: theme.materialTheme.colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text('Live Demo', style: theme.textTheme.title),
            const SizedBox(height: 16),
            Text(
              'Claude Code + MCP で実際にシミュレーターを操作',
              style: theme.textTheme.bodyLarge.copyWith(
                color: theme.materialTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
