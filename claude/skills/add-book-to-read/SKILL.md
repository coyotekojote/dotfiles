---
name: add-book-to-read
description: >
  読みたい本をObsidianに記録。
  Use when the user says "この本読みたい", "読みたい本メモして", "本をメモ",
  "読みたい", "book", or wants to save a book to read later.
argument-hint: "[著者『タイトル』] or [タイトル]"
allowed-tools: Write, Read, Glob
---

# 読みたい本メモ

読みたい本の情報をObsidian vaultのinboxフォルダに保存します。

## 保存先

`/Users/coyotekojote/ghq/github.com/coyotekojote/obsidian-vault/inbox/`

## 手順

1. **引数を解析**
   - `$ARGUMENTS` から書籍情報を解析する
   - タイトル（必須）、著者、翻訳者、出版社、出版年を抽出
   - 不足している情報があればユーザーに確認する

2. **ファイル名を生成**
   - フォーマット: `YYYYMMDD_HHmmss_<タイトル>.md`
   - タイトルからファイル名に使えない文字を除去
   - 例: `20260128_143052_リーダブルコード.md`

3. **現在時刻を取得**
   - `date` コマンドで現在時刻を取得

4. **メモファイルを作成**
   以下のテンプレートを使用:

   ```markdown
   ---
   created: YYYY-MM-DD HH:mm
   source: claude-code
   tags:
     - 読みたい本
   ---

   # タイトル

   ## 概要
   著者『タイトル』翻訳者名 訳, 出版社, 出版年

   ## 関連
   -
   ```

   - `## 概要` には判明している情報のみ記載する
   - 著者のみの場合: `著者『タイトル』`
   - 全情報ありの場合: `著者『タイトル』翻訳者名 訳, 出版社, 出版年`
   - タイトルのみの場合: `『タイトル』`

5. **保存先に書き込み**
   - Write ツールを使って保存

6. **完了を報告**
   - 保存したファイルパスを表示
   - 記録した書籍情報のサマリーを表示
