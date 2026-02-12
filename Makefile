SHELL:=/usr/bin/env bash

.PHONY: build clean install

build:
	# Copy tracked configuration to the build directory.
	mkdir -p out
	touch out/dir_colors
	cp -f gitignore-global out
	cp -f starship.toml out
	cp -R -f nvim out
	cp -R -f ssh out
	cp -R -f tmux out
	cp -R -f zsh out
	# Fetch and import modules.
	peru sync

install: build
	# Create configuration directories.
	mkdir -p ~/.config
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/tmux
	# Copy local configuration.
	cp --update=none -T $(realpath out/zsh/zprofile-local) ~/.zprofile-local
	cp --update=none -T $(realpath out/zsh/zshenv-local) ~/.zshenv-local
	cp --update=none -T $(realpath out/zsh/zshrc-local) ~/.zshrc-local
	# Link configuration.
	ln -s -f -T $(realpath out/dir_colors) ~/.dir_colors
	ln -s -f -T $(realpath out/gitignore-global) ~/.gitignore-global
	ln -s -f -T $(realpath out/starship.toml) ~/.config/starship.toml
	ln -s -f -T $(realpath out/nvim/autoload) ~/.config/nvim/autoload
	ln -s -f -T $(realpath out/nvim/bundle) ~/.config/nvim/bundle
	ln -s -f -T $(realpath out/nvim/coc-settings.json) ~/.config/nvim/coc-settings.json
	ln -s -f -T $(realpath out/nvim/init.vim) ~/.config/nvim/init.vim
	ln -s -f -T $(realpath out/tmux/colors.tmux) ~/.config/tmux/colors.tmux
	ln -s -f -T $(realpath out/tmux/tmux.conf) ~/.tmux.conf
	ln -s -f -T $(realpath out/tmux/plugins) ~/.config/tmux/plugins
	ln -s -f -T $(realpath out/zsh/zprofile) ~/.zprofile
	ln -s -f -T $(realpath out/zsh/zprompt) ~/.zprompt
	ln -s -f -T $(realpath out/zsh/zshenv) ~/.zshenv
	ln -s -f -T $(realpath out/zsh/zshrc) ~/.zshrc
	# Configure tools.
	git config --global core.excludesfile ~/.gitignore-global

clean:
	peru clean
	rm -rf out
