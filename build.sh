#! /usr/bin/env bash

set -e

cd $(dirname "$BASH_SOURCE")
repo_dir=`pwd`
src_dir="$repo_dir"/src

# Fetch and import modules. This includes source code in the `src` directory.
peru sync

# Build the language client for neo/vim.
vim_lsp_src_dir="$src_dir"/vim-lsp
cd "$vim_lsp_src_dir"
make release
mkdir -p "$repo_dir"/nvim/bundle/lsp/bin
cp -a \
    "$vim_lsp_src_dir"/autoload \
    "$vim_lsp_src_dir"/doc \
    "$vim_lsp_src_dir"/plugin \
    "$repo_dir"/nvim/bundle/lsp
cp -a \
    "$vim_lsp_src_dir"/bin/languageclient \
    "$repo_dir"/nvim/bundle/lsp/bin
