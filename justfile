default: build

# Copy and fetch configuration into the `out` directory.
build:
    # Copy tracked configuration.
    mkdir -p out
    touch out/dir_colors
    cp -f gitignore-global out
    cp -f starship.toml out
    cp -R -f archey4 out
    cp -R -f nvim out
    cp -R -f script out
    cp -R -f tmux out
    cp -R -f zellij out
    cp -R -f zsh out
    # Fetch and import modules.
    peru sync

# Copy and link configuration into the home directory.
install: build
    just _link out/archey4/config.json ~/.config/archey4/config.json
    just _link out/bat/themes ~/.config/bat/themes
    just _link out/dir_colors ~/.dir_colors
    just _link out/gitignore-global ~/.gitignore-global
    just _link out/script/rustp ~/.local/bin/rustp
    just _link out/starship.toml ~/.config/starship.toml
    just _link out/nvim/after/ftplugin ~/.config/nvim/after/ftplugin
    just _link out/nvim/lua/plugin ~/.config/nvim/lua/plugin
    just _link out/nvim/autoload ~/.config/nvim/autoload
    just _link out/nvim/bundle ~/.config/nvim/bundle
    just _link out/nvim/pack ~/.config/nvim/pack
    just _link out/nvim/init.lua ~/.config/nvim/init.lua

reload: install
    -bat cache --build
    -git config --global core.excludesfile ~/.gitignore-global

clean:
    rm -rf out

# Symbolically link the canonicalization of `src` to the relative path `dst` in
# the home directory.
_link src dst:
    ln -s -f -T {{quote(canonicalize_path(src))}} {{quote(dst)}}
