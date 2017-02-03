#!/bin/sh

GITBASE="https://gitlab.com/__blackout/config/raw/master/"

curl -O ${GITBASE}/Alpine/answers.txt
setup-alpine -f answers.txt