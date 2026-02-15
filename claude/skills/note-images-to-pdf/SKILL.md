---
name: note-images-to-pdf
description: ObsidianノートのスクリーンショットをPDF化。ノート内の画像URLをダウンロードし、表紙PDFと結合して1つのPDFにまとめる。Use when the user says "PDF化して", "PDFにまとめて", "スクショをPDFに", "ノートをPDFに", or wants to convert note images to PDF.
---

# ObsidianノートのスクリーンショットPDF化

## ワークフロー

1. **対象ノートを特定**: ユーザーが指定したObsidianノート(.md)を読み取る
2. **画像URLを抽出**: `![image](URL)` パターンからURLリストを取得
3. **表紙PDFの確認**: ユーザーが表紙PDFを指定した場合、存在を確認
4. **Pythonスクリプトを生成・実行**: `/tmp` に一時スクリプトを生成し `uv run` で実行
5. **出力先**: `~/Downloads/` に保存（ファイル名はユーザーと相談）

## 実行方法

依存ライブラリは `uv run --with` で一時インストールする（venv不要）:

```bash
uv run --with Pillow --with pypdf --with requests /tmp/generated_script.py
```

## スクリプト生成テンプレート

生成するPythonスクリプトは [script_template.py](script_template.py) を参考に作成する。

主要なポイント:
- **ページの向き自動調整**: 横長画像→A4横、縦長画像→A4縦
- **画像を全面表示**: マージン最小(10px)で画像を最大限大きく配置
- **RGBA対応**: 透過PNGは白背景に合成
- **表紙PDF**: pypdfで先頭ページとして結合（表紙が複数ページの場合は全ページ含む）

## ユーザーに確認すべきこと

- 表紙PDFの有無とパス
- 出力ファイル名
- 特定のセクションだけ抽出するか、全画像を対象にするか
