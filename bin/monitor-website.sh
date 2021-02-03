log() {
  echo $(date +%d-%m\ %T)  -  $1
}

URL=$1
SLEEP=5
LOG=/tmp/monitor-website-`date +"%Y%m%d-%H%M%S"`.log;

log "Press [CTRL+C] to stop.."	
log "Check every $SLEEP secs if the following URL works: $URL" | tee -a $LOG

while :
do
	wget -q --no-cache  --timeout=3 --tries=1 $URL -O /dev/null
	if [ $? -ne 0 ];then
	  log "DOWN!" | tee -a $LOG
	else
	  log "OK" | tee -a $LOG
	fi
	sleep $SLEEP
done
