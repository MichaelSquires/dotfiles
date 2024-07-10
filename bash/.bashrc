export TZ="America/New_York"
export IGNOREEOF=1

# History options
export HISTCONTROL=ignoreboth
export HISTSIZE=500
export HISTFILESIZE=10000
shopt -s histappend

# Save history every time a command is run
export PROMPT_COMMAND='history -a'

if command -v nvim &> /dev/null; then
    export EDITOR=nvim
    alias vi='nvim'
    alias vim='nvim'
else
    export EDITOR=vim
    alias vi='vim'
fi

if [ -e ~/.1password/agent.sock ]; then
    export SSH_AUTH_SOCK=~/.1password/agent.sock
fi

# vi mode in the shell
set -o vi
bind -m vi-insert "\C-l":clear-screen

alias ls='ls --color=auto'
alias ll='ls -la'
alias storm='python -m synapse.tools.storm cell:///tmp/v/cortex'
alias cortex='python -m synapse.servers.cortex /tmp/v/cortex'

export PS1='[\u@\h \W]\$ '
export PATH=${PATH}:~/.local

# fzf config
export FZF_DEFAULT_COMMAND='rg --files'
if command -v fzf &> /dev/null; then
    if command -v rg &> /dev/null; then
        _fzf_compgen_path() { rg --files "$1"; }
    else
        echo "Could not find ripgrep, fzf using default compgen"
    fi
    eval "$(fzf --bash)"
fi

# Rust/cargo config
[ -e $HOME/.cargo/env ] && source "$HOME/.cargo/env"
[ -e $HOME/.cargo/bin ] && export PATH=$PATH:$HOME/.cargo/bin

# pyenv config
if [ -e $HOME/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv &> /dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

