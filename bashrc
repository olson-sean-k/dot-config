# If not running interactively, do nothing.
[ -z "$PS1" ] && return

if [ $TERM = xterm ]; then
  export TERM=xterm-256color
fi

eval `dircolors ~/.dir_colors`

stty -ixon

# History.
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=10000
HISTFILESIZE=20000
# Append to the history file.
shopt -s histappend


# General aliases.
alias nv='nvim'

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'

alias tree='tree -C'
alias trel='tree -L 3'

alias dutop='du --max-depth=1 2> /dev/null | sort -n -r | head -n20'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias tmls='tmux list-sessions'

alias gmeld='git difftool --dir-diff --tool=meld'

# Use a git-aware prompt if available.
function safe_git_ps1() {
  if [[ `type -t __git_ps1` = function ]]; then
    __git_ps1 %s
  fi
}
# Set prompt.
if hash starship 2>/dev/null; then
  # If available, use Starship to configure the prompt.
  eval "$(starship init bash)"
else
  # If Starship is not available, fall back to a custom prompt.
  export PS1="\[\e[0;36m\]\u@\h\[\e[m\] \[\e[0;34m\]\w\[\e[m\] \[\e[0;33m\]\$(safe_git_ps1)\[\e[m\]\$ "
fi

# Add ~/bin and ~/.local/bin to PATH.
if [ -d "$HOME/bin" ] ; then PATH="$HOME/bin:$PATH" fi
if [ -d "$HOME/.local/bin" ] ; then PATH="$HOME/.local/bin:$PATH" fi

# Set text editor.
export EDITOR=vim

# Fix ssh-agent issue in tmux.
function fixauth() {
  if [[ -n $TMUX ]]; then
    eval $(tmux showenv | grep -vE "^-" | awk -F = '{print "export "$1"=\""$2"\""}')
  fi
}

# Hook for preexec.
preexec () {
  fixauth
}
preexec_invoke_exec () {
  [ -n "$COMP_LINE" ] && return  # Do nothing if completing.
  local this_command=`history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g"`;
  preexec "$this_command"
}
trap 'preexec_invoke_exec' DEBUG

# Load settings specific to this machine.
local_bashrc=~/.bashrc.local
if [ -e "$local_bashrc" ]; then
  source "$local_bashrc"
fi
