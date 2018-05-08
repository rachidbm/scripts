
[ "$1" == "" ] && echo -e "Usage: dump-db [DATABASE_NAME] \n[DATABASE_NAME] is the name of the Mongo Database" &&  exit;

mongodump -u '<USERNAME>' --authenticationDatabase authdb --gzip -d $1 --archive=$1-$(date '+%Y%m%d-%H%M').gz
