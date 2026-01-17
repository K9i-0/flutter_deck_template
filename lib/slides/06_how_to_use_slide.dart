import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class HowToUseSlide extends FlutterDeckSlideWidget {
  const HowToUseSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/how-to-use',
            title: 'How to Use',
            header: FlutterDeckHeaderConfiguration(
              title: '使い方',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStep(context, '1', 'Use this template でリポジトリを作成'),
            _buildStep(context, '2', 'git clone でローカルにクローン'),
            _buildStep(context, '3', 'mise install で Flutter SDK をインストール'),
            _buildStep(context, '4', 'flutter pub get で依存関係を取得'),
            _buildStep(context, '5', 'flutter run -d chrome でプレビュー'),
            _buildStep(context, '6', 'Claude Code でスライドを編集'),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, String number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366f1), Color(0xFF8b5cf6)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Text(
            text,
            style: FlutterDeckTheme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
