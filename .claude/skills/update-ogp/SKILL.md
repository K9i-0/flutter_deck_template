---
name: update-ogp
description: OGPメタタグを更新。「OGP更新」「OGP設定」「ogp」などで発動。
allowed-tools: Read, Edit, Glob
---

# Update OGP Skill

`web/index.html` のOGPメタタグを、現在のプレゼンテーション情報に合わせて更新するスキル。

## 作業フロー

### 1. 現在の情報を取得

`lib/config/speaker_info.dart` から以下を読み取る：

- `presentationTitle` → `og:title`
- `name` + `presentationSubtitle` → `og:description`（`{name} | {subtitle}` 形式）

### 2. OGPメタタグを更新

`web/index.html` 内の以下を更新する：

```html
<meta property="og:title" content="...">
<meta property="og:description" content="...">
```

### 対応表

| OGPプロパティ | ソース | 例 |
|---|---|---|
| `og:title` | `SpeakerInfo.presentationTitle` | MCPでFlutterアプリの... |
| `og:description` | `{SpeakerInfo.name} \| {SpeakerInfo.presentationSubtitle}` | K9i a.k.a. たこさん \| 第9回 FlutterGakkai |

### 3. 更新後の確認

OGP更新後、以下を案内する：

- **ローカル確認**: ブラウザのDevToolsでmetaタグを確認
- **デプロイ後確認**: [OGP確認ツール](https://ogp.me/) や各SNSのデバッガーで確認
  - Twitter: [Card Validator](https://cards-dev.twitter.com/validator)
  - Facebook: [Sharing Debugger](https://developers.facebook.com/tools/debug/)
- **OGP画像**: CIで自動生成されるため `og:image` の変更は不要

### 注意事項

- `og:image` はCIで自動設定されるため変更しない
- `og:type` と `twitter:card` は固定値なので変更しない
- HTMLの特殊文字（`&`, `<`, `>` など）がタイトルに含まれる場合はエスケープする
