#*/10 * * * *   ~/scripts/ping-per-minute.sh  >> ~/ping.log
echo `date +%Y-%m-%d\ %H:%M:%S` \
 `ping -c1 nu.nl` \
