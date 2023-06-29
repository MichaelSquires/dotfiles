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

alias ls='ls --color'
alias vi='vim'

export PS1='[\u@\h \W]\$ '
export PATH=${PATH}:~/.local
#source "$HOME/.cargo/env"

if [ -e $HOME/.pyenv ]
then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

