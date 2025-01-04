#!/usr/bin/env bash

brew install --cask ghostty

sudo echo "ZDOTDIR=$HOME/.config/zsh" > /etc/zshenv

ln -s ~/ghq/github.com/coyotekojote/dotfiles/zsh ~/.config/
ln -s ~/ghq/github.com/coyotekojote/dotfiles/ghostty ~/.config/


