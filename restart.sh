#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
if readlink $BASH_SOURCE >/dev/null
then
    WEB=web
else
    WEB=web.dev
fi
cd $SCRIPT_DIR
docker-compose restart $WEB && docker-compose logs --tail=1 && ./logs.sh
