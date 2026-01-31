---
name: preview-slides
description: スライドのプレビュー・確認。「プレビュー」「スライド確認」「スクリーンショット」「全スライド確認」などで発動。
allowed-tools: Read, Glob, Bash(lsof:*), mcp__marionette__connect, mcp__marionette__take_screenshots, mcp__marionette__get_interactive_elements, mcp__marionette__tap, mcp__marionette__hot_reload, mcp__marionette__disconnect
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

### 4. 全スライド一括プレビュー

ユーザーが「全スライド」や「一括」と言った場合：

1. `lib/main.dart` からスライド数を確認
2. 最初のスライドに移動（必要に応じてアプリ再起動）
3. 各スライドのスクリーンショットを取得しながら順番に進める
4. ステップがあるスライドは全ステップ分進める

```
for each slide:
  take_screenshots
  tap key: "nav_next"
```

### 5. 特定スライドへのジャンプ

特定のスライドを確認したい場合：
1. `lib/slides/slides.dart` と `lib/main.dart` からスライド一覧を取得
2. 目的のスライドまで nav_next/nav_previous で移動
3. または `initial: true` を設定してホットリスタートで直接ジャンプ

## コマンド一覧

| 操作 | コマンド |
|------|---------|
| スクリーンショット | `mcp__marionette__take_screenshots` |
| 次のスライド | `mcp__marionette__tap` key: `nav_next` |
| 前のスライド | `mcp__marionette__tap` key: `nav_previous` |
| ホットリロード | `mcp__marionette__hot_reload` |

## 注意事項

- ナビゲーションボタンは `kDebugMode` の時のみ表示される
- VS Codeから起動していれば `--disable-service-auth-codes` が自動付与される
- ホットリロード後はスクリーンショットを再取得して変更を確認する
