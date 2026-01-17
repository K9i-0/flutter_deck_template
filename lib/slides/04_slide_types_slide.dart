import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class SlideTypesSlide extends FlutterDeckSlideWidget {
  const SlideTypesSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/slide-types',
            title: 'Slide Types',
            header: FlutterDeckHeaderConfiguration(
              title: '利用可能なスライドタイプ',
            ),
            steps: 6,
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(48),
        child: FlutterDeckSlideStepsBuilder(
          builder: (context, step) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (step >= 1)
                _buildSlideType(
                  context,
                  '.title()',
                  'タイトルスライド - プレゼンの開始や区切りに',
                ),
              if (step >= 2)
                _buildSlideType(
                  context,
                  '.blank()',
                  'カスタムスライド - 自由なレイアウトが可能',
                ),
              if (step >= 3)
                _buildSlideType(
                  context,
                  '.split()',
                  '2カラムスライド - 比較や対比に最適',
                ),
              if (step >= 4)
                _buildSlideType(
                  context,
                  '.image()',
                  '画像スライド - フルスクリーン画像表示',
                ),
              if (step >= 5)
                _buildSlideType(
                  context,
                  '.bigFact()',
                  '大きい文字 - インパクトのある数字や文章',
                ),
              if (step >= 6)
                _buildSlideType(
                  context,
                  '.quote()',
                  '引用スライド - 名言やコメントの紹介',
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlideType(BuildContext context, String name, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF6366f1).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF6366f1),
                width: 1,
              ),
            ),
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'JetBrains Mono',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6366f1),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Text(
            description,
            style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
