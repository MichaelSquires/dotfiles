#!/bin/sh

USERNAME="blackout"

adduser ${USERNAME}
usermod -aG docker ${USERNAME}
usermod -aG wheel ${USERNAME}
usermod -s /bin/bash ${USERNAME}