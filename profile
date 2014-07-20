if [ -n "$BASH_VERSION" ]; then
  # If running bash, include .bashrc if it exists.
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# Add ~/bin to PATH.
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi
