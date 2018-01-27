log() {
  echo $(date +%d-%m\ %T)  -  $1
}

log "Start infinitive loop"

SLEEP=1
while :
do
	log "Press [CTRL+C] to stop.."
	log "Sleeping for $SLEEP secs"
	sleep $SLEEP
done
