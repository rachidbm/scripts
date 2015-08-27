#!/bin/bash

BACKUP_PATH=/srv/backup
BARRETT=/srv/barrett

sync() {
	rsync -ahv $1 $2
	#rsync -ahv --delete $1 $2
}

sync ~/ntfs/fotos $BARRETT/
sync ~/ntfs/apps $BARRETT/
sync ~/ntfs/mp3 $BARRETT/
sync ~/ntfs/NMP $BARRETT/
sync ~/ntfs/dev $BARRETT/
sync ~/ntfs/games $BARRETT/
sync ~/ntfs/videos $BARRETT/

## Keep /home in sync
rsync -ahv --ignore-errors --delete --exclude='.gvfs' /home $BACKUP_PATH


echo " --- "`date +%d-%m-%Y\ %T`" barrett synced --- " >> ~/Desktop/sync.log; 


