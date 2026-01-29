import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:url_launcher/url_launcher.dart';

class AiPowerSlide extends FlutterDeckSlideWidget {
  const AiPowerSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/ai-power',
            title: 'AI Power',
            header: FlutterDeckHeaderConfiguration(
              title: 'AIの力をもっと引き出したい…',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.split(
      leftBuilder: (context) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              'Claude Codeの開発者が\n最も重要と言っていること',
              style: theme.textTheme.subtitle,
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                Icon(
                  Icons.arrow_forward,
                  size: 40,
                  color: theme.materialTheme.colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Text(
                  'フィードバックループ',
                  style: theme.textTheme.title.copyWith(
                    color: theme.materialTheme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () => launchUrl(
                Uri.parse('https://x.com/bcherny/status/2007179861115511237'),
              ),
              child: Text(
                'https://x.com/bcherny/status/2007179861115511237',
                style: theme.textTheme.bodySmall.copyWith(
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      rightBuilder: (context) => Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/boris13.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
