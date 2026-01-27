# タイトル

MCPでFlutterアプリのUI検証フィードバックループを回そう

## 自己紹介

- Twitterプロフ
- 最近書いたzennの記事
- FlutterGakkaiは第4回以来の登壇
  - Riverpodに機能追加したときの話 (long ver.)
  - <https://fluttergakkai.connpass.com/event/284732/>

## 導入

### AI駆動開発が当たり前になった

Claude Code、Cursor、Codex CLI ...

### 最近

- 私は
  - 9割くらいAIエージェントに書かせてる(制約がややこしいUI組むときとかだけ手書き)
  - Claude Code + VS Code
    - Claude Code：基本全部
    - VS Code：エディタは手書きするときにしか開かないので、慣れてるVS CodeであえてAI機能は使わず利用

### AIの力をもっと引き出したい…

Claude Codeの開発者が最も重要と言っていること

-> フィードバックループ

引用
<https://x.com/bcherny/status/2007179861115511237?s=20>

### フィードバックループとは

- AIエージェント自体に検証の方法を与えて、動作確認 > 修正のループを回すこと
  - 検証の種類は様々
    - 代表的なのはlintやユニットテスト
    - AIに実際にUI操作させる < 今回はこれ

### 実際に動かすとこんな感じ

- デモ動画
  解像度: 1920x1080（16:9）

## 本題

FlutterでUI検証のフィードバックをしよう

### UI検証を行う際の構成

AIエージェントとツールの関係

AIエージェント > mcp > Flutterアプリ
AIエージェント > cli > Flutterアプリ
AIエージェント > Flutterコード

mcpやcli経由でFlutterアプリのUI取得、UI操作を行う
Skillがmcpの使い方を保管する構成もある

この発表ではmcpをメインに解説

### 具体的なツール紹介

有力な3つを紹介

- maestro mcp
- mobile mcp
- marionette mcp

どのツールでもUI検証はできるが、実現方法など違いがあるのでそれを解説

#### maestro mcp

- e2eテストツールとして有名なmaestroのmcp
- mcp独自の機能は現状なく、はmaestro cliをラップしたツール
- 最新のmaestro cliをインストールするとついでに使えるようになる
- iOS/Android対応
  <https://docs.maestro.dev/getting-started/maestro-mcp>

#### mobile mcp

- mobileのUI操作mcpとしては先駆者
  <https://github.com/mobile-next/mobile-mcp>

#### marionette mcp

- LeanCodeが開発してFlutter特化のmcp
- Flutterに閉じた仕組みで動作しており、他とはアプローチが結構違う
- Fllutterの仕組みベースなので、デスクトップ向け（macOS等）でも動くのが地味にありがたい
- 使ってみたがvm uriの取得が結構不安定
- Skillsでカバーすればいい感じかも
  <https://pub.dev/packages/marionette_mcp>

## まとめ
