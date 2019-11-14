#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
if readlink $BASH_SOURCE >/dev/null
then
    WEB=web.dev
else
    WEB=web
fi
cd $SCRIPT_DIR
docker-compose exec $WEB bash -c "export COLUMNS=$(tput cols); export LINES=$(tput lines); cd \$THIS_APP_NAME; iex -S mix phx.server"
