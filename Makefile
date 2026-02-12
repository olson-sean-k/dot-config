SHELL:=/usr/bin/env bash

# Copy and fetch configuration into the build directory.
.PHONY: build
build:
	# Copy tracked configuration.
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

# Create configuration directories.
.PHONY: install-directory
install-directory:
	# bat.
	mkdir -p ~/.config/bat
	# Neovim.
	mkdir -p ~/.config/nvim/after/ftplugin
	# tmux.
	mkdir -p ~/.config/tmux

# Copy local configuration templates if none are already present.
.PHONY: install-local
install-local: build
	# Z shell.
	cp --update=none -T $(realpath out/zsh/zprofile-local) ~/.zprofile-local
	cp --update=none -T $(realpath out/zsh/zshenv-local) ~/.zshenv-local
	cp --update=none -T $(realpath out/zsh/zshrc-local) ~/.zshrc-local

# Link configuration.
.PHONY: install
install: build install-directory install-local
	# bat.
	ln -s -f -T $(realpath out/bat/themes) ~/.config/bat/themes
	# dircolors.
	ln -s -f -T $(realpath out/dir_colors) ~/.dir_colors
	# Git.
	ln -s -f -T $(realpath out/gitignore-global) ~/.gitignore-global
	# Starship.
	ln -s -f -T $(realpath out/starship.toml) ~/.config/starship.toml
	# Neovim.
	ln -s -f -T $(realpath out/nvim/after/ftplugin/go.lua) ~/.config/nvim/after/ftplugin/go.lua
	ln -s -f -T $(realpath out/nvim/after/ftplugin/lua.lua) ~/.config/nvim/after/ftplugin/lua.lua
	ln -s -f -T $(realpath out/nvim/after/ftplugin/rust.lua) ~/.config/nvim/after/ftplugin/rust.lua
	ln -s -f -T $(realpath out/nvim/autoload) ~/.config/nvim/autoload
	ln -s -f -T $(realpath out/nvim/bundle) ~/.config/nvim/bundle
	ln -s -f -T $(realpath out/nvim/init.lua) ~/.config/nvim/init.lua
	# tmux.
	ln -s -f -T $(realpath out/tmux/colors.tmux) ~/.config/tmux/colors.tmux
	ln -s -f -T $(realpath out/tmux/tmux.conf) ~/.tmux.conf
	# Z shell.
	ln -s -f -T $(realpath out/zsh/zprofile) ~/.zprofile
	ln -s -f -T $(realpath out/zsh/zprompt) ~/.zprompt
	ln -s -f -T $(realpath out/zsh/zshenv) ~/.zshenv
	ln -s -f -T $(realpath out/zsh/zshrc) ~/.zshrc

# Copy and link configuration and then configure tools.
.PHONY: reload
reload: install
	# bat.
	bat cache --build
	# Git.
	git config --global core.excludesfile ~/.gitignore-global

.PHONY: clean
clean:
	peru clean
	rm -rf out
