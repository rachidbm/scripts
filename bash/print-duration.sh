
echo $((180 / 60))
SLEEPTIME=${1:-1}	## Default value
echo "Using sleep time of: $SLEEPTIME"

start=`date +%s`
echo start time: $start

sleep $SLEEPTIME

end=`date +%s`
echo end time $end

duration=$((end-start))

echo duration in secs: $duration
echo duration in mins: $((duration / 60))

