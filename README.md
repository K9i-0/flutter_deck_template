# flutter_deck_template

Flutter Deckを使った登壇スライドテンプレート。Claude Codeと連携して簡単にプレゼンテーションを作成できます。

## 特徴

- **flutter_deck**ベースの美しいスライド
- **Claude Code**のスキル機能によるスライド自動生成
- **GitHub Pages**へのデプロイ（手動トリガー）
- ダーク/ライトテーマ対応
- 豊富なスライドテンプレート

## 運用方法

`main`ブランチはテンプレートとして維持し、各プレゼンテーションは専用ブランチで作成します。

```
main（テンプレート）
├── fluttergakkai_9（発表1）
├── my_conference_2025（発表2）
└── internal_lt（発表3）
```

## クイックスタート

### 1. テンプレートからリポジトリを作成

GitHubの「Use this template」ボタンをクリックして、新しいリポジトリを作成します。

### 2. ローカルにクローン

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

### 3. Flutter SDKをインストール

[mise](https://mise.jdx.dev/)を使用してFlutter SDKをインストールします。

```bash
mise install
```

### 4. 依存関係を取得

```bash
flutter pub get
```

### 5. プレビュー

```bash
flutter run -d chrome
```

## Claude Codeとの連携

このテンプレートにはClaude Code用のスキルが含まれています。以下のような指示でスライドを作成・編集できます：

- 「新しいスライドを追加して」
- 「コードブロックを挿入して」
- 「2カラムのスライドを作成して」
- 「テーマを変更して」

## カスタマイズ

### 登壇者情報

`lib/config/speaker_info.dart`を編集：

```dart
static const String name = 'Your Name';
static const String description = 'Your Title';
static const String socialHandle = '@your_handle';
```

### テーマ

`lib/config/theme_config.dart`でカラースキームを変更できます。

### スライド追加

1. `lib/slides/`に新規ファイルを作成（例：`15_my_slide.dart`）
2. `lib/slides/slides.dart`にexportを追加
3. `lib/main.dart`のslidesリストに追加

## 利用可能なスライドテンプレート

| テンプレート | 用途 |
|-------------|------|
| `.title()` | タイトルスライド |
| `.blank()` | カスタムレイアウト |
| `.split()` | 2カラム |
| `.image()` | フルスクリーン画像 |
| `.bigFact()` | 大きい数字/テキスト |
| `.quote()` | 引用 |

## キーボードショートカット

| キー | 動作 |
|------|------|
| `→` | 次のスライド |
| `←` | 前のスライド |
| `Ctrl + M` | マーカー切り替え |
| `Ctrl + .` | ナビゲーションドロワー |

## デプロイ

GitHub Actionsの手動トリガー（`workflow_dispatch`）でGitHub Pagesにデプロイします。ブランチごとにサブディレクトリにデプロイされます。

### デプロイ手順

1. GitHub Actionsの「Deploy Slides to GitHub Pages」ワークフローを開く
2. 「Run workflow」をクリック（**mainブランチから実行**）
3. 「Branch to deploy」にデプロイしたいブランチ名を入力して実行

### GitHub Pagesの初回設定

1. リポジトリの Settings → Pages に移動
2. Source を「Deploy from a branch」に設定
3. Branch: `gh-pages` / `/ (root)` を選択して保存

## ライセンス

MIT License
