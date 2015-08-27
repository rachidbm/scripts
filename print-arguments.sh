
log() {
  echo `date +%Y-%m-%d\ %H:%M:%S`  -  $1 
}

echo $@
log "Arguments are: `echo $@`"

#echo `basename`
