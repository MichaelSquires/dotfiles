#!/bin/sh
apk add docker
rc-update add docker default
service docker start
