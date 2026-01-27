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
| **実装言語** | Kotlin + Swift | TypeScript + Go | Dart |
| **ライセンス** | Apache 2.0 | MIT | MIT |
| **対応プラットフォーム** | iOS/Android/Web | iOS/Android | macOS/Linux/Windows |
| **iOS通信** | HTTP (独自XCUITestランナー) | HTTP (WDA/Appium製) | - |
| **Android通信** | **gRPC** (常駐サービス) | **ADB** (コマンド直接) | - |
| **iOSポート** | 22087 | 8100 | - |
| **Androidポート** | 7001 | - (ADB経由) | - |
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

- **iOS**: XCUITestベース（独自XCUITestランナー経由）
- **Android**: UIAutomatorベース
- **Web**: Selenium/Playwrightベース
- アプリ外部からのブラックボックステスト
- アクセシビリティツリーを解析して要素を特定

### 内部実装の詳細（iOS）

Maestroは**独自のXCUITestランナー**（Swift製）を使用する。

```
┌───────────────────┐
│  Maestro CLI      │  ← Kotlin製
│  (ホストPC)       │
└────────┬──────────┘
         │ HTTP REST API (ポート22087)
         ▼
┌───────────────────┐
│  XCUITest Runner  │  ← Swift製、Maestro独自開発
│  (HTTPサーバー)   │     iOSデバイス上で動作
└────────┬──────────┘
         │ 内部で呼び出し
         ▼
┌───────────────────┐
│  XCUITest         │  ← Apple公式フレームワーク
└───────────────────┘
```

**動作フロー:**
1. Maestro CLIがXCUITestランナーをiOSデバイス上で起動
2. ランナーがHTTPサーバー（ポート22087）として待機
3. CLIがHTTPリクエストでコマンド送信（タップ、スワイプ等）
4. ランナーがXCUITest APIを呼び出して実行
5. 結果をJSONで返却

**主要エンドポイント:**
- `/viewHierarchy` - UI要素ツリー取得
- `/tap` - タップ操作
- `/swipe` - スワイプ操作
- `/inputText` - テキスト入力
- `/launchApp` - アプリ起動
- `/runningApp` - 実行中アプリ情報

**シミュレータ操作:**
`xcrun simctl`コマンドを使用（SimctlIOSDevice）

