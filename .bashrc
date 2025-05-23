export TZ="America/New_York"
export IGNOREEOF=1

export PS1='[\u@\h \W]\$ '
export PATH=${PATH}:~/.local

# History options
export HISTCONTROL=ignoreboth
export HISTSIZE=50000
export HISTFILESIZE=100000
shopt -s histappend

# Save history every time a command is run
export PROMPT_COMMAND='history -a'

if command -v nvim &> /dev/null; then
    function _nvim() {
        PYENV_VERSION="neovim" nvim $*
    }
    export EDITOR=nvim
    alias vi='_nvim'
    alias vim='_nvim'
else
    export EDITOR=vim
    alias vi='vim'
fi

# vi mode in the shell
set -o vi
bind -m vi-insert "\C-l":clear-screen

alias ls='ls --color=auto'
alias ll='ls -la'

# Random work aliases/functions
alias storm='python -m synapse.tools.storm cell:///tmp/v/cortex'
alias cortex='python -m synapse.servers.cortex /tmp/v/cortex'

if test -S ~/.1password/agent.sock; then
    export SSH_AUTH_SOCK=~/.1password/agent.sock
fi

# SSH agent coupling for reattaching tmux sessions
if test -n "$TMUX" -a -n "$SSH_TTY" -a -n "$SSH_AUTH_SOCK"; then
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

function changelog() {
    if [ $# -ne 1 ]; then
        echo "USAGE: changelog <type>"
        return 1
    fi

    CHANGELOG_TMPFILE=`mktemp --suffix .rst`

    $EDITOR $CHANGELOG_TMPFILE

    if [ -s $CHANGELOG_TMPFILE ]; then
        python -m synapse.tools.changelog gen -a -t $1 "`sed -z -e 's/\n$//' -e 's/\n/ /g' < $CHANGELOG_TMPFILE`"
    fi

    rm $CHANGELOG_TMPFILE
}

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
if [ -d $HOME/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv &> /dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

BREW=/home/linuxbrew/.linuxbrew/bin/brew
if [ -e $BREW ]; then
    eval "$($BREW shellenv)"
else
    echo "Linux brew not found."
fi

export NVM_DIR="$HOME/.config/nvm"
if [ -e $NVM_DIR ]; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
