#!/bin/bash

rsync -ah  --ignore-errors --delete --exclude='.gvfs' /home /srv/backup/

echo " --- "`date +%d-%m-%Y\ %T`" /home synced --- " >> ~/Desktop/sync.log; 
