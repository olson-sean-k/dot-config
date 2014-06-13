autoload -U colors && colors

#tab completion
autoload -U compinit
compinit

setopt completeinword

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' completer _expand _complete _approximate

#color support for ls
if [[ -x "`whence -p dircolors`" ]]; then
  eval `dircolors`
  alias ls='ls -F --color=auto'

  alias grep='grep --color=auto'

  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  alias ls='ls -F'
fi

#aliases
alias ll='ls -l'
alias la='ls -a'

alias tree='tree -C'
alias trel='tree -L 3'

alias tmls='tmux list-sessions'

alias gmeld='git difftool --dir-diff --tool=meld'

#alias htop if available
if (( $+commands[htop] )); then
#  alias top='htop'
fi

#history
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=5000

setopt incappendhistory
setopt sharehistory
setopt extendedhistory

#extended globbing
setopt extendedglob
unsetopt caseglob

#allow comments at prompt
setopt interactivecomments

#change directory without cd
setopt auto_cd

#set prompt
setopt prompt_subst

PROMPT='%{%(!.%F{red}.%F{cyan})%}%n%{%f%}@%{%F{yellow}%}%m%{%f%} %{%F{green}%}$(__git_prompt)%{%f%}%# '
RPROMPT='%{%F{magenta}%}%~%{%f%}'

#report CPU usage for commands taking more than 10 seconds
REPORTTIME=10

#add ~/bin to PATH
if [ -d "$HOME/bin" ] ; then PATH="$HOME/bin:$PATH" fi

#go
export GOPATH="$HOME/src"

#splash
if (( $+commands[splash] )); then
#  splash
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
