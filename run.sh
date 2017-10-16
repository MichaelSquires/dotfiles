#!/bin/sh

HOMEDIR=/home/`whoami`

docker run \
    --rm \
    -it \
    -w ${HOMEDIR} \
    -u `id -u`:`id -g` \
    -v ~/.vim:${HOMEDIR}/.vim \
    -v ~/.vimrc:${HOMEDIR}/.vimrc \
    -v ~/.tmux.conf:${HOMEDIR}/.tmux.conf \
    ubuntu-dev
