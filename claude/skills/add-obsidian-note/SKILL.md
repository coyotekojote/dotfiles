---
name: add-obsidian-note
description: >
  Save notes and insights to Obsidian vault during work.
  Use when the user says "save this", "note this", "remember this",
  "メモしておいて", "記録して", "ノートに残して", or wants to capture learnings.
argument-hint: "[title] or [title: content]"
allowed-tools: Write, Read, Glob
---

# Obsidian Vault メモ追加

作業中に見つけた知見やメモをObsidian vaultのinboxフォルダに保存します。

## 保存先

`~/ghq/github.com/coyotekojote/obsidian-vault/inbox/`

## 手順

1. **引数を解析**
   - `$ARGUMENTS` が `タイトル: 内容` の形式なら分割
   - それ以外なら全体をタイトルとして扱い、会話の文脈から内容を生成

2. **ファイル名を生成**
   - フォーマット: `YYYYMMDD_HHmmss_<タイトル>.md`
   - タイトルからファイル名に使えない文字を除去
   - 例: `20260124_143052_Reactのカスタムフック.md`

3. **現在時刻を取得**
   - `date` コマンドで現在時刻を取得

4. **メモファイルを作成**
   以下のテンプレートを使用:

   ```markdown
   ---
   created: YYYY-MM-DD HH:mm
   source: claude-code
   ---

   # タイトル

   内容

   #claudeメモ
   ```

   **タグについて:**
   - タグはYAML frontmatterではなく、ドキュメント末尾にインラインタグ（`#タグ名`）を記載
   - `#claudeメモ` は必ず含める
   - 内容に応じて適切なタグを追加（例: `#レシピ` `#作りたい` `#TIL` など）

5. **保存先に書き込み**
   - Write ツールを使って `~/ghq/github.com/coyotekojote/obsidian-vault/inbox/` に保存

6. **完了を報告**
   - 保存したファイルパスを表示
   - 内容のサマリーを表示

## 注意事項

- タイトルが空の場合は、会話の文脈から適切なタイトルを生成する
- 内容が指定されていない場合は、直前の会話から関連する情報を抽出してメモを作成する
- 日本語のタイトルはそのまま使用可能
