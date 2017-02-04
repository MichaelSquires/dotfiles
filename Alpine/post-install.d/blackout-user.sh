#!/bin/sh

USERNAME="blackout"

adduser ${USERNAME}
usermod -aG docker ${USERNAME}
usermod -aG wheel ${USERNAME}
usermod -s /bin/bash ${USERNAME}

su - -c "git clone https://gitlab.com/__blackout/config.git ~/.config" blackout
su - -c "~/.config/install.sh" blackout
