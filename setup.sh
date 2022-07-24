#!/usr/bin/env bash


# シンボリックリンクを貼る
ln -s ~/ghq/github.com/coyotekojote/dotfiles/config/starship.toml ~/.config/starship.toml
ln -s ~/ghq/github.com/coyotekojote/dotfiles/config/fish/ ~/.config/
ln -s ~/ghq/github.com/coyotekojote/dotfiles/config/brew/Brewfile ~/.Brewfile

# brewのパッケージインストール
brew bundle --global

# fish設定
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)

# fisherインストール
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
