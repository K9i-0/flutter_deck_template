import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class AboutSlide extends FlutterDeckSlideWidget {
  const AboutSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/about',
            title: 'About',
            header: FlutterDeckHeaderConfiguration(
              title: 'このテンプレートについて',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'flutter_deck_template は、Claude Code と連携して\n'
                '簡単にプレゼンテーションスライドを作成できる\n'
                'GitHub テンプレートリポジトリです。',
                style: FlutterDeckTheme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 48),
              Text(
                '✨ flutter_deck ベースの美しいスライド\n'
                '🤖 Claude Code のスキルによる自動生成\n'
                '🚀 GitHub Pages への自動デプロイ',
                style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
