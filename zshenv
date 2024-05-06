export EDITOR=nvim

# User binaries.
PATH="$HOME/.local/bin${PATH+:$PATH}"

# Source local settings.
if [[ -f ~/.zshenv-local ]]; then
  source ~/.zshenv-local
fi
