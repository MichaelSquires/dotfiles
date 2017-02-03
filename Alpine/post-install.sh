#!/bin/sh
CONFIGPATH="/tmp/config"

# Add main and community repositories
cat << EOF > /etc/apk/repositories
http://dl-2.alpinelinux.org/alpine/v3.5/main
http://dl-2.alpinelinux.org/alpine/v3.5/community
EOF

apk update
apk add bash

apk add git
git clone https://gitlab.com/__blackout/config.git ${CONFIGPATH}

/bin/bash ${CONFIGPATH}/Alpine/post-install.modules.sh
rm -rf ${CONFIGPATH}
