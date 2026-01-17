# flutter_deck_template

Flutter Deckを使った登壇スライドテンプレート。Claude Codeと連携して簡単にプレゼンテーションを作成できます。

## 特徴

- **flutter_deck**ベースの美しいスライド
- **Claude Code**のスキル機能によるスライド自動生成
- **GitHub Pages**への自動デプロイ
- ダーク/ライトテーマ対応
- 豊富なスライドテンプレート

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

mainブランチにpushすると、GitHub Actionsが自動的にGitHub Pagesにデプロイします。

### GitHub Pagesの設定

1. リポジトリの Settings → Pages に移動
2. Source を「GitHub Actions」に設定

## ライセンス

MIT License
