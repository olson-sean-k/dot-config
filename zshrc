autoload -U colors && colors

realpath() {
  (
    target_file="$1"
    cd "$(dirname "$target_file")"
    target_file="$(basename "$target_file")"

    while [ -L "$target_file" ]; do
      target_file="$(readlink "$target_file")"
      cd "$(dirname "$target_file")"
      target_file="$(basename "$target_file")"
    done

    phys_dir="$(pwd -P)"
    echo "$phys_dir/$target_file"
  )
}
repo="$(dirname $(realpath ${ZDOTDIR-~}/.zshrc))"

bindkey -e

# Tab completion.
autoload -U compinit
compinit

setopt completeinword

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' completer _expand _complete _approximate

# Colors.
if [[ -x "`whence -p dircolors`" ]]; then
  eval `dircolors ~/.dir_colors`
  alias ls='ls -F --color=auto'
  alias grep='grep --color=auto'
else
  alias ls='ls -F'
fi

alias ll='ls -l -h'
alias la='ls -a'
alias tree='tree -C'
alias trel='tree -L 3'

alias dutop='du --max-depth=1 2> /dev/null | sort -n -r | head -n20'

alias nv='nvim'

alias tma='tmux attach'
alias tmls='tmux list-sessions'
alias tmns='tmux new-session'

# History.
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=5000

setopt incappendhistory
setopt sharehistory
setopt extendedhistory

# Extended globbing.
setopt extendedglob
unsetopt caseglob

# Allow comments at prompt.
setopt interactivecomments

# Change directory without cd.
setopt auto_cd

# Report CPU usage for long running commands.
REPORTTIME=10

# Set prompt.
if (( $+commands[starship] )); then
  # If available, use Starship to configure the prompt.
  eval "$(starship init zsh)"
elif [[ -f ~/.zprompt ]]; then
  # If Starship is not available, then fall back to the prompt in `zprompt`.
  source ~/.zprompt
fi

# Source local settings.
if [[ -f ~/.zshrc-local ]]; then
  source ~/.zshrc-local
fi
