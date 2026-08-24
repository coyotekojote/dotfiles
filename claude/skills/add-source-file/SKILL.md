---
name: add-source-file
description: >
  書籍の書誌情報をObsidian vaultのsource_fileに追加。
  Use when the user says "source_fileに追加", "書誌情報追加", "source file追加",
  "本を登録", "add source file", or wants to add bibliographic info to source_file.
argument-hint: "[URL] or [著者『タイトル』出版社、年]"
allowed-tools: Write, Read, Glob, WebFetch
---

# Source File 書誌情報追加

書籍の書誌情報をObsidian vaultの `01_Source_File` に保存します。

## 保存先

`~/ghq/github.com/coyotekojote/obsidian-vault/01_Source_File/`

## 手順

1. **引数を解析**
   - `$ARGUMENTS` がURLの場合、WebFetchで書誌情報を取得する
   - テキストの場合、著者・タイトル・訳者・出版社・出版年・ISBNを抽出する
   - 不足している情報があればユーザーに確認する（タイトルは必須）

2. **重複チェック**
   - Globで `01_Source_File/` 内に同名・類似ファイルがないか確認する

3. **ファイル名を生成**
   - フォーマット: `<書籍タイトル>.md`
   - タイトルからファイル名に使えない文字（`/`, `\`, `:`, `*`, `?`, `"`, `<`, `>`, `|`）を除去
   - 副題がある場合はダッシュで区切る（例: `Aligned――プロダクト開発における…` → `Aligned.md` のように主題のみ使用）

4. **メモファイルを作成**
   以下のテンプレートを厳密に使用:

   ```markdown
   ---
   created: YYYY-MM-DD
   ---
   # 書誌情報
   著者『タイトル』訳者訳、出版社、出版年
   ISBN XXX-X-XXXX-XXXX-X

   ```

   - frontmatterには `created` のみ記載する。tagsは入れない
   - `# 書誌情報` の下に1行で書誌情報を記載する
   - ISBNがある場合は次の行に記載する
   - 書誌情報の後は空行1つで終わる
   - メモ欄やテンプレートの見出しは作らない

5. **書誌情報の記載ルール**
   - 著者が複数の場合はカンマ区切り: `著者A、著者B`
   - 訳書の場合: `著者『タイトル』訳者訳、出版社、出版年`
   - 日本語著者の場合: `著者『タイトル』出版社、出版年`
   - 出版年は西暦の「年」まで記載（例: `2026年`）

6. **保存先に書き込み**
   - Write ツールを使って保存

7. **完了を報告**
   - 保存したファイルパスを表示
   - 記録した書誌情報のサマリーを表示
