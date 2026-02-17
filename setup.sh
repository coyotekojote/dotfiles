#!/usr/bin/env bash

brew install --cask ghostty
brew install nodebrew
brew install mise
brew install sheldon

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
ln -s ~/ghq/github.com/coyotekojote/dotfiles/claude/settings.json ~/.claude/settings.json

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
