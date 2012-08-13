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
#PS1='[%T] %n@%m:%~# '
PROMPT='%n@%B%m%b$ '
RPROMPT='%~'

#report CPU usage for commands taking more than 10 seconds
REPORTTIME=10
