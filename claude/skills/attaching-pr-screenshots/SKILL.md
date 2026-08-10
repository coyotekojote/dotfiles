---
name: attaching-pr-screenshots
description: UI・画面の変更を含むPRに、実際の画面スクリーンショットを撮って添付する。アプリを起動→Chrome自動操作で変更後の状態を再現→スクショをファイル保存→GitHubのPRページで画像アップロード、まで行う。「PRにスクショを貼って」「画面の変更をPRで見せたい」、または画面に見える変更を含むPRを作成する時に使用。
---

# PRへの画面スクリーンショット添付

画面に見える変更を含むPRでは、変更後のスクリーンショットを撮ってPR本文に添付する。
リポジトリに画像はコミットしない（GitHubのアップロード機能で user-images にホストさせる）。

## ワークフロー

### 1. アプリを起動する

プロジェクトの起動方法（`npm run dev` 等）でアプリをバックグラウンド起動し、URLを控える。
起動方法はプロジェクトのスキル・README・package.json から判断する。

### 2. 変更後の状態を再現してスクショを撮る

claude-in-chrome でアプリを開き、**変更が伝わる状態**まで操作する
（新機能ならそれを有効にした状態。デフォルト表示と変わらない画面は撮らない）。

状態ができたら、Chromeウィンドウをファイルに保存する:

```bash
# 対象タブを最前面にしてから実行。ウィンドウ単位のキャプチャ（-o で影なし）
osascript -e 'tell application "Google Chrome" to activate'
screencapture -o -x -l "$(osascript -e 'tell application "Google Chrome" to id of window 1')" <scratchpad>/pr-screenshot.png
```

- 保存先はセッションのscratchpadディレクトリ（リポジトリ内に置かない）
- 撮った画像は Read で開いて、意図した状態が写っているか必ず確認する
- 複数の状態（before/after、モード別）が有効なら複数枚撮る
- 操作の流れ自体が本題なら `gif_creator` で録画GIFにしてもよい（GIFもPRに添付可能）

### 3. PRに添付する

`gh` CLI は画像アップロードに対応していないので、ChromeでPRページを開いて添付する:

1. PRの `https://github.com/<owner>/<repo>/pull/<n>` を開く
2. PR本文の「⋯」メニュー → Edit で編集モードにする
3. `file_upload` ツールで textarea 付近の `input[type=file]` にPNGを渡す
   （アップロード完了までmarkdownが `Uploading...` になるので、URLに置き換わるのを待つ）
4. 画像markdownの前に「## スクリーンショット」等の見出しと1行説明を添えて Update comment
5. 保存後、画像が表示されていることをスクロールして確認する

## うまくいかない時

- **screencapture が黒画像/権限エラー**: ターミナルに画面収録権限がない。
  ユーザーに「システム設定 → プライバシーとセキュリティ → 画面収録」での許可を依頼する
- **claude-in-chrome が使えない**: Playwright にフォールバックする。
  `npx playwright screenshot --viewport-size=1440,900 <url> out.png`（要 `npx playwright install chromium`）。
  操作が必要な状態は小さなスクリプトで再現する
- **file_upload で input が見つからない**: コメント欄にフォーカスした状態で探す。
  それでも駄目なら、PRへの通常コメントとして添付する（本文編集にこだわらない）
