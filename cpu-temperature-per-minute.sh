#*/1 * * * *   ~/scripts/cpu-temperature-per-minute.sh  >> ~/cpu-temp.log
echo `date +%Y-%m-%d\ %H:%M:%S` "   "  `vcgencmd measure_temp`
