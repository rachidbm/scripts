#!/bin/bash
# Convert spaces to underscores

# version nr: 20110407

[ "$1" == "" ] && echo Give target directory && exit 0;
UNDO=/tmp/undo-`date +"%Y%m%d-%H%M%S"`.txt;

find "$1" -maxdepth 1 | while read file ; do
  directory=$(dirname "$file")
  oldfilename=$(basename "$file")
  #newfilename=$(echo "$oldfilename" | tr 'A-Z' 'a-z' | tr ' ' '_' | sed 's/_-_/-/g')
  newfilename=$(echo "$oldfilename" | tr ' ' '_' | tr [:upper:] [:lower:] | sed 's/_-_/-/g' | sed 's/&/and/g')

  #newfilename=$(echo "$oldfilename" | sed 's/&/and/g')
  if [ "$oldfilename" != "$newfilename" ]; then
  	mv -i "$directory/$oldfilename" "$directory/$newfilename"
  	#echo ""$directory/$oldfilename" --> "$directory/$newfilename""
  	echo mv -i \"$directory/$newfilename\" \"$directory/$oldfilename\" >> $UNDO;
  fi
  done
echo -e "for undo the renaming check: \n$UNDO ";

exit 0
