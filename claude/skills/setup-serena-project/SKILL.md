---
name: setup-serena-project
description: >
  プロジェクトにSerena MCPをセットアップ。
  Use when the user says "serenaセットアップ", "serena設定して",
  "setup serena", or wants to initialize Serena for a project.
allowed-tools: Bash, Write, Read, Glob
---

# Serena MCP プロジェクトセットアップ

カレントディレクトリのプロジェクトにSerena MCPの設定ファイルを作成する。
グローバルインストール（`claude mcp add --scope user serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context claude-code`）は手動で済んでいる前提。

## 手順

1. **カレントディレクトリの確認**
   - `.git` が存在するか確認し、プロジェクトルートであることを判定
   - `.git` がなければ「Gitリポジトリのルートで実行してください」と報告して終了
   - 既に `.serena/project.yml` が存在する場合は「既にセットアップ済みです」と報告して終了

2. **プロジェクトの言語を検出**
   - ファイル拡張子やマーカーファイルから判定:
     - `Gemfile` / `*.rb` → ruby
     - `package.json` / `*.ts` / `*.tsx` → typescript
     - `pyproject.toml` / `requirements.txt` / `*.py` → python
     - `go.mod` → go
     - `Cargo.toml` → rust
     - `*.java` / `pom.xml` / `build.gradle` → java
     - `*.swift` / `Package.swift` → swift
   - 複数の言語が検出された場合はすべてリストに含める
   - 検出結果をユーザーに確認してから次に進む

3. **`.serena/project.yml` を作成**
   - `.serena` ディレクトリを作成
   - 以下のテンプレートで `project.yml` を作成:
     ```yaml
     project_name: <カレントディレクトリ名>
     languages:
       - <検出した言語>
     read_only: false
     ```

4. **`.gitignore` を更新**
   - `.gitignore` が存在しなければ新規作成
   - `.serena/memories/` が既に記載されていればスキップ
   - 記載がなければ `.serena/memories/` を追加
   - `.serena/project.yml` はコミット対象のままにする（追加しない）

5. **完了を報告**
   - 作成したファイルのパスを表示
   - `.gitignore` の変更有無を表示
   - 検出した言語を表示
