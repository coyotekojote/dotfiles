#!/usr/bin/env bash

brew install --cask ghostty


mkdir -p ~/etc/ && echo "ZDOTDIR=$HOME/.config/zsh" > ~/etc/zshenv


ln -s ~/ghq/github.com/coyotekojote/dotfiles/ghostty ~/.config/
