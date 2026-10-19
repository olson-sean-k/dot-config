default: install

# Copy and fetch configuration into the `out` directory.
build:
    # Copy internal configuration tracked in this repository.
    mkdir -p out
    touch out/dir_colors
    cp -f gitignore-global out
    cp -f starship.toml out
    cp -R -f archey4 out
    cp -R -f nvim out
    cp -R -f script out
    cp -R -f zellij out
    cp -R -f zsh out
    # Fetch and import external configuration, plugins, etc.
    peru sync

# Create configuration directories within the home directory.
install-directory:
    # Archey 4.
    mkdir -p ~/.config/archey4
    # bat.
    mkdir -p ~/.config/bat
    # Neovim.
    mkdir -p ~/.config/nvim/after
    mkdir -p ~/.config/nvim/lua
    # Zellij.
    mkdir -p ~/.config/zellij/layouts
    # Local binaries and scripts.
    mkdir -p ~/.local/bin

# Copy local configuration templates to the home directory if they do not
# already exist. These files provide overrides for machine-specific
# configuration.
install-local: build
    just _copy out/zsh/zprofile-local ~/.zprofile-local
    just _copy out/zsh/zshenv-local ~/.zshenv-local
    just _copy out/zsh/zshrc-local ~/.zshrc-local

# Copy and link configuration into the home directory.
install: build install-directory install-local
    # Archey 4.
    just _link out/archey4/config.json ~/.config/archey4/config.json
    # bat.
    just _link out/bat/themes ~/.config/bat/themes
    # dircolors.
    just _link out/dir_colors ~/.dir_colors
    # Git.
    just _link out/gitignore-global ~/.gitignore-global
    # Scripts.
    just _link out/script/rustp ~/.local/bin/rustp
    # Starship.
    just _link out/starship.toml ~/.config/starship.toml
    # Neovim.
    just _link out/nvim/after/ftplugin ~/.config/nvim/after/ftplugin
    just _link out/nvim/lua/plugin ~/.config/nvim/lua/plugin
    just _link out/nvim/autoload ~/.config/nvim/autoload
    just _link out/nvim/bundle ~/.config/nvim/bundle
    just _link out/nvim/pack ~/.config/nvim/pack
    just _link out/nvim/init.lua ~/.config/nvim/init.lua
    # Zellij.
    just _link out/zellij/layouts/rustp.kdl ~/.config/zellij/layouts/rustp.kdl
    just _link out/zellij/config.kdl ~/.config/zellij/config.kdl
    # Z shell.
    just _link out/zsh/zprofile ~/.zprofile
    just _link out/zsh/zprompt ~/.zprompt
    just _link out/zsh/zshenv ~/.zshenv
    just _link out/zsh/zshrc ~/.zshrc

reload: install
    -bat cache --build
    -git config --global core.excludesfile ~/.gitignore-global

# Remove the `out` directory. This breaks any installed symbolic links to
# configuration. Nothing is uninstalled: files and links created in the home
# directory are not affected.
clean:
    rm -rf out

# Copy `src` to `dst` if `dst` does not already exist.
_copy src dst:
    cp --update=none -T {{quote(src)}} {{quote(dst)}}

# Symbolically link the canonicalization of `src` to `dst`.
_link src dst:
    ln -s -f -T {{quote(canonicalize(src))}} {{quote(dst)}}
