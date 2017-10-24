export IGNOREEOF=1
export HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000

export EDITOR=vim

set -o vi

# append to the history file, don't overwrite it
shopt -s histappend

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# User specific aliases and functions
alias gcc='gcc -Wall'
alias ls='ls -hG'
alias ll='ls -laF'
alias tcpdump='sudo tcpdump'
alias vi='vim'
alias ping6='ping6 -I en1'
alias ssh='ssh -AXY'
alias grep='grep --color=auto'

# vi mode in the shell
set -o vi

# Source global definitions
if [ -r /etc/profile ]; then
	. /etc/profile
fi

export PATH=$PATH:/usr/local/sbin:/Applications/Xcode.app/Contents/Developer/usr/bin:`dirname ${BASH_SOURCE[0]}`
export PS1='[\u@\h \W]\$ '

if [ "$DISPLAY" == "" ]; then
    export DISPLAY=localhost:0.0
fi

if [ `which brew` ]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi
