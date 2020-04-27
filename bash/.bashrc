export IGNOREEOF=1
export HISTCONTROL=ignoreboth

export HISTSIZE=1000
export HISTFILESIZE=2000

export EDITOR=vim
export HOMEBREW_NO_ANALYTICS=1

# append to the history file, don't overwrite it
shopt -s histappend

# vi mode in the shell
set -o vi
bind -m vi-insert "\C-l":clear-screen

alias ls='ls -G'
alias vi='vim'

export PS1='[\u@\h \W]\$ '
export PATH=${PATH}:~/.local
