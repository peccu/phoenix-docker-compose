#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
cd $SCRIPT_DIR
if readlink $BASH_SOURCE >/dev/null
then
    YML=docker-compose.dev.yml
    DB=db
else
    YML=docker-compose.yml
    DB=db
fi
echo 'show db	\l'
echo 'use db	\c [dbname]'
echo 'show tables	\dt'
echo 'describe table	\d [tablename]'
echo 'cf. https://qiita.com/H-A-L/items/fe8cb0e0ee0041ff3ceb'
echo 'cf. https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546'
WINPTY=$(which winpty 2>/dev/null)
$WINPTY docker-compose -f $YML exec $DB bash -c "export COLUMNS=$(tput cols); export LINES=$(tput lines); exec psql -U todoapp postgres"
