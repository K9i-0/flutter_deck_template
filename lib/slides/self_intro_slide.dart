import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class SelfIntroSlide extends FlutterDeckSlideWidget {
  const SelfIntroSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/self-intro',
          title: 'Self Introduction',
          steps: 3,
          header: FlutterDeckHeaderConfiguration(title: '自己紹介'),
        ),
      );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => FlutterDeckSlideStepsBuilder(
        builder: (context, step) => Center(
          child: Image.asset(
            switch (step) {
              1 => 'assets/images/Twitter_profile.png',
              2 => 'assets/images/zenn.png',
              _ => 'assets/images/FlutterGakkai_4.jpg',
            },
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
