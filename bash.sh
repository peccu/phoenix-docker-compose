#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
if readlink $BASH_SOURCE >/dev/null
then
    WEB=web
else
    WEB=web.dev
fi
cd $SCRIPT_DIR
WINPTY=$(which winpty 2>/dev/null)
$WINPTY docker-compose exec $WEB bash -c "export COLUMNS=$(tput cols); export LINES=$(tput lines); exec bash"
