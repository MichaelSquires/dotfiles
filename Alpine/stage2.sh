#!/bin/sh

cp etc/pam.d/usermod /etc/pam.d/usermod

adduser blackout
usermod -aG docker blackout
usermod -aG wheel blackout
usermod -s /bin/bash blackout

cp etc/suoders.d/wheel /etc/sudoers.d/wheel
