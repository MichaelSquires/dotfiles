#!/bin/sh
CONFIGPATH="/tmp/config"

apk add git
git clone https://gitlab.com/__blackout/config.git ${CONFIGPATH}

cp -Rf ${CONFIGPATH}/Alpine/etc /

/bin/sh ${CONFIGPATH}/Alpine/stage1.sh
/bin/bash ${CONFIGPATH}/Alpine/stage2.sh

rc-update add docker default
service docker start

rc-update add avahi-daemon default
service avahi-daemon start