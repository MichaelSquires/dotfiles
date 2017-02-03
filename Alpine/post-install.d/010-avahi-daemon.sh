#!/bin/sh
apk add dbus avahi
rc-update add avahi-daemon default
service avahi-daemon start
