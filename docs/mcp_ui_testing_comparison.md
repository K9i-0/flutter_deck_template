# UI検証MCP モバイル操作対応状況比較

## 概要

3つのUI検証MCP（Maestro MCP、Mobile MCP、Marionette MCP）について、モバイルアプリでよくある操作への対応状況を調査した。

## 対応状況比較表

| 操作 | Maestro MCP | Mobile MCP | Marionette MCP |
|------|:-----------:|:----------:|:--------------:|
| **タップ（tap）** | ✅ `tap_on` | ✅ `mobile_click_on_screen_at_coordinates` | ✅ `tap` |
| **ロングタップ（long press）** | ✅ `run_flow` (longPressOn) | ✅ `mobile_long_press_on_screen_at_coordinates` | ❌ 未対応 |
| **スクロール（scroll）** | ✅ `run_flow` (scroll) | ✅ `mobile_swipe_on_screen` | ✅ `scroll_to` |
| **スワイプ（swipe）** | ✅ `run_flow` (swipe) | ✅ `mobile_swipe_on_screen` | ⚠️ 内部のみ |
| **ダブルタップ（double tap）** | ✅ `run_flow` (doubleTapOn) | ✅ `mobile_double_tap_on_screen` | ⚠️ 内部のみ |
| **ピンチ/ズーム（pinch）** | ❌ 未対応 | ❌ 未対応 | ❌ 未対応 |
| **ドラッグ＆ドロップ** | ❌ 未対応 | ❌ 未対応 | ⚠️ 内部のみ |
| **テキスト入力（text input）** | ✅ `input_text` | ✅ `mobile_type_keys` | ✅ `enter_text` |
| **要素待機（wait for element）** | ⚠️ アニメーション限定 | ⚠️ 要素一覧取得で代替 | ⚠️ scroll_to内で使用 |
| **スクリーンショット** | ✅ `take_screenshot` | ✅ `mobile_take_screenshot` | ✅ `take_screenshots` |

### 凡例
- ✅ MCPツールとして公開済み
- ⚠️ 部分対応（内部実装のみ、または代替手段あり）
- ❌ 未対応

---

## 対応操作数ランキング

1. **Mobile MCP**: 8/10（最も多くの操作に対応）
2. **Maestro MCP**: 7/10（YAMLフローで柔軟な操作）
3. **Marionette MCP**: 6/10（Flutter専用、基本操作に特化）

---

## 各MCPの詳細

### 1. Maestro MCP

**対応数**: 7/10

**特徴**:
- YAMLベースの`run_flow`ツールで複雑な操作フローを実行可能
- 専用ツール（`tap_on`, `input_text`, `take_screenshot`）とYAML経由の操作を使い分け
- Android/iOSエミュレータ・実機に対応

**主要ツール**:
| ツール名 | 用途 |
|---------|------|
| `tap_on` | 要素をタップ（text/id/indexでマッチング） |
| `input_text` | フォーカス中のフィールドにテキスト入力 |
| `take_screenshot` | スクリーンショット取得（JPEG base64） |
| `run_flow` | YAMLフローを実行（複数コマンド対応） |
| `inspect_view_hierarchy` | UI要素階層を取得 |

**`run_flow`で使えるYAMLコマンド例**:
```yaml
# ロングプレス
- longPressOn:
    text: "button_text"

# スワイプ
- swipe:
    direction: up
    duration: 400

# ダブルタップ
- doubleTapOn:
    text: Button
```

---

### 2. Mobile MCP

**対応数**: 8/10

**特徴**:
- 座標ベースの操作が基本（x, y指定）
- TypeScript/Zodスキーマベースのツール定義
- AndroidはADB、iOSはWebDriverAgent経由で操作
- プラットフォーム抽象化されたRobotインターフェース

**主要ツール**:
| ツール名 | 用途 | パラメータ |
|---------|------|-----------|
| `mobile_click_on_screen_at_coordinates` | タップ | `device, x, y` |
| `mobile_long_press_on_screen_at_coordinates` | ロングタップ | `device, x, y, duration?` |
| `mobile_swipe_on_screen` | スワイプ/スクロール | `device, direction, x?, y?, distance?` |
| `mobile_double_tap_on_screen` | ダブルタップ | `device, x, y` |
| `mobile_type_keys` | テキスト入力 | `device, text, submit?` |
| `mobile_take_screenshot` | スクリーンショット | `device` |
| `mobile_list_elements_on_screen` | 要素一覧取得 | `device` |
| `mobile_press_button` | ハードウェアボタン | `device, button` |

