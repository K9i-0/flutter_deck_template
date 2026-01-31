---
name: deploy-presentation
description: GitHub Pagesへのデプロイ支援。「デプロイ」「公開」「GitHub Pages」などで発動。
allowed-tools: Read, Bash(git:*), Bash(gh:*), Bash(flutter:*)
---

# Deploy Presentation Skill

GitHub Pagesへのデプロイを支援するスキル。

## 作業フロー

### 1. 事前確認

デプロイ前に以下を確認する：

- 現在のブランチ名（デプロイ対象）
- 未コミットの変更がないか
- `flutter analyze` でエラーがないか

### 2. ビルド確認

```bash
flutter build web --release
```

ビルドが成功することを確認。

### 3. 変更のプッシュ

未プッシュのコミットがあればプッシュする：

```bash
git push origin <branch-name>
```

### 4. GitHub Actionsワークフロー実行

```bash
gh workflow run "Deploy Slides to GitHub Pages" -f branch=<branch-name>
```

> **重要**: ワークフローは常にmainブランチから実行される。`-f branch=` でデプロイ対象ブランチを指定する。

### 5. デプロイ状況の確認

```bash
# ワークフロー実行状況を確認
gh run list --workflow="Deploy Slides to GitHub Pages" --limit 3
```

### 6. デプロイ後のURL案内

デプロイ完了後、以下のURLを案内する：

- **プレゼンURL**: `https://<owner>.github.io/<repo>/<branch-name>/`
- **一覧ページ**: `https://<owner>.github.io/<repo>/`

リポジトリ情報は `gh repo view --json owner,name` で取得できる。

## 注意事項

- 初回デプロイ前にGitHub Pagesの設定が必要（Settings → Pages → Deploy from a branch → gh-pages）
- ブランチ名のスラッシュ等はハイフンに変換される
- デプロイには数分かかるため、完了を待つ場合は `gh run watch` を使用
