#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
cd $SCRIPT_DIR
if readlink $BASH_SOURCE >/dev/null
then
    YML=docker-compose.dev.yml
    WEB=web.dev
else
    YML=docker-compose.yml
    WEB=web
fi
WINPTY=$(which winpty 2>/dev/null)
$WINPTY docker-compose -f $YML exec $WEB bash -c "export COLUMNS=$(tput cols); export LINES=$(tput lines); exec bash"
