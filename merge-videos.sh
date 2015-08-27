#!/bin/bash 

## Version: 20110419

naam=movie

#find . -type f | while read -r f;
ls | grep -v .sh | while read -r f;
do
	#echo ____: $f
	ffmpeg -i "$f" -sameq __"$f".avi 0< /dev/null 
	#rm "$f"
done 

#echo laatste: $naam
#exit 0;

sh -c "cat __*.avi > __merged.avi"

mencoder -forceidx -oac copy -ovc copy __merged.avi -o $naam-merged.avi
sh -c "rm __*"

