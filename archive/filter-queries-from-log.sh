#!/bin/bash
# version: 20091015
# Read a log file from consul. Produces some text files with measures about queries

## - init
##########################
[ "$1" == "" ] && echo -e "Provide the log file to read..." && exit;
LOGFILE=$1
Q=queries.txt
SUMS=sum-totals.txt

if [ -f $SUMS ]; then rm $SUMS; fi;

count() {		# store the count of grep $1
	echo "$1 ____  `grep -c \"$1\" $Q`" >> $SUMS
}


## - script
##########################
echo "grep all queries..."
grep  "executeQuery:" $LOGFILE | grep -v "apache.commons" | sed 's/.*executeQuery: //' > $Q

echo "Calculate totals of each unique query..."
awk '{a[$0]++}END{for(i in a)print a[i]," ____ "i}' $Q | sort -rn > totals-sorted-by-amount.txt
awk '{a[$0]++}END{for(i in a)print i" ____ "a[i]}' $Q | sort > totals-sorted-by-query.txt

echo "Calculate totals of some query patterns..."
count "from class nl.first8.consul.db.AdviceRequest"
count "from ADVICEREQUEST_CONTACTPERSONS" 
count "from class nl.first8.consul.db.AdviceRequestState"
count "from class nl.first8.consul.db.AdviceRequest count"
count "from class nl.first8.consul.db.ContactPerson"
count "from class nl.first8.consul.db.PickoffList" 
count "from class nl.first8.consul.db.PickoffValue" 

