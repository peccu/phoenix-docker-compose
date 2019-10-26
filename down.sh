#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
cd $SCRIPT_DIR
if readlink $BASH_SOURCE >/dev/null
then
    YML=docker-compose.dev.yml
else
    YML=docker-compose.yml
fi
docker-compose -f $YML down