> 参考: [Maestro iOS Driver Architecture](https://deepwiki.com/mobile-dev-inc/Maestro/4.1-ios-driver-architecture)

### 内部実装の詳細（Android）

AndroidはiOSと異なり、**gRPC**で通信する（Mobile MCPはADB直接実行）。

```
┌───────────────────┐
│  Maestro CLI      │  ← Kotlin製
│  (ホストPC)       │
└────────┬──────────┘
         │ gRPC (ポート7001、ADBポートフォワード経由)
         ▼
┌───────────────────┐
│ MaestroDriverService │  ← Kotlin製、Instrumentation Test
│  (gRPCサーバー)      │     Androidデバイス上で動作
└────────┬──────────┘
         │ UIAutomation API呼び出し
         ▼
┌───────────────────┐
│  UIAutomator      │  ← Android公式フレームワーク
└───────────────────┘
```

**gRPCサービス定義 (maestro.proto):**
```protobuf
service MaestroDriver {
  rpc deviceInfo(DeviceInfoRequest) returns (DeviceInfo);
  rpc viewHierarchy(ViewHierarchyRequest) returns (ViewHierarchyResponse);
  rpc screenshot(ScreenshotRequest) returns (ScreenshotResponse);
  rpc tap(TapRequest) returns (TapResponse);
  rpc inputText(InputTextRequest) returns (InputTextResponse);
  rpc launchApp(LaunchAppRequest) returns (LaunchAppResponse);
  rpc setLocation(SetLocationRequest) returns (SetLocationResponse);
  // ...
}
```

**Mobile MCPとの違い:**
| 項目 | Maestro | Mobile MCP |
|------|---------|------------|
| **通信方式** | gRPC | ADBコマンド直接実行 |
| **デバイス側** | gRPCサーバー常駐 | 不要 |
| **セットアップ** | Instrumentationテストをインストール | 不要 |
| **パフォーマンス** | 接続維持で高速 | 毎回ADB起動 |

### プロジェクト構造

```
Maestro/ (Apache 2.0 License)
├── maestro-cli/                 # CLI & MCPサーバー (Kotlin)
├── maestro-client/              # Driverインターフェース抽象化
├── maestro-android/             # Android gRPCサービス
├── maestro-ios-driver/          # iOS HTTPクライアント (Kotlin)
├── maestro-ios-xctest-runner/   # iOS XCUITestランナー (Swift)
├── maestro-orchestra/           # YAMLフロー実行エンジン
├── maestro-proto/               # Protocol Buffers定義
├── maestro-web/                 # Webドライバー (Chrome DevTools)
└── maestro-ai/                  # AI統合コンポーネント
```

**コード規模:**
- 総行数: ~50,400行
- Kotlin: ~400+ファイル
- Swift: 58ファイル

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
- **mobilecli**をバックエンドとして使用

### 開発元
- **Mobile Next**
- https://github.com/mobile-next/mobile-mcp

### 仕組み

```
┌─────────────────────────────────────────────────┐
│  AI Agent / LLM (Claude Code など)              │
└─────────────────┬───────────────────────────────┘
                  │ MCP Protocol
                  ▼
┌─────────────────────────────────────────────────┐
│  Mobile MCP (@mobilenext/mobile-mcp)            │
│  - MCPサーバー                                   │
│  - ツール定義 (mobile_tap, mobile_screenshot等) │
└─────────────────┬───────────────────────────────┘
                  │ JSON-RPC / CLI呼び出し
                  ▼
┌─────────────────────────────────────────────────┐
│  mobilecli                                      │
│  - 実際のデバイス操作を実行                      │
│  - iOS: Xcode tools / WDA 経由                  │
│  - Android: ADB 経由                            │
└─────────────────────────────────────────────────┘
```

- **Mobile MCP** = AI/LLM向けのMCPインターフェース層
- **mobilecli** = 実際のデバイス操作を行うバックエンド
- 2段階アプローチ：
  1. アクセシビリティツリー優先
  2. スクリーンショット分析フォールバック

### mobilecli について

**リポジトリ**: [mobile-next/mobilecli](https://github.com/mobile-next/mobilecli)

iOS/Android デバイス、シミュレーター、エミュレーターを**統一的に操作するCLIツール**。

**主な機能:**
- デバイス列挙・管理
- シミュレーター/エミュレーターの起動・停止
- スクリーンショット撮影（PNG/JPEG）
- MJPEGビデオストリーミング
- タップ、ボタン押下、テキスト入力
- アプリの起動・終了

**技術スタック:**
- **Go** (89.9%) - コア実装
- **TypeScript** (9.5%) - npm配布用
- WebSocket + JSON-RPC 2.0 サポート
- HTTP RPC エンドポイント

### アップデート履歴

| バージョン | 日付 | 主な変更 |
|-----------|------|----------|
| 0.0.41 | 2025/1/27 | mobilecli 0.0.52、Android `resource-id`/`checkable` 属性対応 |
| 0.0.40 | 2025/1/15 | MCP SDK脆弱性修正 |
| 0.0.39 | 2025/1/15 | iOS/Android long-press のカスタム duration 対応 |
| 0.0.38 | 2024/12/9 | iOS Simulator を mobilecli 経由に移行、WDA自動ダウンロード |

**mobilecli 0.0.52 の新機能:**
- WebSocket対応のJSON-RPC（単一接続で複数リクエスト処理）
- iOS実機でのAVCスクリーンキャプチャ
- UIダンプでラベルなしボタンも含むよう拡張

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
- **v0.0.41以降**: Android で `resource-id` や `checkable` 属性を持つ要素も取得可能

### 画面操作の特徴

- 座標指定でタップ（柔軟性高い）
- 単一操作が高速
- スワイプ等の細かい制御が可能
- **v0.0.39以降**: long-press のカスタム duration 対応

### 内部実装の詳細

#### アーキテクチャ

```
┌────────────────────────────────────────────────────────────────┐
│  Mobile MCP (TypeScript / Node.js)                             │
│  src/server.ts - MCPツール定義 (20+ツール)                      │
│  src/mobilecli.ts - mobilecliバイナリのラッパー                 │
│  src/robot.ts - デバイス抽象化インターフェース                   │
└───────────────────────────┬────────────────────────────────────┘
                            │ CLI呼び出し / JSON出力パース
                            ▼
┌────────────────────────────────────────────────────────────────┐
│  mobilecli (Go / ~9,300行)                                     │
│  ├── cli/          - CLIコマンド定義                           │
│  ├── commands/     - コマンド実装                              │
│  ├── devices/      - デバイス抽象化 & プロトコル実装            │
│  │   ├── ios.go        - iOS実機                              │
│  │   ├── simulator.go  - iOSシミュレータ                       │
│  │   ├── android.go    - Android                              │
│  │   └── wda/          - WebDriverAgentクライアント            │
│  └── server/       - JSON-RPC / WebSocketサーバー              │
└───────────────────────────┬────────────────────────────────────┘
                            │
        ┌───────────────────┴───────────────────┐
        ▼                                       ▼
┌───────────────────┐                   ┌───────────────────┐
│      iOS          │                   │     Android       │
│  go-ios + WDA     │                   │       ADB         │
└───────────────────┘                   └───────────────────┘
```

#### go-ios + WDA とは何か？

**重要**: どちらも**Apple公式ツールではない**。サードパーティ製。

Appleは**公式のリモートUI操作APIを提供していない**ため、サードパーティがリバースエンジニアリングで実現している。

```
Android: adb shell input tap 100 200  ← 公式ツールで簡単
iOS:     go-ios → WDA → XCUITest     ← 複雑な迂回が必要
```

**go-ios** ([GitHub](https://github.com/danielpaulus/go-ios)):
- Appleの**非公開プロトコルをリバースエンジニアリング**して実装したGoライブラリ
- 類似プロジェクト: `libimobiledevice`（C言語実装）
- できること: デバイス検出、ペアリング、ポートフォワーディング、iOS 17+トンネル接続

```
┌─────────────┐
│   go-ios    │  ← サードパーティ製Goライブラリ
└──────┬──────┘
       │ リバースエンジニアリングした非公開プロトコル
       ▼
┌─────────────────────────────────────┐
│  Apple非公開プロトコル               │
│  - usbmuxd (USB多重化デーモン)       │
│  - lockdownd (デバイスロック管理)    │
│  - AFC (Apple File Conduit)         │
└─────────────────────────────────────┘
```

**WDA (WebDriverAgent)** ([GitHub](https://github.com/appium/WebDriverAgent)):
- 元Facebook開発、現在はAppiumプロジェクトが維持管理
- **XCUITest**（Apple公式UIテストフレームワーク）を**HTTP API経由で操作できるようにするプロキシアプリ**
- iOSデバイス上でHTTPサーバーとして動作

```
┌───────────────────┐
│  mobilecli        │
└────────┬──────────┘
         │ HTTP REST API (ポート8100)
         ▼
┌───────────────────┐
│  WebDriverAgent   │  ← iOSデバイス上で動作
│  (HTTPサーバー)   │     元Facebook、現Appium管理
└────────┬──────────┘
         │ 内部で呼び出し
         ▼
┌───────────────────┐
│  XCUITest         │  ← Apple公式フレームワーク
└───────────────────┘
```

| 項目 | go-ios | WDA | XCUITest |
|------|--------|-----|----------|
| **開発元** | 個人開発者 | Facebook→Appium | **Apple** |
| **Apple公式** | ✗ | ✗ | ✓ |
| **役割** | デバイス通信 | HTTP→XCUITest変換 | UI操作実行 |
| **動作場所** | ホストPC | iOSデバイス上 | iOSデバイス上 |

#### iOS通信プロトコル

| プロトコル | 用途 | 実装 |
|-----------|------|------|
| **iTunes/Xcode USB** | デバイス検出・ペアリング | go-iosライブラリ |
| **USB Multiplexer** | ポートフォワーディング | go-iosライブラリ |
| **WebDriverAgent (WDA)** | UI操作（タップ、スワイプ等） | HTTP REST API |
| **W3C WebDriver Actions** | 複雑なジェスチャー | WDA `/session/{id}/actions` |
| **Tunnel Protocol (iOS 17+)** | セキュア接続 | go-ios tunnel |
| **MJPEG** | ビデオストリーミング | HTTPチャンク読み取り |

**WDAプロトコルフロー:**
```
1. セッション作成: POST /session
   → sessionId取得

2. タップ: POST /session/{sessionId}/actions
   {
     "actions": [{
       "type": "pointer",
       "id": "finger1",
       "parameters": { "pointerType": "touch" },
       "actions": [
         {"type": "pointerMove", "x": 100, "y": 200},
         {"type": "pointerDown", "button": 0},
         {"type": "pause", "duration": 100},
         {"type": "pointerUp", "button": 0}
       ]
     }]
   }

3. スクリーンショット: GET /screenshot
   → base64エンコードPNG

4. UI要素取得: GET /source
   → XMLアクセシビリティツリー
```

**iOS 17+の注意点:**
- トンネル接続が必須（直接USB接続不可）
- ペアリングレコードが `/tmp/mobilecli-pairrecords` に保存
- 5秒ごとにトンネル状態を更新

#### Android通信プロトコル

| プロトコル | 用途 | 実装 |
|-----------|------|------|
| **ADB (Android Debug Bridge)** | 全デバイス操作 | `exec.Command("adb", ...)` |
| **shell input** | タップ・スワイプ・テキスト入力 | `adb shell input` |
| **screencap** | スクリーンショット | `adb exec-out screencap -p` |
| **dumpsys** | ディスプレイ情報・システム情報 | `adb shell dumpsys` |
| **pm (Package Manager)** | アプリ一覧・インストール | `adb shell pm` |
| **am (Activity Manager)** | アプリ起動・停止 | `adb shell am` |

**ADBコマンド対応表:**

| 操作 | ADBコマンド |
|------|------------|
| タップ | `adb shell input tap <x> <y>` |
| 長押し | `adb shell input swipe <x> <y> <x> <y> <duration>` |
| スワイプ | `adb shell input swipe <x1> <y1> <x2> <y2> 1000` |
| テキスト入力 | `adb shell input text "message"` |
| ボタン押下 | `adb shell input keyevent <keycode>` |
| スクリーンショット | `adb exec-out screencap -p -d <displayID>` |
| アプリ起動 | `adb shell monkey -p <bundleID> -c android.intent.category.LAUNCHER 1` |
| アプリ停止 | `adb shell am force-stop <bundleID>` |
| UI要素取得 | `adb shell uiautomator dump` → XMLパース |

#### デバイス抽象化インターフェース

mobilecliは `ControllableDevice` インターフェースで全デバイスを統一的に扱う:

```go
type ControllableDevice interface {
    // 識別
    ID() string           // デバイスID/UDID
    Platform() string     // "ios" | "android"
    DeviceType() string   // "real" | "simulator" | "emulator"

    // UI操作
    Tap(x, y int) error
    LongPress(x, y, duration int) error
    Swipe(x1, y1, x2, y2 int) error
    SendKeys(text string) error

    // スクリーンショット
    TakeScreenshot() ([]byte, error)

    // アプリ管理
    LaunchApp(bundleID string) error
    TerminateApp(bundleID string) error
    ListApps() ([]InstalledAppInfo, error)

    // UI要素
    DumpSource() ([]ScreenElement, error)
}
```

#### ポート設定

| 用途 | ポート範囲 |
|------|-----------|
| iOS WDA (実機) | 8100-8299 |
| iOS WDA (シミュレータ) | 13001-13200 |
| iOS MJPEG (シミュレータ) | 13201-13400 |
| JSON-RPC/WebSocketサーバー | 12000 |

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

## iOSアプローチの比較

MaestroとMobile MCPは**どちらもXCUITestを最終的に使う**が、中間層が異なる。

| 項目 | Maestro | Mobile MCP |
|------|---------|------------|
| **HTTPサーバー** | 独自XCUITestランナー | WDA (Appium製) |
| **ポート** | 22087 | 8100 |
| **開発元** | Maestro開発チーム | Facebook→Appium |
| **デバイス通信** | 独自実装 | go-ios |

```
┌─────────────────────────────────────────────────────────────────┐
│                     共通: XCUITest (Apple公式)                  │
└─────────────────────────────────────────────────────────────────┘
                    ▲                           ▲
                    │                           │
┌───────────────────┴───────────┐ ┌─────────────┴───────────────┐
│  Maestro XCUITest Runner      │ │  WebDriverAgent (WDA)       │
│  - Swift製                    │ │  - Objective-C製            │
│  - Maestro独自開発            │ │  - Appium管理               │
│  - ポート22087                │ │  - ポート8100               │
└───────────────────┬───────────┘ └─────────────┬───────────────┘
                    │ HTTP                      │ HTTP
┌───────────────────┴───────────┐ ┌─────────────┴───────────────┐
│  Maestro CLI (Kotlin)         │ │  mobilecli (Go)             │
│  + simctl (シミュレータ管理)   │ │  + go-ios (デバイス通信)     │
└───────────────────────────────┘ └─────────────────────────────┘
```

**なぜ両者とも独自実装が必要か？**

Appleは公式のリモートUI操作APIを提供していないため、以下の迂回が必要：
1. XCUITestランナーをデバイス上でHTTPサーバーとして起動
2. ホストPCからHTTPリクエストでコマンド送信
3. ランナーがXCUITest APIを呼び出して実行

---

## Androidアプローチの比較

MaestroとMobile MCPは**Androidで全く異なるアプローチ**を取る。

### アーキテクチャの違い

```
【Maestro方式】─ 常駐サーバー型 (Instrumentation Test)

┌──────────────┐                    ┌─────────────────────────┐
│  Maestro CLI │ ── gRPC (7001) ──→ │   Android端末           │
│  (ホストPC)  │     接続維持       │  ┌───────────────────┐ │
└──────────────┘                    │  │ Instrumentation   │ │
                                    │  │ Test (常駐)       │ │
                                    │  │  └→ UiAutomation  │ │
                                    │  └───────────────────┘ │
                                    └─────────────────────────┘

【Mobile MCP方式】─ コマンド直接実行型

┌──────────────┐                    ┌─────────────────────────┐
│  mobilecli   │ ── ADB shell ───→  │   Android端末           │
│  (ホストPC)  │   毎回プロセス起動  │                         │
└──────────────┘                    │  input tap 100 200     │
                                    │  (実行して終了)         │
                                    └─────────────────────────┘
```

### Instrumentation Test とは？

Androidの「特権付きテスト実行環境」。通常アプリとは異なる仕組み。

| 項目 | 通常のアプリ (Flutter等) | Instrumentation Test |
|------|------------------------|---------------------|
| **起動方法** | アイコンタップ | `adb shell am instrument` |
| **ランチャー表示** | ✓ 表示される | ✗ 表示されない |
| **他アプリ操作** | ✗ 不可能 | ✓ 可能 |
| **UiAutomation API** | ✗ アクセス不可 | ✓ アクセス可能 |
| **用途** | ユーザー向け機能 | テスト・自動化 |

**Maestroは2つのAPKをデバイスにインストールする:**
```
maestro-app.apk     ← ダミーアプリ（Instrumentation Testのホスト役）
maestro-server.apk  ← gRPCサーバー（Instrumentation Test本体）
```

これらはMaestro CLIにバンドルされており、初回実行時に自動インストールされる。

### 詳細比較

| 項目 | Maestro | Mobile MCP |
|------|---------|------------|
| **デバイス側** | APK 2つインストール | **何もインストールしない** |
| **通信方式** | gRPC (接続維持) | ADBコマンド (毎回実行) |
| **UI操作API** | UiAutomation (直接) | `adb shell input` |
| **スクリーンショット** | UiAutomation API | `adb exec-out screencap` |
| **View階層取得** | UiAutomation API | `adb shell uiautomator dump` |
| **ランチャー表示** | されない | - |
| **初回セットアップ** | APKインストール + サーバー起動待ち | **不要（即実行）** |

### 処理フローの違い

```
【タップ1回の処理】

Maestro:
  CLI → gRPC送信 → サーバー受信 → UiAutomation.tap() → 完了
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
              既存の接続を使う（高速）

Mobile MCP:
  CLI → adb shell → シェル起動 → input tap → 終了 → 結果返却
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
              毎回プロセス起動（オーバーヘッド）
```

### メリット・デメリット

**Maestro方式:**
- ✅ 高速（接続維持、API直接呼び出し）
- ✅ 高機能（UiAutomation の全機能使える）
- ✅ Toast検出など高度な機能
- ❌ 初回セットアップが必要（APKインストール）
- ❌ サーバー起動待ちが必要
- ❌ デバイス側にプロセス常駐

**Mobile MCP方式:**
- ✅ セットアップ不要（いきなり使える）
- ✅ シンプル（何もインストールしない）
- ✅ デバイス側にゴミが残らない
- ❌ 毎回ADBコマンド実行でオーバーヘッド
- ❌ `adb shell input` の機能制限
- ❌ 細かい制御が難しい

### ユースケース別推奨

| ユースケース | 推奨 | 理由 |
|-------------|------|------|
| CI/CD で大量テスト | Maestro | 速度重視、接続維持 |
| ちょっと試したい | Mobile MCP | セットアップ不要 |
| 高度なUI検証 | Maestro | UiAutomation直接アクセス |
| 複数デバイス切り替え | Mobile MCP | 状態管理が楽 |
| クリーンな環境維持 | Mobile MCP | APKインストール不要 |

---

## 仕組みの違い（図解用）

### Maestro MCP
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ AIエージェント │ → │ MCP Server  │ → │ Maestro CLI │
└─────────────┘    └─────────────┘    └─────────────┘
                                            ↓
                   XCUITest (iOS) / UIAutomator (Android)
                                            ↓
                                      ┌───────────┐
                                      │ アプリ     │
                                      │（外部操作）│
                                      └───────────┘
```

### Mobile MCP
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ AIエージェント │ → │ Mobile MCP  │ → │ mobilecli   │
└─────────────┘    │ (MCPサーバー) │    │ (Go製CLI)   │
                   └─────────────┘    └─────────────┘
                                            ↓
                        ┌───────────────────┼───────────────────┐
                        ↓                                       ↓
                  ┌───────────┐                           ┌───────────┐
                  │ iOS       │                           │ Android   │
                  │ WDA経由   │                           │ ADB経由   │
                  └───────────┘                           └───────────┘
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
- mobilecli GitHub: https://github.com/mobile-next/mobilecli
- Marionette MCP: https://pub.dev/packages/marionette_mcp
- Marionette公式サイト: https://marionette.leancode.co/
