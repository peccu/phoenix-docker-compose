#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
cd $SCRIPT_DIR
if readlink $BASH_SOURCE >/dev/null
then
    YML=docker-compose.dev.yml
    LOGS=./dev-logs.sh
else
    YML=docker-compose.yml
    LOGS=./logs.sh
fi
docker-compose -f $YML up -d && docker-compose -f $YML logs --tail=1 && $LOGS
