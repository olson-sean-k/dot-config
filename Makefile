SHELL:=/usr/bin/env bash
#.SHELLFLAGS:=-e

build:
	# Fetch and import modules.
	peru sync

install: build
	# Create symbolic links to configuration.
	ln -s -f $(realpath bashrc) ~/.bashrc
	ln -s -f $(realpath dir_colors) ~/.dir_colors
	ln -s -f $(realpath gitignore-global) ~/.gitignore-global
	ln -s -f $(realpath tmux.conf) ~/.tmux.conf
	ln -s -f $(realpath vim) ~/.vim
	ln -s -f $(realpath vimrc) ~/.vimrc
	ln -s -f $(realpath zshrc) ~/.zshrc
	mkdir -p ~/.config
	ln -s -f $(realpath starship.toml) ~/.config/starship.toml
	mkdir -p ~/.config/nvim
	ln -s -f $(realpath nvim/autoload) ~/.config/nvim/autoload
	ln -s -f $(realpath nvim/bundle) ~/.config/nvim/bundle
	ln -s -f $(realpath vimrc) ~/.config/nvim/init.vim
	# Configure tools.
	git config --global core.excludesfile ~/.gitignore-global

profile: build
	# Create symbolic links to configuration.
	ln -s -f $(realpath profile) ~/.profile
	ln -s -f $(realpath zprofile) ~/.zprofile

clean:
	peru clean
