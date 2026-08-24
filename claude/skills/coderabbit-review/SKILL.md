---
name: coderabbit-review
description: CodeRabbit CLIでコードレビューを実行し、指摘一覧を表示して対応方針をユーザーに確認する。Use when the user says "coderabbitでレビュー", "CRレビュー", "コードレビューして", "coderabbit review", or wants AI-powered code review.
---

# CodeRabbit Review

CodeRabbit CLIを使ってコードレビューを実行し、指摘事項ごとにユーザーと対応方針を決めるskill。

## 前提条件

- `coderabbit` CLIがインストール済みであること
- `coderabbit auth login` で認証済みであること

未インストールの場合はユーザーに案内:
```
curl -fsSL https://cli.coderabbit.ai/install.sh | sh
coderabbit auth login
```

## ワークフロー

### 1. レビュー実行

```bash
coderabbit review --prompt-only --no-color --base <ベースブランチ> 2>&1
```

- ベースブランチはデフォルトで `main`
- `$ARGUMENTS` でブランチ指定があればそれを使用
- 「No findings」の場合は「指摘なし」と報告して終了

### 2. 指摘一覧の表示

全指摘のサマリーテーブルを表示:

```markdown
## CodeRabbit レビュー結果: N件の指摘

| # | ファイル | 行 | タイプ | 概要 |
|---|---------|-----|--------|------|
| 1 | path/to/file.rb | 29-49 | potential_issue | APIレスポンスの検証が必要 |
| 2 | ... | ... | ... | ... |
```

### 3. 各指摘への対応方針確認

指摘ごとにAskUserQuestionで対応方針を確認する。

**表示内容:** ファイル名・行番号・指摘内容・修正案（ある場合）

**選択肢:**
- **修正する**: 修正案を適用、または自分で修正を実装
- **スキップ**: この指摘は対応しない
- **後で対応**: TODOコメントを残す

### 4. 修正の実行

「修正する」が選択された指摘について:
1. 該当ファイルの該当箇所をReadで確認
2. 指摘内容に基づいてEditで修正を適用
3. 修正後、簡潔に変更内容を報告

### 5. 完了報告

全指摘の処理後、対応結果サマリーを表示:

```markdown
## 対応結果

| # | ファイル | 対応 |
|---|---------|------|
| 1 | path/to/file.rb:29 | 修正済み |
| 2 | path/to/other.rb:10 | スキップ |
| 3 | path/to/another.rb:5 | TODO追加 |
```
