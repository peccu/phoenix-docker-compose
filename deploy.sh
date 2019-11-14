#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
if ! readlink $BASH_SOURCE >/dev/null
then
    echo This script is for production
    exit 1
fi
cd $SCRIPT_DIR
docker-compose build && ./ecto-setup.sh && ./up.sh
