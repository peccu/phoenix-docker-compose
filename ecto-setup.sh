#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
cd $SCRIPT_DIR
if readlink $BASH_SOURCE >/dev/null
then
    YML=docker-compose.dev.yml
    LOGS=./dev-logs.sh
    WEB=web.dev
    MIX_ENV=dev
else
    # mix does not in prod container
    YML=docker-compose.dev.yml
    WEB=web.dev
    MIX_ENV=prod
    LOGS=./logs.sh
fi
docker-compose -f $YML exec $WEB bash -c "export COLUMNS=$(tput cols); export LINES=$(tput lines); cd \$APP_NAME; MIX_ENV=$MIX_ENV mix ecto.create && MIX_ENV=$MIX_ENV mix ecto.migrate"
