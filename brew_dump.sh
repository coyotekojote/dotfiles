#!/usr/bin/env bash

cd ./config/brew/
rm ./Brewfile
brew bundle dump 
