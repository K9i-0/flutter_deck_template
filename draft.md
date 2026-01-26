# タイトル

Flutterアプリ開発でもUI検証のフィードバックループを回そう

## 自己紹介

- Twitterプロフ
- 最近書いたzennの記事
- FlutterGakkaiは第4回以来の登壇
  - Riverpodに機能追加したときの話 (long ver.)
  - <https://fluttergakkai.connpass.com/event/284732/>

## 導入

<!-- ### AI駆動開発が当たり前になった

Claude Code、Cursor、Codex CLI ... -->

### AI駆動開発してますか？

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

## mcpの比較

ここから旧

## Q導入

- AI駆動開発してますか？
- 私は
  - 9割くらいAIでコード書いてる(制約がややこしいUI組むときとかだけ手書き)
  - Claude Code + VS Code
    - Claude Code：基本全部
    - VS Code：エディタは手書きするときにしか開かないので、慣れてるVS CodeであえてAI機能は使わず利用
- もしAIツール（最近はハーネス呼び？）何使うべきか悩んでる人いたら
  - Claude Code一択
    - Claude Codeが始めた機能（Skills, subagentなど）を他ツールが後追いし、業界標準になる流れ
  - GoogleのツールがFlutterと相性いいとか正直無い
    - Gemini CLIもAntigravityも現状手を出さなくていい

### 今日の話

- タイトルにあるフィードバックループとはなにか
- AI駆動開発するうえで抑えておきたい基礎
- Flutterでフィードバックするうえでの知識

技術的なことより、そもそものFBループの意義の話多めです

## フィードバックループとは

- AIエージェント自体に検証の方法を与えて、動作確認 > 修正のループを回すこと
  - 検証の種類は様々
    - 代表的なのはlintやユニットテスト
    - AIに実際にUI操作させる < 今回はこれ
  - AI駆動開発の最前線にいるClaude Codeの開発者がFBループが最も重要と言ってる

## AI駆動開発するうえで抑えておきたい基礎

- そもそもの目的は生産性を上げること
  コーディングエージェントを使った開発が当たり前に > どうしたら生産性があがるか
  並列数をあげる x エージェントの自律性をあげる

- コンテキストウィンドウについて
- mcp、Skillsについて

## Flutterでの話

- FlutterでのUI操作のFBループの選択肢がいくつかある
  - mobile mcp、maestro mcp、marionette mcp、cliをSkillsでラップ
  - タイトルにはmaestro mcpと書いたが、正直どれがベストと言い切れてる状況ではない
- （小さく）ユニットテスト、lintはあえて説明する必要ないと思うので話さないです

### mobile mcp、maestro mcp、marionette mcp

- 基本的に同じようなことができるツール
  - 画面要素の把握、スクショ、UI操作（タップなど）
- 仕組みが割と違う

### mobile mcpについて

- mobileのUI操作mcpとしては先駆者

### maestro mcpについて

- e2eテストツールとして有名なmaestroのmcp
- mcpといいつつ現状はmaestro cliをラップしたツール
- 最新のmaestro cliをインストールするとついでに使えるようになる

### marionette mcp

- LeanCodeが開発してFlutter特化のmcp
- Flutterに閉じた仕組みで動作しており、他とはアプローチが結構違う
- Fllutterの仕組みベースなので、デスクトップ向け（macOS等）でも動くのが地味にありがたい
- 使ってみたがvm uriの取得が結構不安定
- Skillsでカバーすればいい感じかも

## まとめ

- UI操作のFBループは今後間違いなく重要
- ベストなツールは今後も変わるだろうが、実践投入で知見を共有し合おう
