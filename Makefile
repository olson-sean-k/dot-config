SHELL:=/usr/bin/env bash

.PHONY: build
build:
	# Fetch and import modules.
	peru sync

# TODO: Is there a way to remove duplication here?
active:
	mkdir -p active
	touch active/dir_colors
	touch active/colors.vim
	touch active/zshrc-colors

.PHONY: active-null
active-null: active
	rm -f active/dir_colors
	touch active/dir_colors
	rm -f active/colors.vim
	touch active/colors.vim
	rm -f active/zshrc-colors
	touch active/zshrc-colors

.PHONY: active-colors-catppuccin
active-colors-catppuccin: active-null
	ln -s -f -T ../colors/catppuccin/colors.vim active/colors.vim
	ln -s -f -T ../colors/catppuccin/zshrc-colors active/zshrc-colors

.PHONY: active-colors-nord
active-colors-nord: active-null
	ln -s -f -T ../colors/nord/dir_colors active/dir_colors
	ln -s -f -T ../colors/nord/colors.vim active/colors.vim
	ln -s -f -T ../colors/nord/zshrc-colors active/zshrc-colors

.PHONY: active-colors-solarized
active-colors-solarized: active-null
	ln -s -f -T ../colors/solarized/dir_colors active/dir_colors
	ln -s -f -T ../colors/solarized/colors.vim active/colors.vim
	ln -s -f -T ../colors/solarized/zshrc-colors active/zshrc-colors

.PHONY: install-directory
install-directory:
	mkdir -p ~/.config
	mkdir -p ~/.config/bat
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
	# bat.
	ln -s -f -T $(realpath bat/config) ~/.config/bat/config
	ln -s -f -T $(realpath bat/themes) ~/.config/bat/themes
	# Terminal colors.
	ln -s -f -T $(realpath active)/dir_colors ~/.dir_colors
	# Git.
	ln -s -f -T $(realpath gitignore-global) ~/.gitignore-global
	# Neovim.
	ln -s -f -T $(realpath nvim/autoload) ~/.config/nvim/autoload
	ln -s -f -T $(realpath nvim/bundle) ~/.config/nvim/bundle
	ln -s -f -T $(realpath nvim/coc-settings.json) ~/.config/nvim/coc-settings.json
	ln -s -f -T $(realpath nvim/init.vim) ~/.config/nvim/init.vim
	ln -s -f -T $(realpath active)/colors.vim ~/.config/nvim/colors.vim
	# Starship.
	ln -s -f -T $(realpath starship.toml) ~/.config/starship.toml
	# tmux.
	ln -s -f -T $(realpath tmux.conf) ~/.tmux.conf
	# Z shell.
	ln -s -f -T $(realpath active)/zshrc-colors ~/.zshrc-colors
	ln -s -f -T $(realpath zsh/zprofile) ~/.zprofile
	ln -s -f -T $(realpath zsh/zprompt) ~/.zprompt
	ln -s -f -T $(realpath zsh/zshenv) ~/.zshenv
	ln -s -f -T $(realpath zsh/zshrc) ~/.zshrc
	# Configure tools.
	bat cache --build
	git config --global core.excludesfile ~/.gitignore-global

.PHONY: clean
clean:
	peru clean
	rm -rf active
