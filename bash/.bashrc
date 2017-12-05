export IGNOREEOF=1
export HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000

export EDITOR=vim

# append to the history file, don't overwrite it
shopt -s histappend

# vi mode in the shell
set -o vi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# User specific aliases and functions
alias gcc='gcc -Wall'
alias ll='ls -laF'
alias ls='ls -hG'
alias ping6='ping6 -I en1'
alias ssh='ssh -AXY'
alias tcpdump='sudo tcpdump'
alias vi='vim'

# Source global definitions
if [ -r /etc/profile ]; then
    . /etc/profile
fi

if [ "$DISPLAY" == "" ]; then
    export DISPLAY=localhost:0.0
fi

### macOS ###
if [ "`uname`" == "Darwin" ]; then
    GOPATH=~/Data/go
    PATH=$PATH:/Applications/Xcode.app/Contents/Developer/usr/bin

    if [ `which brew` ]; then
        if [ -f $(brew --prefix)/etc/bash_completion ]; then
            . $(brew --prefix)/etc/bash_completion
        fi
    fi
fi

export PS1='[\u@\h \W]\$ '
export GOPATH=${GOPATH:-~/.go}
export PATH=$PATH:~/.local:$GOPATH/bin

if [[ ! $TERM =~ screen ]]; then
    exec tmux new-session -A -s default
fi
