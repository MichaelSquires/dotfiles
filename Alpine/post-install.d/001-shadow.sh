#!/bin/sh

mkdir -p /etc/pam.d

cat << EOF > /etc/pam.d/usermod
#%PAM-1.0
auth		sufficient	pam_rootok.so
account		required	pam_permit.so
password	include		system-auth
EOF

apk add shadow
