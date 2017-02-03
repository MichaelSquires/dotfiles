#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for SCRIPT in `ls ${DIR}/post-install.d/*.sh`; 
do
    /bin/bash ${SCRIPT}
done
