#!/bin/bash
SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}"); pwd)
if readlink $BASH_SOURCE >/dev/null
then
    DB=db
else
    DB=db.dev
fi
cd $SCRIPT_DIR
echo 'show db	\l'
echo 'use db	\c [dbname]'
echo 'show tables	\dt'
echo 'describe table	\d [tablename]'
echo 'cf. https://qiita.com/H-A-L/items/fe8cb0e0ee0041ff3ceb'
echo 'cf. https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546'
WINPTY=$(which winpty 2>/dev/null)
$WINPTY docker-compose exec $DB bash -c "export COLUMNS=$(tput cols); export LINES=$(tput lines); exec bash"
