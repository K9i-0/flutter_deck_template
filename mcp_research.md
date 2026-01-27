# UI検証MCP調査結果

## 調査対象

- Maestro MCP
- Mobile MCP
- Marionette MCP

---

## 比較サマリー

| 項目 | Maestro MCP | Mobile MCP | Marionette MCP |
|------|-------------|------------|----------------|
| **開発元** | Mobile Dev, Inc. | Mobile Next | LeanCode |
| **最新バージョン** | CLI 2.1.0 | 0.0.41 | 0.3.0 |
| **対応プラットフォーム** | iOS/Android/Web | iOS/Android | macOS/Linux/Windows |
| **仕組み（iOS）** | XCUITest | WebDriverAgent | - |
| **仕組み（Android）** | UIAutomator | UIAutomator | - |
| **Flutterアプリ対応** | 不要（Semantics推奨） | 不要 | marionette_flutter統合必須 |
| **デスクトップ対応** | ✗ | ✗ | ✓（デスクトップ専用） |
| **リリースモード** | ✓ | ✓ | ✗（デバッグ/profileのみ） |

---

## Maestro MCP

### 概要
- E2Eテストツール「Maestro」のMCP
- CLIをラップした形式で、MCPツールとしても使える

> **注意**: 以前は独立した[maestro-mcp](https://github.com/mobile-dev-inc/maestro-mcp)リポジトリが存在したが、現在は**Archived**。MCP機能はMaestro CLIに統合されている。

### 開発元
- **Mobile Dev, Inc.**
- https://github.com/mobile-dev-inc/Maestro

### 仕組み

```
AIエージェント → Maestro MCP → Maestro CLI → XCUITest/UIAutomator → アプリ
```

- **iOS**: XCUITestベース
- **Android**: UIAutomatorベース
- **Web**: Selenium/Playwrightベース
- アプリ外部からのブラックボックステスト
- アクセシビリティツリーを解析して要素を特定

### セットアップ

```bash
# Maestro CLIインストール（MCPも含まれる）
curl -Ls "https://get.maestro.mobile.dev" | bash

# MCP設定（.mcp.json）
{
  "maestro": {
    "type": "stdio",
    "command": "maestro",
    "args": ["mcp"]
  }
}
```

### Flutterアプリ側の対応

**特別な対応は不要**（ブラックボックステスト）

ただし、Semanticsを設定するとMaestroの検出精度が向上（Flutter 3.19以降で`identifier`プロパティ利用可能）：

```dart
Semantics(
  identifier: 'todo-fab-add',  // → resource-id として認識される
  label: 'Add new todo',
  child: FloatingActionButton(...),
)
```

### 主要なMCPツール

| ツール | 用途 |
|--------|------|
| `list_devices` | デバイス一覧 |
| `launch_app` | アプリ起動 |
| `inspect_view_hierarchy` | UI要素取得 |
| `tap_on` | タップ（ID/テキスト指定） |
| `input_text` | テキスト入力 |
| `take_screenshot` | スクリーンショット |
| `run_flow` | YAMLフロー実行 |

### 画面要素取得の特徴

- アクセシビリティツリーベース
- `resource-id`（Semantics identifier）で直接指定可能
- 座標取得不要でMCPコール数が少ない

### 画面操作の特徴

- ID/テキスト指定でタップ（座標不要）
- YAMLフローを再利用可能（`run_flow`）
- `hideKeyboard`コマンドあり

### 制限事項

- 日本語入力非対応（Unicodeエラー）
- 動的IDの直接指定不可（テキスト指定で代替）

---

## Mobile MCP

### 概要
- モバイルUI操作に特化したMCP
- iOS/Android両対応

### 開発元
- **Mobile Next**
- https://github.com/mobile-next/mobile-mcp

### 仕組み

```
AIエージェント → Mobile MCP → WebDriverAgent/UIAutomator → アプリ
```

- **iOS**: WebDriverAgent経由
- **Android**: UIAutomator経由
- 2段階アプローチ：
  1. アクセシビリティツリー優先
  2. スクリーンショット分析フォールバック

### セットアップ

```bash
# 環境要件
# - Xcode コマンドラインツール（iOS用）
# - Android Platform Tools（Android用）
# - Node.js v22以上（必須）

# MCP設定（.mcp.json）
{
  "mobile-mcp": {
    "type": "stdio",
    "command": "npx",
    "args": ["-y", "@mobilenext/mobile-mcp@0.0.41"]
  }
}
```

### Flutterアプリ側の対応

**特別な対応は不要**

### 主要なMCPツール

| ツール | 用途 |
|--------|------|
| デバイス管理 | 一覧表示、画面サイズ取得 |
| `mobile_list_elements_on_screen` | UI要素取得 |
| `mobile_click_on_screen_at_coordinates` | 座標指定タップ |
| `mobile_type_keys` | テキスト入力 |
| `mobile_take_screenshot` | スクリーンショット |
| `mobile_swipe_on_screen` | スワイプ操作 |

### 画面要素取得の特徴

- アクセシビリティツリー + スクリーンショットフォールバック
- 要素の座標情報（x, y, width, height）を取得
- LLMが理解しやすいJSON形式

### 画面操作の特徴

- 座標指定でタップ（柔軟性高い）
- 単一操作が高速
- スワイプ等の細かい制御が可能

---

## Marionette MCP

### 概要
- **Flutter特化**のMCP
- Flutter独自の仕組み（VM Service Protocol）で動作
- **デスクトップ専用**（macOS/Linux/Windows）

### 開発元
- **LeanCode**（Patrol UIテストフレームワークの開発元）
- https://pub.dev/packages/marionette_mcp
- https://marionette.leancode.co/

### 仕組み

```
AIエージェント → Marionette MCP → VM Service Protocol → Flutterアプリ
```

- Flutter VM Service Protocolを使用
- ウィジェットツリーを直接操作
- **デスクトップアプリ専用**（MCPサーバーがデスクトッププラットフォームのみ対応）

### セットアップ

```bash
# 1. MCPツールのインストール
dart pub global activate marionette_mcp

# 2. MCP設定（.mcp.json）
{
  "marionette": {
    "type": "stdio",
    "command": "marionette_mcp",
    "args": []
  }
}
```

### Flutterアプリ側の対応

**必須**: marionette_flutterパッケージの統合

```bash
flutter pub add marionette_flutter
```

```dart
// main.dart
import 'package:flutter/foundation.dart';
import 'package:marionette_flutter/marionette_flutter.dart';

void main() {
  if (kDebugMode) {
    MarionetteBinding.ensureInitialized();
  } else {
    WidgetsFlutterBinding.ensureInitialized();
  }
  runApp(const MyApp());
}
```

### 主要なMCPツール

| ツール | 用途 |
|--------|------|
| `connect` | VM Service URIで接続 |
| `disconnect` | 接続解除 |
| `get_interactive_elements` | インタラクティブ要素取得 |
| `tap` | タップ（Key/テキスト指定） |
| `enter_text` | テキスト入力 |
| `scroll_to` | スクロール |
| `take_screenshots` | スクリーンショット |
| `get_logs` | アプリログ取得 |
| `hot_reload` | ホットリロード |

### 画面要素取得の特徴

- **Flutterウィジェットツリー**ベース
- インタラクティブ要素のみをフィルタリング
- ValueKey指定で確実な要素特定

### 画面操作の特徴

- Key/テキスト指定でタップ
- **ホットリロード連携**（コード変更後即反映）
- Flutter特化で安定

### 制限事項

- **デバッグ/profileモードのみ対応**（リリースビルド非対応）
- **デスクトッププラットフォーム専用**（iOS/Androidは非対応）
- VM Service URIの取得が必要（やや不安定な場合あり）

---

## ベンチマーク結果（Maestro vs Mobile）

**計測環境**: iPhone 17 Pro シミュレーター (iOS 26.0)

| シナリオ | Maestro MCP | Mobile MCP | 差 |
|---------|-------------|------------|-----|
| UI要素取得 | 2.4秒/回 | 2.3秒/回 | ≒同等 |
| 単純タップ | 3.4秒/回 | 2.9秒/回 | Mobile 15%速 |
| 画面遷移 | 12.5秒/往復 | 5.5秒/往復 | Mobile 2倍速 |
| テキスト入力 | 5.9秒/操作 | 3.5秒/操作 | Mobile 1.7倍速 |
| スクリーンショット | 2.8秒/回 | 3.3秒/回 | Maestro 15%速 |

### MCPコール数の比較

| 操作 | Maestro MCP | Mobile MCP |
|------|-------------|------------|
| FABタップ | 1 (`tap_on`) | 1 (`click`) |
| タイトル入力 | 2 | 2 |
| カテゴリ選択 | 1 | 1〜2（座標取得含む） |
| **合計** | **少ない傾向** | **多い傾向** |

---

## 使い分け推奨

| ユースケース | 推奨MCP | 理由 |
|-------------|---------|------|
| iOS/Android実機E2E | Maestro MCP | resource-idで安定、YAML再利用 |
| 単発の高速操作 | Mobile MCP | 単一操作が高速 |
| Flutterデスクトップアプリ | Marionette MCP | デスクトップ専用・Flutter特化 |
| ホットリロード連携 | Marionette MCP | コード変更→即確認 |
| リリースビルド検証 | Maestro/Mobile | Marionetteはデバッグ/profileのみ |
| iOS/Androidモバイル | Maestro/Mobile | Marionetteはデスクトップ専用 |

---

## 仕組みの違い（図解用）

### Maestro MCP / Mobile MCP
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ AIエージェント │ → │ MCP Server  │ → │ OS標準API   │
└─────────────┘    └─────────────┘    └─────────────┘
                                            ↓
                   XCUITest (iOS) / UIAutomator (Android)
                                            ↓
                                      ┌───────────┐
                                      │ アプリ     │
                                      │（外部操作）│
                                      └───────────┘
```

### Marionette MCP
```
┌─────────────┐    ┌─────────────┐    ┌───────────────┐
│ AIエージェント │ → │ MCP Server  │ → │ VM Service    │
└─────────────┘    └─────────────┘    │ Protocol      │
                                      └───────────────┘
                                            ↓
                                      ┌───────────┐
                                      │ Flutterアプリ│
                                      │（内部操作）│
                                      └───────────┘
```

---

## 参考リンク

- Maestro: https://docs.maestro.dev/getting-started/maestro-mcp
- Maestro GitHub: https://github.com/mobile-dev-inc/maestro
- Mobile MCP: https://github.com/mobile-next/mobile-mcp
- Mobile MCP npm: https://www.npmjs.com/package/@mobilenext/mobile-mcp
- Marionette MCP: https://pub.dev/packages/marionette_mcp
- Marionette公式サイト: https://marionette.leancode.co/
