#!/bin/bash
# version: 20100908

CURRENT_DATE=$(date +%Y%m%d);
DUMP=~/backup/`hostname`/mysqldump-$CURRENT_DATE.zip

mysqldump --all-databases | gzip > $DUMP;
echo "Dump: `du -h $DUMP`";


# mysqldump -p'PASS' -uUSER DATABASE > DATABASE.sql

