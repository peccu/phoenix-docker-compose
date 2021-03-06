#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
cd $SCRIPT_DIR
source .env
echo "run with MIX_ENV=prod DATABASE_URL=$DATABASE_URL"
doco="docker-compose \
    -f docker-compose.yml \
    -f docker-compose.mix-prod.yml"
$doco up -d web.ecto
$doco exec web.ecto \
    bash -c "export COLUMNS=$(tput cols); export LINES=$(tput lines); cd $THIS_APP_NAME; MIX_ENV=prod DATABASE_URL=$DATABASE_URL SECRET_KEY_BASE=$SECRET_KEY_BASE mix $@"
$doco stop web.ecto
