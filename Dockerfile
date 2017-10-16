FROM "library/ubuntu:17.04"

ARG PWD
ARG UID
ARG GID
ARG USERNAME

RUN apt-get update \
 && apt-get install -y sudo git tmux vim python3 \
 && echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
 && useradd -u $UID -g $GID -G sudo -m $USERNAME
