SHELL:=/usr/bin/env bash

.PHONY: build clean install

build:
	# Copy tracked configuration to the build directory.
	mkdir -p out
	touch out/dir_colors
	cp -f gitignore-global out
	cp -f starship.toml out
	cp -f tmux.conf out
	cp -R -f nvim out
	cp -R -f ssh out
	cp -R -f zsh out
	# Fetch and import modules.
	peru sync

install: build
	# Link and copy configuration.
	ln -s -f $(realpath out/dir_colors) ~/.dir_colors
	ln -s -f $(realpath out/gitignore-global) ~/.gitignore-global
	ln -s -f $(realpath out/tmux.conf) ~/.tmux.conf
	ln -s -f $(realpath out/zsh/zprofile) ~/.zprofile
	cp --update=none $(realpath out/zsh/zprofile-local) ~/.zprofile-local
	ln -s -f $(realpath out/zsh/zprompt) ~/.zprompt
	ln -s -f $(realpath out/zsh/zshenv) ~/.zshenv
	cp --update=none $(realpath out/zsh/zshenv-local) ~/.zshenv-local
	ln -s -f $(realpath out/zsh/zshrc) ~/.zshrc
	cp --update=none $(realpath out/zsh/zshrc-local) ~/.zshrc-local
	mkdir -p ~/.config
	ln -s -f $(realpath out/starship.toml) ~/.config/starship.toml
	mkdir -p ~/.config/nvim
	ln -s -f $(realpath out/nvim/autoload) ~/.config/nvim/autoload
	ln -s -f $(realpath out/nvim/bundle) ~/.config/nvim/bundle
	ln -s -f $(realpath out/nvim/coc-settings.json) ~/.config/nvim/coc-settings.json
	ln -s -f $(realpath out/nvim/init.vim) ~/.config/nvim/init.vim
	# Configure tools.
	git config --global core.excludesfile ~/.gitignore-global

clean:
	peru clean
	rm -rf out
