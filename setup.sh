#!/usr/bin/env bash

brew install --cask ghostty

echo "ZDOTDIR=$HOME/.config/zsh" | sudo tee /etc/zshenv > /dev/null

ln -s ~/ghq/github.com/coyotekojote/dotfiles/zsh ~/.config/
ln -s ~/ghq/github.com/coyotekojote/dotfiles/ghostty ~/.config/


