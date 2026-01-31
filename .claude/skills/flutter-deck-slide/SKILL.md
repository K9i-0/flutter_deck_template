---
name: flutter-deck-slide
description: flutter_deckでプレゼンテーションスライドを作成・編集。「スライドを追加」「新しいスライド」「スライドを編集」「テーマ変更」「コード挿入」「画像追加」「プレビュー」などで発動。
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(flutter:*), mcp__marionette__connect, mcp__marionette__take_screenshots, mcp__marionette__tap, mcp__marionette__hot_reload
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

### 3. プレビュー提案

スライド追加・編集後、以下を提案する：
- 「marionette MCPでプレビューを確認しますか？」
- 接続済みならホットリロード → スクリーンショット取得
- 未接続なら接続手順を案内

## テキストサイズガイドライン

> **重要**: カンファレンス発表ではフォントサイズ **20pt以上** を必ず使用すること。
> 20pt未満は会場後方から読めないため使用禁止。

| スタイル | サイズ | 用途 |
|----------|--------|------|
| `display` | 103pt | 大見出し |
| `header` | 57pt | ヘッダー |
| `title` | 54pt | タイトル |
| `subtitle` | 42pt | サブタイトル |
| `bodyLarge` | 32pt | 本文（大） |
| `bodyMedium` | 26pt | 本文（中） |
| `bodySmall` | 22pt | 本文（小）最小推奨 |

カスタムTextStyleを使う場合も `fontSize: 20` 以上を維持する。

## 画像配置ガイドライン

- 画像は `assets/images/` に配置する
- `pubspec.yaml` の assets セクションに登録が必要
- 大きすぎる画像は事前にリサイズを推奨（1920x1080程度）
- SVGを使う場合は `flutter_svg` パッケージの追加が必要

```dart
// 画像表示例
Image.asset(
  'assets/images/my_image.png',
  fit: BoxFit.contain,
)
```

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
