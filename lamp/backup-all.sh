#!/bin/bash

## version nr: 20101002

homedir=/home/rachid
host=imice
backup_path=$homedir/backup/$host;	
keep_backup_days=30;


log() {
  echo $(date +%d-%m\ %T)  -  $1
}


log "storing backup in the default backup_path: $backup_path";

mkdir -p $backup_path;

  tmpdir=$backup_path/backup-$(date +%Y%m%d);
  mkdir -p $tmpdir;

# dump databases
log "Backup databases";
mysqldump -p'pw' -ubla bla_db1 > $tmpdir/site1.sql

# copy directories to backup
	cp -rp ~/bla.com/web/ $tmpdir/rachidbm.com 2>&1;
	cp -rp ~/.irssi $tmpdir/irssi 2>&1;
 
## tar and zip the backup files
  bakfile=$(echo $tmpdir | sed -e 's/.*\///');
	cd $tmpdir/..;
  tar -zcf $tmpdir.tgz $bakfile;
	rm -rf $tmpdir;
	ln -sf $bakfile.tgz newest
	cd - 			# go back to the directory started in
	log "backup is stored: $backup_path/$bakfile.tgz";

log "Removing backups older than $keep_backup_days days...";
find $backup_path -mtime +$keep_backup_days -name "backup-*" -exec rm {} \;


