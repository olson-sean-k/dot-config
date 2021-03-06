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

  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  alias ls='ls -F'
fi

# General aliases.
alias nv='nvim'

alias ll='ls -l -h'
alias la='ls -a'

alias tree='tree -C'
alias trel='tree -L 3'

alias dutop='du --max-depth=1 2> /dev/null | sort -n -r | head -n20'

alias tma='tmux attach'
alias tmls='tmux list-sessions'
alias tmns='tmux new-session'

alias gitmeld='git difftool --dir-diff --tool=meld'

# Editor.
export EDITOR=nvim

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
else
  # If Starship is not available, fall back to a custom prompt.
  setopt prompt_subst

  PROMPT='%{%(!.%F{red}.%F{cyan})%}%n%{%f%}@%{%F{yellow}%}%m%{%f%} %{%F{green}%}$(__git_prompt)%{%f%}%# '
  RPROMPT='%{%F{magenta}%}%~%{%f%}'
fi

# Source local settings.
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

__git_prompt() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "$(__git_branch)$(__git_mode) "
  fi
}

__git_mode() {
  g=`git rev-parse --git-dir 2> /dev/null`
  if [ $? != 0 ]; then
    return
  fi

  mode=""
  if [ -f "$g/rebase-merge/interactive" ]; then
    mode="|REBASE-i"
  elif [ -d "$g/rebase-merge" ]; then
    mode="|REBASE-m"
  elif [ -d "$g/rebase-apply" ]; then
    if [ -f "$g/rebase-apply/rebasing" ]; then
      mode="|REBASE"
    elif [ -f "$g/rebase-apply/applying" ]; then
      mode="|AM"
    else
      mode="|AM/REBASE"
    fi
  elif [ -f "$g/MERGE_HEAD" ]; then
    mode="|MERGING"
  elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
    mode="|CHERRY-PICKING"
  elif [ -f "$g/BISECT_LOG" ]; then
    mode="|BISECTING"
  fi

  echo $mode
}

__git_branch() {
  name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  if [ $? != 0 ]; then
    return
  fi

  if [ $name = HEAD ]; then # if no branch, get the hash
    name=`git rev-parse --short HEAD`
  fi

  echo $name
}
