#!/bin/sh

mkdir -p /etc/sudoers.d

cat << EOF > /etc/sudoers.d/wheel
%wheel ALL=(ALL) ALL
EOF

apk add sudo
