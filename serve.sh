#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
cd $SCRIPT_DIR
if readlink $BASH_SOURCE >/dev/null
then
    YML=docker-compose.dev.yml
    LOGS=./dev-logs.sh
    WEB=web.dev
else
    YML=docker-compose.yml
    LOGS=./logs.sh
    WEB=web
fi
docker-compose -f $YML exec $WEB bash -c "export COLUMNS=$(tput cols); export LINES=$(tput lines); cd \$APP_NAME; mix phx.server"
