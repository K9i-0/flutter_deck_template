import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

/// Sample content slide demonstrating blank layout with StepsBuilder.
///
/// This slide shows how to:
/// - Use FlutterDeckSlide.blank() for custom layouts
/// - Use FlutterDeckSlideStepsBuilder for step-by-step content reveal
/// - Reference theme text styles
class SampleContentSlide extends FlutterDeckSlideWidget {
  const SampleContentSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/sample-content',
          title: 'Sample Content',
          steps: 3,
          header: FlutterDeckHeaderConfiguration(title: 'Sample Content Slide'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) {
        final textTheme = FlutterDeckTheme.of(context).textTheme;

        return FlutterDeckSlideStepsBuilder(
          builder: (context, step) {
            return Padding(
              padding: const EdgeInsets.all(48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (step >= 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 32),
                          const SizedBox(width: 16),
                          Text(
                            'Step 1: blank() レイアウトで自由にカスタマイズ',
                            style: textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  if (step >= 2)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 32),
                          const SizedBox(width: 16),
                          Text(
                            'Step 2: StepsBuilder で段階的にコンテンツを表示',
                            style: textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  if (step >= 3)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 32),
                          const SizedBox(width: 16),
                          Text(
                            'Step 3: → キーでステップを進められます',
                            style: textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
