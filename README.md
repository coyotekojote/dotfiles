# dotfiles

- どの環境でも共通で使いたいものの設定をまとめるためのリポジトリ


## 管理対象

### terminal

- [ghostty](https://ghostty.org/)


### shell

- zsh
- 端末固有の設定等、git管理したくない項目がある場合には `/zsh/.zshrc.local` を作成してその中に記載する
- `Control + ]` でghq配下のリポジトリを検索できる

## 使い方

### 初期設定時 

- [Homebrew](https://brew.sh/ja/)をインストール
- このリポジトリをローカルにclone(ghqを使用する想定)
- `bash setup.sh` を実行
