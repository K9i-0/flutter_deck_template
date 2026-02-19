---
name: preview-slides
description: スライドのプレビュー・確認。「プレビュー」「スライド確認」「スクリーンショット」「全スライド確認」などで発動。
allowed-tools: Read, Glob, Bash(lsof:*), mcp__marionette__connect, mcp__marionette__take_screenshots, mcp__marionette__get_interactive_elements, mcp__marionette__tap, mcp__marionette__hot_reload, mcp__marionette__disconnect, mcp__marionette__call_custom_extension
---

# Preview Slides Skill

Marionette MCPを使用して、実行中のFlutterアプリのスライドをプレビュー・確認するスキル。

## 作業フロー

### 1. 接続

起動中のFlutterアプリに接続する。

```bash
# ポート番号を確認
lsof -i -P -n | grep flutter_d | grep LISTEN
```

ポートが見つかったら `mcp__marionette__connect` で接続。
見つからない場合はユーザーにアプリの起動を依頼する。

### 2. 現在のスライドをプレビュー

`mcp__marionette__take_screenshots` でスクリーンショットを取得。

### 3. スライドナビゲーション

- **次のスライド**: `mcp__marionette__tap` with `key: "nav_next"`
- **前のスライド**: `mcp__marionette__tap` with `key: "nav_previous"`
- **特定スライドにジャンプ**: `mcp__marionette__call_custom_extension` で直接移動（後述）

### 4. 全スライド一括プレビュー

ユーザーが「全スライド」や「一括」と言った場合：

1. `call_custom_extension` でスライド情報を取得
   ```
   extension: "deckNavigation.getSlideInfo"
   → { currentSlide: 1, slideCount: N }
   ```
2. スライド1にジャンプ（必要な場合）
   ```
   extension: "deckNavigation.goToSlide"
   args: { slideNumber: "1" }
   ```
3. 各スライドのスクリーンショットを取得しながら `nav_next` で進める
4. ステップがあるスライドは全ステップ分進める

### 5. 特定スライドへのジャンプ

`call_custom_extension` を使って直接ジャンプできる：

```
# スライド情報を取得
mcp__marionette__call_custom_extension:
  extension: "deckNavigation.getSlideInfo"

# n枚目のスライドにジャンプ
mcp__marionette__call_custom_extension:
  extension: "deckNavigation.goToSlide"
  args: { slideNumber: "3" }
```

> **注意**: `args` の値はすべて文字列で渡す（VM Service Extensionの制約）。

## コマンド一覧

| 操作 | コマンド |
|------|---------|
| スクリーンショット | `mcp__marionette__take_screenshots` |
| 次のスライド | `mcp__marionette__tap` key: `nav_next` |
| 前のスライド | `mcp__marionette__tap` key: `nav_previous` |
| スライド情報取得 | `mcp__marionette__call_custom_extension` extension: `deckNavigation.getSlideInfo` |
| 特定スライドにジャンプ | `mcp__marionette__call_custom_extension` extension: `deckNavigation.goToSlide` args: `{ slideNumber: "N" }` |
| ホットリロード | `mcp__marionette__hot_reload` |

## 注意事項

- ナビゲーションボタンは `kDebugMode` の時のみ表示される
- VS Codeから起動していれば `--disable-service-auth-codes` が自動付与される
- ホットリロード後はスクリーンショットを再取得して変更を確認する
- `call_custom_extension` は汎用ツールで、`ext.flutter.` プレフィックスは自動付与される
