#!/usr/bin/env bash

brew install --cask ghostty
brew install nodebrew
brew install mise
brew install sheldon

echo "ZDOTDIR=$HOME/.config/zsh" | sudo tee /etc/zshenv > /dev/null

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

# Raycast Script Commands
mkdir -p ~/.config/raycast
ln -s ~/ghq/github.com/coyotekojote/dotfiles/raycast/script ~/.config/raycast/script
