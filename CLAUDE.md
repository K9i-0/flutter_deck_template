# Flutter Deck Presentation Template

## 概要

flutter_deckを使用した登壇スライドテンプレート。Claude Codeと連携してスライドを簡単に作成・編集できる。

## コマンド

```bash
# Webでプレビュー
flutter run -d chrome

# macOSでプレビュー
flutter run -d macos

# リリースビルド
flutter build web --release
flutter build macos --release

# 依存関係の取得
flutter pub get

# コード解析
flutter analyze
```

## プロジェクト構造

```
lib/
├── main.dart                    # エントリーポイント
├── config/
│   ├── presentation_config.dart # プレゼン設定
│   ├── theme_config.dart        # テーマ設定
│   └── speaker_info.dart        # 登壇者情報
└── slides/
    ├── slides.dart              # エクスポートバレル
    └── NN_*_slide.dart          # 各スライド
```

## スライド命名規則

`NN_descriptive_name_slide.dart`（NNは2桁番号）

- 01-09: オープニング
- 10-89: メインコンテンツ
- 90-99: クロージング

## 新規スライド追加手順

1. `lib/slides/`に新規ファイル作成（命名規則に従う）
2. `FlutterDeckSlideWidget`を継承
3. `slides.dart`にexport追加
4. `main.dart`のslidesリストに追加

## 利用可能なスライドテンプレート

| テンプレート | 用途 |
|-------------|------|
| `.title()` | タイトルスライド |
| `.blank()` | カスタムレイアウト |
| `.split()` | 2カラム |
| `.image()` | フルスクリーン画像 |
| `.bigFact()` | 大きい数字/テキスト |
| `.quote()` | 引用 |

## ステップ機能

スライド内で段階的に内容を表示する：

```dart
configuration: const FlutterDeckSlideConfiguration(
  steps: 3, // ステップ数
),

// ビルダー内で
FlutterDeckSlideStepsBuilder(
  builder: (context, step) => Column(
    children: [
      if (step >= 1) Text('Step 1'),
      if (step >= 2) Text('Step 2'),
      if (step >= 3) Text('Step 3'),
    ],
  ),
)
```

## テーマカスタマイズ

`lib/config/theme_config.dart`でカラースキーム変更可能。

## キーボードショートカット

- `→` / `←`: 次/前のスライド
- `Ctrl + M`: マーカー切り替え
- `Ctrl + .`: ナビゲーションドロワー

## 登壇者情報の設定

`lib/config/speaker_info.dart`を編集：

```dart
static const String name = 'Your Name';
static const String description = 'Your Title';
static const String socialHandle = '@your_handle';
```

## GitHub Pagesへのデプロイ

mainブランチにpushすると自動デプロイ。

## UI検証（marionette MCP）

### 接続手順

1. ユーザーが既にFlutterアプリを起動しているか確認
   ```bash
   lsof -i -P -n | grep flutter_d | grep LISTEN
   ```
2. ポート番号を取得して接続
   ```
   mcp__marionette__connect: ws://127.0.0.1:<PORT>/ws
   ```
3. VS Codeから起動する場合は `--disable-service-auth-codes` が自動で付与される（launch.json設定済み）

### スライド操作

- **スクリーンショット**: `mcp__marionette__take_screenshots`
- **次のスライド**: `mcp__marionette__tap` with `key: "nav_next"`
- **前のスライド**: `mcp__marionette__tap` with `key: "nav_previous"`
- **ホットリロード**: `mcp__marionette__hot_reload`

### 注意事項

- ナビゲーションボタン（`< >`）は `kDebugMode` の時のみ表示される
- タイマー左上に表示されるナビゲーションを使用してスライド移動
