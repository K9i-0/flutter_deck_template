import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import '../config/speaker_info.dart';

class SelfIntroSlide extends FlutterDeckSlideWidget {
  const SelfIntroSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/self-intro',
            title: 'Self Introduction',
            header: FlutterDeckHeaderConfiguration(
              title: '自己紹介',
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
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.materialTheme.colorScheme.primaryContainer,
              ),
              child: Icon(
                Icons.person,
                size: 120,
                color: theme.materialTheme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              SpeakerInfo.name,
              style: theme.textTheme.title,
            ),
            const SizedBox(height: 8),
            Text(
              SpeakerInfo.socialHandle,
              style: theme.textTheme.subtitle.copyWith(
                color: theme.materialTheme.colorScheme.primary,
              ),
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
              'About Me',
              style: theme.textTheme.subtitle,
            ),
            const SizedBox(height: 24),
            _buildInfoItem(context, Icons.work, 'Flutter Developer'),
            const SizedBox(height: 16),
            _buildInfoItem(context, Icons.smart_toy, 'AI-Driven Development'),
            const SizedBox(height: 16),
            _buildInfoItem(context, Icons.code, 'Claude Code + MCP'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String text) {
    final theme = FlutterDeckTheme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 32,
          color: theme.materialTheme.colorScheme.primary,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
