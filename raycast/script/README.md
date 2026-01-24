# Raycast Script Commands

このディレクトリには Raycast の Script Commands を格納する。

## セットアップ

### 1. シンボリックリンクの作成

`setup.sh` を実行するか、手動で以下を実行:

```bash
mkdir -p ~/raycast
ln -s ~/ghq/github.com/coyotekojote/dotfiles/raycast/script ~/raycast/script
```

### 2. Raycast への登録

1. Raycast を開く（`⌘ + Space`）
2. 「Extensions」と入力して「Raycast Settings」→「Extensions」を開く
3. 左下の `+` ボタン → `Add Script Directory`
4. `~/raycast/script` を選択

### 3. 確認

Raycast で各スクリプトのタイトル（例: `Screen OCR`）を入力して表示されれば完了。

## スクリプト一覧

| ファイル | 説明 |
|---------|------|
| `screen-ocr.sh` | 画面の選択領域からテキストを抽出してクリップボードにコピー |
