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

状態ができたら、`computer` の screenshot アクションに `save_to_disk: true` を付けて
ビューポートをファイル保存する（返ってくるパスを控える）。

- ページ下部の余白が大きければ ffmpeg でクロップする:
  `ffmpeg -y -i in.jpg -vf "crop=W:H:0:0" out.png`（sips の crop は中央基準なので不向き）
- 撮った画像は Read で開いて、意図した状態が写っているか必ず確認する
- 複数の状態（before/after、モード別）が有効なら複数枚撮る
- 操作の流れ自体が本題なら `gif_creator` で録画GIFにしてもよい（GIFもPRに添付可能）
- ホイールズーム等を dispatch する必要があれば `javascript_tool` で
  `el.dispatchEvent(new WheelEvent('wheel', {deltaY: -100, clientX, clientY, bubbles: true, cancelable: true}))`
  （`computer` の scroll はアプリ独自の wheel ハンドラに届かないことがある）

### 3. PRに添付する

`gh` CLI は画像アップロードに対応していない。ChromeでPRページを開き、
**コメント欄のファイル入力でアップロードだけ行い、得られたURLを `gh pr edit` で本文に差し込む**のが確実:

1. PRの `https://github.com/<owner>/<repo>/pull/<n>` を開く
2. `find` で新規コメント欄の `input[type=file]`（id: `fc-new_comment_field`）の ref を取り、
   `file_upload` で画像を渡す
3. `javascript_tool` で textarea の value を読み、`Uploading...` が
   `https://github.com/user-attachments/assets/...` の `<img>` に置き換わるまで待つ
4. URLを控えたら textarea を空にして input イベントを発火（下書きを残さない）
5. `gh pr view <n> --json body` で本文を取り、「## スクリーンショット」見出し＋1行説明＋
   `<img>` を挿入して `gh pr edit <n> --body-file` で更新
6. PRページを再読み込みして画像が表示されていることを確認する

（PR本文の「⋯ → Edit」をブラウザ操作で開く方法はメニューが開かないことがあり不安定。
アップロードだけブラウザ、本文編集は gh、が堅い）

## うまくいかない時

- **claude-in-chrome が使えない**: Playwright にフォールバックする。
  `npx playwright screenshot --viewport-size=1440,900 <url> out.png`（要 `npx playwright install chromium`）。
  操作が必要な状態は小さなスクリプトで再現する
- **file_upload で input が見つからない / パスが拒否される**: 画像をセッションの
  scratchpad 配下に置いてから渡す。input はコメント欄にフォーカスした状態で探す
- **どうしても本文に入れられない**: PRへの通常コメントとして投稿する（本文編集にこだわらない）
