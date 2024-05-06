SHELL:=/usr/bin/env bash

.PHONY: build clean install

build:
	# Fetch and import modules.
	peru sync

install: build
	# Link and copy configuration.
	ln -s -f $(realpath dir_colors) ~/.dir_colors
	ln -s -f $(realpath gitignore-global) ~/.gitignore-global
	ln -s -f $(realpath tmux.conf) ~/.tmux.conf
	ln -s -f $(realpath zprofile) ~/.zprofile
	cp --update=none $(realpath zprofile-local) ~/.zprofile-local
	ln -s -f $(realpath zprompt) ~/.zprompt
	ln -s -f $(realpath zshenv) ~/.zshenv
	cp --update=none $(realpath zshenv-local) ~/.zshenv-local
	ln -s -f $(realpath zshrc) ~/.zshrc
	cp --update=none $(realpath zshrc-local) ~/.zshrc-local
	mkdir -p ~/.config
	ln -s -f $(realpath starship.toml) ~/.config/starship.toml
	mkdir -p ~/.config/nvim
	ln -s -f $(realpath nvim/autoload) ~/.config/nvim/autoload
	ln -s -f $(realpath nvim/bundle) ~/.config/nvim/bundle
	ln -s -f $(realpath coc-settings.json) ~/.config/nvim/coc-settings.json
	ln -s -f $(realpath init.vim) ~/.config/nvim/init.vim
	# Configure tools.
	git config --global core.excludesfile ~/.gitignore-global

clean:
	peru clean
