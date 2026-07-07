#!/usr/bin/env bash

# Nix (https://determinate.systems/nix-installer/)
# curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
# 上記でNixをインストール後、新しいシェルを開いてから以下を実行

# home-manager（初回のみ）
nix run home-manager/master -- switch --flake ~/ghq/github.com/coyotekojote/dotfiles/nix#coyotekojote

# Homebrew（Nixにないものの補完用）
brew install --cask ghostty
brew install nodebrew

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

# Create symlinks for Claude Code
mkdir -p ~/.claude
ln -s ~/ghq/github.com/coyotekojote/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -s ~/ghq/github.com/coyotekojote/dotfiles/claude/commands ~/.claude/commands

# Claude settings: マシンごとに別ファイルを使う
# - private: claude/settings.private.json（git管理）
# - work:    claude/settings.work.json（gitignore、仕事用の情報を含むため）
# プロファイルは ~/.dotfiles-profile に "private" か "work" を書いて指定
if [ ! -f "$HOME/.dotfiles-profile" ]; then
  read -rp "This machine's profile (private/work): " profile
  echo "$profile" > "$HOME/.dotfiles-profile"
fi
PROFILE=$(cat "$HOME/.dotfiles-profile")
CLAUDE_SETTINGS=~/ghq/github.com/coyotekojote/dotfiles/claude/settings.${PROFILE}.json
if [ "$PROFILE" = "work" ] && [ ! -f "$CLAUDE_SETTINGS" ]; then
  cp ~/ghq/github.com/coyotekojote/dotfiles/claude/settings.private.json "$CLAUDE_SETTINGS"
  echo "Created $CLAUDE_SETTINGS from private template (edit for work use)"
fi
ln -sf "$CLAUDE_SETTINGS" ~/.claude/settings.json

# Create symlinks for Claude Code skills
ln -s ~/ghq/github.com/coyotekojote/dotfiles/claude/skills ~/.claude/skills

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