**サポートボタン（`mobile_press_button`）**:
- HOME, BACK（Android only）, VOLUME_UP, VOLUME_DOWN, ENTER
- DPAD_CENTER, DPAD_UP, DPAD_DOWN, DPAD_LEFT, DPAD_RIGHT（Android TV）

---

### 3. Marionette MCP

**対応数**: 6/10（MCPツールとして公開分）

**特徴**:
- Flutter専用（VM Service Extension経由）
- キー（ValueKey）、テキスト、ウィジェットタイプ、座標でマッチング可能
- ホットリロード対応
- Flutter固有のウィジェットツリー操作に最適化

**主要ツール**:
| ツール名 | 用途 | パラメータ |
|---------|------|-----------|
| `connect` | VM Serviceに接続 | `uri` |
| `disconnect` | 接続切断 | - |
| `get_interactive_elements` | インタラクティブ要素取得 | - |
| `tap` | タップ | `key?, text?, type?, coordinates?` |
| `enter_text` | テキスト入力 | `key?, text?, input` |
| `scroll_to` | 要素までスクロール | `key?, text?` |
| `take_screenshots` | スクリーンショット | - |
| `get_logs` | アプリログ取得 | - |
| `hot_reload` | ホットリロード | - |

**未対応操作**:
- ロングタップ（実装可能だが未実装）
- ダブルタップ（内部にジェスチャー基盤はあり）
- スワイプ（`scroll_to`内部でdrag使用のみ）
- ピンチ/ズーム

---

## 選択の指針

| 用途 | 推奨MCP |
|------|---------|
| Flutter専用アプリのUI検証 | **Marionette MCP**（ホットリロード、ウィジェット操作） |
| 一般的なモバイルアプリ（Android/iOS） | **Mobile MCP**（操作種類が最多） |
| E2Eテストフロー実行 | **Maestro MCP**（YAMLベースのフロー定義） |

---

## CLI/低レベルAPIでの追加操作対応状況

MCPで未対応だった操作が、内部で使用しているCLIや低レベルAPIで可能かを調査した。

### 調査結果サマリー

| 操作 | Maestro CLI | mobilecli (iOS) | mobilecli (Android) |
|------|:-----------:|:---------------:|:-------------------:|
| **ピンチ/ズーム** | ❌ 未実装 | ✅ 可能 | ⚠️ 複雑 |
| **ドラッグ&ドロップ** | ❌ 未実装 | ✅ 可能 | ✅ 可能 |

---

### Maestro CLI

**結論**: ピンチ/ズーム、ドラッグ&ドロップともに **Maestro全体で未実装**（GitHub Issuesで確認済み）

MCPで未対応だった理由は、Maestroのコアライブラリ自体にこれらの機能が存在しないため。

#### GitHub Issues（公式）

