# dotfiles

- どの環境でも共通で使いたいものの設定をまとめるためのリポジトリ


## 管理対象

### terminal

- [ghostty](https://ghostty.org/)


### shell

- zsh
- プラグイン管理には[sheldon](https://github.com/rossmacarthur/sheldon)を使用
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) — 入力中に履歴ベースの候補をグレー表示
  - [zsh-completions](https://github.com/zsh-users/zsh-completions) — 追加のTab補完定義
- 端末固有の設定等、git管理したくない項目がある場合には `/zsh/.zshrc.local` を作成してその中に記載する
- `Control + ]` でghq配下のリポジトリを検索できる

### git

- グローバルの`.gitconfig`を管理
- ghqはSSHをデフォルトで使用（`url.insteadOf`設定）
- 端末固有の設定等、git管理したくない項目がある場合には `~/.gitconfig-local` を作成してその中に記載する
  - 例: 特定ディレクトリでは別のgitconfigを読み込みたい場合
    ```gitconfig
    [includeIf "gitdir:~/ghq/github.com/your-org/"]
      path = ~/.gitconfig-work
    ```

## 使い方

### 初期設定時 

- [Homebrew](https://brew.sh/ja/)をインストール
- このリポジトリをローカルにclone(ghqを使用する想定)
- `bash setup.sh` を実行
