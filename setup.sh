#!/usr/bin/env bash

brew install --cask ghostty
brew install nodebrew

echo "ZDOTDIR=$HOME/.config/zsh" | sudo tee /etc/zshenv > /dev/null

ln -s ~/ghq/github.com/coyotekojote/dotfiles/zsh ~/.config/
ln -s ~/ghq/github.com/coyotekojote/dotfiles/ghostty ~/.config/

# Create symlink for CLAUDE.md
mkdir -p ~/.claude
ln -s ~/ghq/github.com/coyotekojote/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
