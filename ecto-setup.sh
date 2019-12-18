#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
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

cd $SCRIPT_DIR
if readlink $BASH_SOURCE >/dev/null
then
    # prepare migration
    export COMPOSE_FILE="docker-compose.yml${COMPOSE_FILE_DELIMITOR}docker-compose.mix-prod.yml"
    WEB=web.ecto
    MIX_ENV=prod
    docker-compose up -d $WEB
else
    WEB=web.dev
    MIX_ENV=dev
    docker-compose up -d
    sleep 3
fi

docker-compose exec $WEB bash -c "export COLUMNS=$(tput cols); export LINES=$(tput lines); cd \$THIS_APP_NAME; MIX_ENV=$MIX_ENV mix deps.get && MIX_ENV=$MIX_ENV mix deps.compile && MIX_ENV=$MIX_ENV mix ecto.setup"
if readlink $BASH_SOURCE >/dev/null
then
    # prepare migration
    export COMPOSE_FILE="docker-compose.yml${COMPOSE_FILE_DELIMITOR}docker-compose.mix-prod.yml"
    WEB=web.ecto
    MIX_ENV=prod
    docker-compose stop $WEB
fi
