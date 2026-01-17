---
name: flutter-deck-slide
description: flutter_deckでプレゼンテーションスライドを作成・編集。「スライドを追加」「新しいスライド」「スライドを編集」「テーマ変更」「コード挿入」「画像追加」「プレビュー」などで発動。
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(flutter:*)
---

# Flutter Deck Slide Skill

flutter_deckを使ったプレゼンテーションスライドの作成・編集を支援するスキル。

## 作業フロー

### 1. 現状把握

まず既存のスライドを確認：

```
lib/slides/
├── slides.dart              # バレルファイル
└── NN_*_slide.dart          # 各スライド
```

### 2. スライド追加

#### 2.1 ファイル番号を決定

既存スライドの番号を確認し、適切な位置に挿入：
- 01-09: オープニング
- 10-89: メインコンテンツ
- 90-99: クロージング

#### 2.2 スライドファイル作成

新規ファイルを`lib/slides/NN_descriptive_name_slide.dart`として作成。

#### 2.3 バレルファイル更新

`lib/slides/slides.dart`にexportを追加：
```dart
export 'NN_descriptive_name_slide.dart';
```

#### 2.4 main.dartにスライド追加

`lib/main.dart`のslidesリストに追加。

## スライドテンプレート

### タイトルスライド (.title)

```dart
import 'package:flutter_deck/flutter_deck.dart';

class MyTitleSlide extends FlutterDeckSlideWidget {
  const MyTitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/my-title',
            title: 'My Title',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.title(
      title: 'スライドタイトル',
      subtitle: 'サブタイトル',
    );
  }
}
```

### カスタムスライド (.blank)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class MyBlankSlide extends FlutterDeckSlideWidget {
  const MyBlankSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/my-blank',
            title: 'My Blank',
            header: FlutterDeckHeaderConfiguration(
              title: 'ヘッダータイトル',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'カスタムコンテンツ',
          style: FlutterDeckTheme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
```

### 2カラムスライド (.split)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class MySplitSlide extends FlutterDeckSlideWidget {
  const MySplitSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/my-split',
            title: 'My Split',
            header: FlutterDeckHeaderConfiguration(
              title: '2カラムスライド',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => Center(
        child: Text('左側コンテンツ'),
      ),
      rightBuilder: (context) => Center(
        child: Text('右側コンテンツ'),
      ),
    );
  }
}
```

### 画像スライド (.image)

```dart
import 'package:flutter_deck/flutter_deck.dart';

class MyImageSlide extends FlutterDeckSlideWidget {
  const MyImageSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/my-image',
            title: 'My Image',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.image(
      imageBuilder: (context) => Image.asset(
        'assets/images/my_image.png',
        fit: BoxFit.contain,
      ),
      label: '画像の説明',
    );
  }
}
```

### 大きい文字スライド (.bigFact)

```dart
import 'package:flutter_deck/flutter_deck.dart';

class MyBigFactSlide extends FlutterDeckSlideWidget {
  const MyBigFactSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/my-big-fact',
            title: 'My Big Fact',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.bigFact(
      title: '100%',
      subtitle: 'サブタイトル説明',
    );
  }
}
```

### 引用スライド (.quote)

```dart
import 'package:flutter_deck/flutter_deck.dart';

class MyQuoteSlide extends FlutterDeckSlideWidget {
  const MyQuoteSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/my-quote',
            title: 'My Quote',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.quote(
      quote: '引用テキスト',
      attribution: '引用元',
    );
  }
}
```

## ステップ機能

段階的に内容を表示：

```dart
configuration: const FlutterDeckSlideConfiguration(
  route: '/steps-demo',
  title: 'Steps Demo',
  steps: 4, // ステップ数を指定
),

@override
FlutterDeckSlide build(BuildContext context) {
  return FlutterDeckSlide.blank(
    builder: (context) => FlutterDeckSlideStepsBuilder(
      builder: (context, step) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (step >= 1) Text('ステップ 1'),
          if (step >= 2) Text('ステップ 2'),
          if (step >= 3) Text('ステップ 3'),
          if (step >= 4) Text('ステップ 4'),
        ],
      ),
    ),
  );
}
```

## コードハイライト

```dart
import 'package:flutter_deck/flutter_deck.dart';

FlutterDeckCodeHighlight(
  code: '''
void main() {
  print('Hello, Flutter Deck!');
}
''',
  fileName: 'main.dart',
  language: 'dart',
)
```

## 箇条書きリスト

```dart
FlutterDeckBulletList(
  items: const [
    'アイテム 1',
    'アイテム 2',
    'アイテム 3',
  ],
)
```

## スタイル参照

テーマからスタイルを取得：

```dart
final theme = FlutterDeckTheme.of(context);

// テキストスタイル
theme.textTheme.title
theme.textTheme.subtitle
theme.textTheme.header
theme.textTheme.bodyLarge
theme.textTheme.bodyMedium
theme.textTheme.bodySmall
```

## プレビューコマンド

```bash
flutter run -d chrome
```

## ビルドコマンド

```bash
flutter build web --release
```
