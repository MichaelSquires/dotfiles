export TZ="America/New_York"
export IGNOREEOF=1

export PS1='[\u@\h \W]\$ '
export PATH=${PATH}:~/.local

# History options
export HISTCONTROL=ignoreboth
export HISTSIZE=500
export HISTFILESIZE=10000
shopt -s histappend

# Save history every time a command is run
export PROMPT_COMMAND='history -a'

if command -v nvim &> /dev/null; then
    export EDITOR=venvnvim
    alias vi='venvnvim'
    alias vim='venvnvim'
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

# Random work aliases/functions
alias storm='python -m synapse.tools.storm cell:///tmp/v/cortex'
alias cortex='python -m synapse.servers.cortex /tmp/v/cortex'

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

function runvenv() {
    if [ $# -lt 2 ]; then
        echo "USAGE: runvenv <venvname> <cmd> [options]"
        return 1
    fi

    pyenv activate $1
    shift

    eval $*

    pyenv deactivate
}

# Run nvim in a python virtual environment so we can control which modules are
# installed and not have them interfere with system modules or other project
# modules
function venvnvim () {
    runvenv neovim nvim $@
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
if [ -e $HOME/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv &> /dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
