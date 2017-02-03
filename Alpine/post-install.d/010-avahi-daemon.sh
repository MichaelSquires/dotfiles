#!/bin/sh
apk add avahi
rc-update add avahi-daemon default
service avahi-daemon start
