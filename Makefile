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
	ln -s -f $(realpath zsh/zprofile) ~/.zprofile
	cp --update=none $(realpath zsh/zprofile-local) ~/.zprofile-local
	ln -s -f $(realpath zsh/zprompt) ~/.zprompt
	ln -s -f $(realpath zsh/zshenv) ~/.zshenv
	cp --update=none $(realpath zsh/zshenv-local) ~/.zshenv-local
	ln -s -f $(realpath zsh/zshrc) ~/.zshrc
	cp --update=none $(realpath zsh/zshrc-local) ~/.zshrc-local
	mkdir -p ~/.config
	ln -s -f $(realpath starship.toml) ~/.config/starship.toml
	mkdir -p ~/.config/nvim
	ln -s -f $(realpath nvim/autoload) ~/.config/nvim/autoload
	ln -s -f $(realpath nvim/bundle) ~/.config/nvim/bundle
	ln -s -f $(realpath nvim/coc-settings.json) ~/.config/nvim/coc-settings.json
	ln -s -f $(realpath nvim/init.vim) ~/.config/nvim/init.vim
	# Configure tools.
	git config --global core.excludesfile ~/.gitignore-global

clean:
	peru clean
