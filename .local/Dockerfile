FROM ubuntu:22.04

ARG UID
ARG GID
ARG USERNAME

RUN apt-get update \
 && apt-get install -y sudo git tmux vim man python3-pip curl locales-all \
 && echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
 && useradd -u $UID -U -G sudo -m $USERNAME
