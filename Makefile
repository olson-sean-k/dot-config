SHELL:=/usr/bin/env bash
#.SHELLFLAGS:=-e

SRC:=./src

build:
	# Fetch and import modules. This includes source code in the `src`
	# directory.
	peru sync
	# Build the language client for vim.
	cd $(SRC)/vim-lsp && $(MAKE) release
	# Copy the build output into a bundle.
	mkdir -p nvim/bundle/lsp/bin
	cp -a \
		$(SRC)/vim-lsp/autoload \
		$(SRC)/vim-lsp/bin \
		$(SRC)/vim-lsp/doc \
		$(SRC)/vim-lsp/plugin \
		nvim/bundle/lsp

install: build
	# Create symbolic links to configuration.
	ln -s bashrc ~/.bashrc
	ln -s dir_colors ~/.dir_colors
	ln -s gitignore-global ~/.gitignore-global
	ln -s tmux.conf ~/.tmux.conf
	ln -s vimrc ~/.vimrc
	ln -s zshrc ~/.zshrc
	mkdir -p ~/.config
	ln -s fish ~/.config/fish
	ln -s starship.toml ~/.config/starship.toml
	mkdir -p ~/.config/nvim
	ln -s nvim/autoload ~/.config/nvim/autoload
	ln -s nvim/bundle ~/.config/nvim/bundle
	ln -s vimrc ~/.config/nvim/init.vim
	# Configure tools.
	git config --global core.excludesfile ~/.gitignore-global

clean:
	peru clean
	rm -rf src
