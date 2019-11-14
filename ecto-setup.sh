#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
cd $SCRIPT_DIR
# https://gist.github.com/bermi/4125858
os=${OSTYPE//[0-9.-]*/}
case "$os" in
    darwin|linux)
        export COMPOSE_FILE_DELIMITOR=":"
        ;;
    msys)
        export COMPOSE_FILE_DELIMITOR=";"
        ;;
    *)
        echo "Unknown Operating system $OSTYPE"
        exit 1
esac

if readlink $BASH_SOURCE >/dev/null
then
    export COMPOSE_FILE=docker-compose.dev.yml
    LOGS=./dev-logs.sh
    WEB=web.dev
    MIX_ENV=dev
else
    # mix does not in prod container
    export COMPOSE_FILE="docker-compose.yml${COMPOSE_FILE_DELIMITOR}docker-compose.dev.yml${COMPOSE_FILE_DELIMITOR}docker-compose.mix-prod.yml"
    WEB=web.dev
    MIX_ENV=prod
    LOGS=./logs.sh
fi
docker-compose exec $WEB bash -c "export COLUMNS=$(tput cols); export LINES=$(tput lines); cd \$THIS_APP_NAME; MIX_ENV=$MIX_ENV mix ecto.setup"
