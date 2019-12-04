#! /usr/bin/env bash

set -e

cd $(dirname "$BASH_SOURCE")
repo_dir=`pwd`

# TODO: How should errors be handled? Bailing if a file already exists may be
#       too heavy handed.
# TODO: This does not link the following configuration, because it has been
#       sparingly used and/or may be removed:
#
#       - `fish`
#       - `profile`
#       - `ssh`
#       - `Xmodmap`

cd ~
ln -s "$repo_dir"/bashrc .bashrc
ln -s "$repo_dir"/dir_colors .dir_colors
ln -s "$repo_dir"/tmux.conf .tmux.conf
ln -s "$repo_dir"/vimrc .vimrc
ln -s "$repo_dir"/zshrc .zshrc

mkdir -p ~/.config
cd ~/.config
ln -s "$repo_dir"/starship.toml starship.toml

mkdir -p ~/.config/nvim
cd ~/.config/nvim
ln -s "$repo_dir"/nvim/autoload autoload
ln -s "$repo_dir"/nvim/bundle bundle
ln -s "$repo_dir"/vimrc init.vim
