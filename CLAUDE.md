# Flutter Deck Presentation Template

## 概要

flutter_deckを使用した登壇スライドテンプレート。Claude Codeと連携してスライドを簡単に作成・編集できる。

## 動作確認・開発

> **重要**: 動作確認は **marionette MCP** を優先して使用すること。
> ユーザーが既にアプリを起動している場合が多いため、まず接続を試みる。

### UI検証（marionette MCP）【優先】

スライドの動作確認・スクリーンショット取得はmarionette MCPを使用する。

**接続手順:**
1. 起動中のFlutterアプリを確認
   ```bash
   lsof -i -P -n | grep flutter_d | grep LISTEN
   ```
2. ポート番号を取得して接続
   ```
   mcp__marionette__connect: ws://127.0.0.1:<PORT>/ws
   ```
3. VS Codeから起動する場合は `--disable-service-auth-codes` が自動で付与される（launch.json設定済み）

**スライド操作:**
- **スクリーンショット**: `mcp__marionette__take_screenshots`
- **次のスライド**: `mcp__marionette__tap` with `key: "nav_next"`
- **前のスライド**: `mcp__marionette__tap` with `key: "nav_previous"`
- **ホットリロード**: `mcp__marionette__hot_reload`

**注意事項:**
- ナビゲーションボタン（`< >`）は `kDebugMode` の時のみ表示される
- タイマー左上に表示されるナビゲーションを使用してスライド移動

### 特定スライドへの直接ジャンプ

確認したいスライドに `initial: true` を設定すると、そのスライドから起動できる。

```dart
configuration: const FlutterDeckSlideConfiguration(
  route: '/my-slide',
  title: 'My Slide',
  initial: true,  // ← これを追加
),
```

**dart-mcp でホットリスタート:**
1. DTD URIを取得
   ```bash
   ps aux | grep "dtd-uri" | grep -o 'ws://[^[:space:]]*' | head -1
   ```
   または VS Code コマンドパレット → `Dart: Copy DTD URI to Clipboard`

2. dart-mcpで接続・リスタート
   ```
   mcp__dart-mcp__connect_dart_tooling_daemon: <DTD URI>
   mcp__dart-mcp__hot_restart
   ```

> **注意**: VM Service URI（marionette用）と DTD URI（dart-mcp用）は別物。
> 間違ったURIを使うと紛らわしいSDKバージョンエラーが出る。

### アプリ起動コマンド（marionette接続不可時のみ）

```bash
# Webでプレビュー
flutter run -d chrome

# macOSでプレビュー
flutter run -d macos
```

### その他のコマンド

```bash
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

## 文字サイズガイドライン

カンファレンス発表用の推奨文字サイズ（`theme_config.dart`で定義）：

| 用途 | 推奨サイズ |
|------|-----------|
| Title/headers | 36-80pt |
| Body text | 24-32pt |
| **Minimum readable** | **20pt** |

**定義済みテキストスタイル:**

| スタイル | サイズ | 用途 |
|----------|--------|------|
| `display` | 103pt | 大見出し |
| `header` | 57pt | ヘッダー |
| `title` | 54pt | タイトル |
| `subtitle` | 42pt | サブタイトル |
| `bodyLarge` | 32pt | 本文（大） |
| `bodyMedium` | 26pt | 本文（中） |
| `bodySmall` | 22pt | 本文（小）・リンク等 |

> **注意**: 20pt未満の文字は会場後方から読めないため使用禁止。

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

