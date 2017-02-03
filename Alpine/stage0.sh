#!/bin/sh
CONFIGPATH="/tmp/config"

apk add git
git clone https://gitlab.com/__blackout/config.git ${CONFIGPATH}
/bin/sh ${CONFIGPATH}/Alpine/stage1.sh
cp -R 
/bin/bash ${CONFIGPATH}/Alpine/stage2.sh