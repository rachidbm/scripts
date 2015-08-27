#!/bin/bash
# set -x
# Shell script to monitor or watch the disk space
# It will send an email to $ADMIN, if the (free available) percentage of space is >= ALERT%. ALERT default = 95%

# The email of admin 
ADMIN="rachid"

# set alert level 90% is default
ALERT=95

# Exclude list of unwanted monitoring, if several partions then use "|" to separate the partitions.
# An example: EXCLUDE_LIST="/dev/hdd1|/dev/hdc5"
#EXCLUDE_LIST="/media/ntfs"



# The message to send when disk space exceeds, DO NOT MODIFY!
MESSAGE="";
function main_prog() {

	while read output;
	do
	#echo $output
	  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
	  partition=$(echo $output | awk '{print $2}')
	  if [ $usep -ge $ALERT ] ; then
				MESSAGE=$MESSAGE"Running out of space \"$partition ($usep%)\" on server $(hostname), $(date) \n" 
	  fi
	done

	if [ "$MESSAGE" != "" ] ; then
		echo -ne $MESSAGE | mail -s "Alert: Almost out of disk space $usep%" $ADMIN
	fi
}


if [ "$EXCLUDE_LIST" != "" ] ; then
  df -H | grep -vE "^Filesystem|tmpfs|cdrom|${EXCLUDE_LIST}" | awk '{print $5 " " $6}' | main_prog
else
  df -H | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}' | main_prog
fi
