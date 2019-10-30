if [ -n "$BASH_VERSION" ]; then
  # If running bash, include .bashrc if it exists.
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
