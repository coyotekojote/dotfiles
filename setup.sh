#!/usr/bin/env bash

# Nix (https://determinate.systems/nix-installer/)
# curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
# 上記でNixをインストール後、新しいシェルを開いてから以下を実行

# home-manager（初回のみ）
# --impure: home.nixがユーザー名/ホームを環境変数から取得するため必須
nix run home-manager/master -- switch --flake ~/ghq/github.com/coyotekojote/dotfiles/nix#coyotekojote --impure

# Homebrew（Nixにないものの補完用）
brew install --cask ghostty
brew install --cask stablyai/orca/orca  # AIエージェントを並列worktreeで走らせるADE
brew install nodebrew

# ax — AI時代のcurl（https://github.com/yusukebe/ax）
# NixにもHomebrewにも無いため公式インストーラで~/.local/binに導入
curl -fsSL https://ax.yusuke.run/install | sh

cat << 'ZSHENV' | sudo tee /etc/zshenv > /dev/null
# Ghostty shell integrationとの競合回避
# Ghosttyはzsh起動前にZDOTDIRを自身のintegrationディレクトリに一時設定し、
# GHOSTTY_ZSH_ZDOTDIRに保存された値でZDOTDIRを復元する。
# /etc/zshenvで無条件にZDOTDIRを上書きするとintegrationが読み込まれないため、
# Ghostty環境ではGHOSTTY_ZSH_ZDOTDIRに正しいパスを設定してintegration側に復元を委ねる。
if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
    export GHOSTTY_ZSH_ZDOTDIR="$HOME/.config/zsh"
else
    export ZDOTDIR="$HOME/.config/zsh"
fi
ZSHENV

ln -s ~/ghq/github.com/coyotekojote/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/ghq/github.com/coyotekojote/dotfiles/zsh ~/.config/
ln -s ~/ghq/github.com/coyotekojote/dotfiles/ghostty ~/.config/
ln -s ~/ghq/github.com/coyotekojote/dotfiles/mise ~/.config/
ln -s ~/ghq/github.com/coyotekojote/dotfiles/sheldon ~/.config/
ln -s ~/ghq/github.com/coyotekojote/dotfiles/nvim ~/.config/

# hunk: 同ディレクトリにhunk自身が書くstate.jsonがあるため、ディレクトリごとではなくconfig.tomlのみリンク
mkdir -p ~/.config/hunk
ln -sfn ~/ghq/github.com/coyotekojote/dotfiles/hunk/config.toml ~/.config/hunk/config.toml

# Create symlinks for Claude Code
mkdir -p ~/.claude
ln -s ~/ghq/github.com/coyotekojote/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -s ~/ghq/github.com/coyotekojote/dotfiles/claude/commands ~/.claude/commands

# Claude settings: マシンごとに別ファイルを使う
# - private: claude/settings.private.json（このリポジトリ）
# - work:    dotfiles-private側のclaude/settings.work.json（仕事用の情報を含むため非公開リポジトリで管理）
# プロファイルは ~/.dotfiles-profile に "private" か "work" を書いて指定
if [ ! -f "$HOME/.dotfiles-profile" ]; then
  read -rp "This machine's profile (private/work): " profile
  echo "$profile" > "$HOME/.dotfiles-profile"
fi
PROFILE=$(cat "$HOME/.dotfiles-profile")
PRIVATE_REPO=~/ghq/github.com/coyotekojote/dotfiles-private
if [ "$PROFILE" = "work" ]; then
  CLAUDE_SETTINGS="$PRIVATE_REPO/claude/settings.work.json"
  if [ ! -f "$CLAUDE_SETTINGS" ]; then
    mkdir -p "$PRIVATE_REPO/claude"
    cp ~/ghq/github.com/coyotekojote/dotfiles/claude/settings.private.json "$CLAUDE_SETTINGS"
    echo "Created $CLAUDE_SETTINGS from private template (edit for work use)"
  fi
else
  CLAUDE_SETTINGS=~/ghq/github.com/coyotekojote/dotfiles/claude/settings.private.json
fi
ln -sf "$CLAUDE_SETTINGS" ~/.claude/settings.json

# Claude Code skills: 公開・非公開リポジトリ両方からスキルごとに個別リンク
mkdir -p ~/.claude/skills
for skill in ~/ghq/github.com/coyotekojote/dotfiles/claude/skills/*/; do
  ln -sfn "$skill" ~/.claude/skills/"$(basename "$skill")"
done

# Private dotfiles overlay (https://github.com/coyotekojote/dotfiles-private)
if [ -d "$PRIVATE_REPO/claude/skills" ]; then
  for skill in "$PRIVATE_REPO"/claude/skills/*/; do
    [ -d "$skill" ] && ln -sfn "$skill" ~/.claude/skills/"$(basename "$skill")"
  done
fi

# herdr: work用のヘルパースクリプト(private側で管理)をリンク
# ~/.config/herdr にはherdr自身が書くsocket/log/state類があるため、ディレクトリごとではなくファイル単位
if [ "$PROFILE" = "work" ] && [ -d "$PRIVATE_REPO/herdr" ]; then
  mkdir -p ~/.config/herdr
  for helper in "$PRIVATE_REPO"/herdr/*; do
    [ -f "$helper" ] && ln -sfn "$helper" ~/.config/herdr/"$(basename "$helper")"
  done
fi

# Create ~/.claude/settings.local.json if not exists (machine-local, not git-managed)
if [ ! -f "$HOME/.claude/settings.local.json" ]; then
  cat > "$HOME/.claude/settings.local.json" <<'EOF'
{
  "model": "sonnet"
}
EOF
  echo "Created ~/.claude/settings.local.json (machine-local settings)"
fi

# Raycast Script Commands
mkdir -p ~/.config/raycast
ln -s ~/ghq/github.com/coyotekojote/dotfiles/raycast/script ~/.config/raycast/script
