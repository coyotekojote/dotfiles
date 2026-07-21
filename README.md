# dotfiles

## 管理対象

### パッケージ管理

- [Nix](https://nixos.org/) + [home-manager](https://github.com/nix-community/home-manager) — パッケージ管理のメイン
  - 設定は `nix/home.nix` で管理
    - ユーザー名/ホームディレクトリは環境変数（`USER`/`HOME`）から取得するため、複数マシンで同じ設定を使い回せる
  - パッケージ追加後は `home-manager switch --flake ~/ghq/github.com/coyotekojote/dotfiles/nix#coyotekojote --impure` を実行
    - `--impure` は `home.nix` が環境変数を参照するため必須
  - `nix flake update` でパッケージ更新
- [Homebrew](https://brew.sh/ja/) — Nixにないもの（GUIアプリ等）の補完用
- [mise](https://mise.jdx.dev/) — Ruby等ランタイムのバージョン管理

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

### Claude Code

- 設定はマシンプロファイル（`~/.dotfiles-profile` の `private` / `work`）で切り替え
  - private: このリポジトリの `claude/settings.private.json`
  - work: [dotfiles-private](https://github.com/coyotekojote/dotfiles-private)（非公開）の `claude/settings.work.json`
- 非公開のスキル等は dotfiles-private を隣にcloneしておくと `setup.sh` が重ねてリンクする

## 使い方

### 初期設定時

1. [Nix](https://determinate.systems/nix-installer/) をインストール
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```
2. [Homebrew](https://brew.sh/ja/) をインストール
3. このリポジトリをローカルにclone（ghqを使用する想定）
   - 非公開設定を使う場合は [dotfiles-private](https://github.com/coyotekojote/dotfiles-private) も同じ階層にclone
4. `bash setup.sh` を実行
