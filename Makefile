SHELL:=/usr/bin/env bash

.PHONY: build
build:
	# Fetch and import modules.
	peru sync

# NOTE: This target, unlike most others, is not phony.
active:
	mkdir -p active
	ln -s -f colors/solarized/dir_colors active/dir_colors
	ln -s -f colors/solarized/colors.vim active/colors.vim

.PHONY: active-colors-nord
active-colors-nord: active
	ln -s -f colors/nord/dir_colors active/dir_colors
	ln -s -f colors/nord/colors.vim active/colors.vim

.PHONY: active-colors-solarized
active-colors-solarized: active
	ln -s -f colors/solarized/dir_colors active/dir_colors
	ln -s -f colors/solarized/colors.vim active/colors.vim

.PHONY: install-directory
install-directory:
	mkdir -p ~/.config
	mkdir -p ~/.config/nvim

.PHONY: install-local
install-local: install-directory
	# Copy configuration.
	cp --update=none $(realpath zsh/zprofile-local) ~/.zprofile-local
	cp --update=none $(realpath zsh/zshenv-local) ~/.zshenv-local
	cp --update=none $(realpath zsh/zshrc-local) ~/.zshrc-local

.PHONY: install
install: active build install-directory install-local
	# Link configuration.
	# Terminal colors.
	ln -s -f $(realpath active/dir_colors) ~/.dir_colors
	# Git.
	ln -s -f $(realpath gitignore-global) ~/.gitignore-global
	# tmux.
	ln -s -f $(realpath tmux.conf) ~/.tmux.conf
	# Z shell.
	ln -s -f $(realpath zsh/zprofile) ~/.zprofile
	ln -s -f $(realpath zsh/zprompt) ~/.zprompt
	ln -s -f $(realpath zsh/zshenv) ~/.zshenv
	ln -s -f $(realpath zsh/zshrc) ~/.zshrc
	# Starship.
	ln -s -f $(realpath starship.toml) ~/.config/starship.toml
	# Neovim.
	ln -s -f $(realpath nvim/autoload) ~/.config/nvim/autoload
	ln -s -f $(realpath nvim/bundle) ~/.config/nvim/bundle
	ln -s -f $(realpath nvim/coc-settings.json) ~/.config/nvim/coc-settings.json
	ln -s -f $(realpath nvim/init.vim) ~/.config/nvim/init.vim
	ln -s -f $(realpath active/colors.vim) ~/.config/nvim/colors.vim
	# Configure tools.
	git config --global core.excludesfile ~/.gitignore-global

.PHONY: clean
clean:
	peru clean
