export TZ="America/New_York"
export IGNOREEOF=1
export HISTCONTROL=ignoreboth

export HISTSIZE=1000
export HISTFILESIZE=2000

if [ -z "${EDITOR}" ]; then
    export EDITOR=vim
fi
export HOMEBREW_NO_ANALYTICS=1

# append to the history file, don't overwrite it
shopt -s histappend

# vi mode in the shell
set -o vi
bind -m vi-insert "\C-l":clear-screen

alias ls='ls --color=auto'
alias ll='ls -la'
alias vi='vim'
alias storm='python -m synapse.tools.storm cell:///tmp/v/cortex'
alias cortex='python -m synapse.servers.cortex /tmp/v/cortex'

export PS1='[\u@\h \W]\$ '
export PATH=${PATH}:~/.local
if [ -e $HOME/.cargo ]
then
    source "$HOME/.cargo/env"
fi

if [ -e $HOME/.pyenv ]
then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