**ピンチ/ズーム** - [Issue #2169](https://github.com/mobile-dev-inc/maestro/issues/2169)（2024年12月〜、Open）
- マルチタッチジェスチャーの実装が難しいため未対応
- 提案：ダブルタップ+ドラッグで1本指ピンチ風操作（iOS/Android標準機能）
- 現状：**まだ提案段階**（2025年7月時点でContributorが「Still just a proposal」と回答）
- `tapOn` + `swipe`の組み合わせは試行済みだが、コマンド間の時間が短くできず失敗

**ドラッグ&ドロップ** - [Issue #1203](https://github.com/mobile-dev-inc/maestro/issues/1203)（2023年6月〜、Open、40+リアクション）
- `longPressAndSwipeTo`コマンドの要望
- 提案API:
  ```yaml
  - longPressOnAndSwipeTo:
      longPressOn: # longPressOnの全パラメータ
      swipe: # swipeの全パラメータ
  ```
- より汎用的な`gesture`コマンドの提案も議論中
- 現状：**未実装、PR歓迎状態**
- 2026年1月にTodoistチームが実装貢献を申し出（進行中の可能性）

#### コード調査詳細
- `YamlFluentCommand.kt`: 45個のコマンド定義にpinch/zoomなし
- `maestro_android.proto`: gRPCメッセージにマルチタッチ用の定義なし
- iOS driver: ピンチのプライベートAPIヘッダーは存在するが、ルートハンドラー未実装
- Android driver: `MaestroDriverService.kt`にマルチタッチメソッドなし

#### 代替手段
- **ピンチ**: iOS/Androidの1本指ズーム機能（ダブルタップ+ドラッグ）を利用する案があるが、Maestroでは実装不可
- **ドラッグ&ドロップ**: Appiumとの併用が推奨されている

---

### Mobile MCP / mobilecli

**結論**: mobilecliの`io_gesture`コマンドを使えば **ピンチ/ズーム（iOS）とドラッグ&ドロップは可能**

#### アーキテクチャ

```
mobile-mcp (TypeScript/MCP)
   ↓
mobilecli (Go CLI + HTTP/WS Server)
   ↓
WebDriverAgent (iOS) / ADB (Android)
```

#### mobilecliの`io_gesture`コマンド

- **ファイル**: `/Users/kotahayashi/Workspace/mobilecli/commands/input.go`
- **エンドポイント**: `io_gesture`（HTTP JSON-RPC/WebSocket）
- **形式**: W3C WebDriver Actions API準拠

#### ピンチ/ズームの実装方法（iOS）

WebDriverAgent経由で複数ポインタを指定:

```json
{
  "actions": [
    {
      "type": "pointer",
      "id": "finger1",
      "parameters": { "pointerType": "touch" },
      "actions": [
        { "type": "pointerMove", "duration": 0, "x": 300, "y": 500 },
        { "type": "pointerDown", "button": 0 },
        { "type": "pointerMove", "duration": 500, "x": 200, "y": 400 },
        { "type": "pointerUp", "button": 0 }
      ]
    },
    {
      "type": "pointer",
      "id": "finger2",
      "parameters": { "pointerType": "touch" },
      "actions": [
        { "type": "pointerMove", "duration": 0, "x": 400, "y": 500 },
        { "type": "pointerDown", "button": 0 },
        { "type": "pointerMove", "duration": 500, "x": 500, "y": 600 },
        { "type": "pointerUp", "button": 0 }
      ]
    }
  ]
}
```

#### プラットフォーム別対応状況

| 操作 | iOS (WebDriverAgent) | Android (ADB) |
|------|:--------------------:|:-------------:|
| ピンチ/ズーム | ✅ W3C Actions APIで可能 | ⚠️ UIAutomator必要 |
| ドラッグ&ドロップ | ✅ 可能 | ✅ `input swipe`で可能 |

#### MCP側の課題

mobilecliは対応しているが、**mobile-mcp側のRobotインターフェースに公開されていない**:

- `robot.ts`に`pinch()`/`zoom()`メソッドなし
- `gesture()`のような汎用メソッドも未定義
- `io_gesture`機能が活用されていない

#### 実装推奨

1. **簡易**: `mobile_perform_gesture`ツールを追加（mobilecliの`io_gesture`ラッパー）
2. **中程度**: `mobile_pinch_zoom()`、`mobile_drag_and_drop()`メソッドを追加

---

## 全MCPで未対応の操作

- **ピンチ/ズーム** - 3つ全てのMCPで未対応
  - Maestro: コアライブラリ未実装
  - Mobile MCP: CLI対応あり（iOS）、MCP未公開
  - Marionette: 未実装

---

## ソースファイル参照

### Maestro MCP
- リポジトリ: https://github.com/mobile-dev-inc/maestro
- ツール実装: `maestro-cli/src/main/java/maestro/cli/mcp/tools/`
- コマンド定義: `maestro-orchestra-models/src/main/java/maestro/orchestra/Commands.kt`

### Mobile MCP
- リポジトリ: https://github.com/mobile-next/mobile-mcp
- ツール定義: `src/server.ts`
- Robotインターフェース: `src/robot.ts`

### Marionette MCP
- リポジトリ: https://github.com/anthropics/marionette-mcp
- MCPツール定義: `packages/marionette_mcp/lib/src/vm_service/vm_service_context.dart`
- ジェスチャー実装: `packages/marionette_flutter/lib/src/services/gesture_dispatcher.dart`
