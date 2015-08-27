#!/bin/bash
# version: 20100929

#clear;

SCRIPTPATH=`dirname $(readlink -f $0)` 	# Absolute path this script is in. /home/user/bin
CONNS_LOG=/tmp/conns.log			# Store connection info retrieved from router
IP_LIST=/tmp/iplist						# sorted ip list
GREP="." 											# default do not grep anything
CURRENT_IP=`ifconfig eth0 | grep 'inet addr:'| cut -d: -f2 | awk '{ print $1}'`
NR_CONNS_PRINT=5							# Only print ip's which exceeds this number of connections

# TODO: Try to retrieve conn info with netstat
## Retrieve connections info from router
#TODO: Better check, maybe on 192.168.2.x
if [ "$CURRENT_IP" == "192.168.2.2" ]; then
	echo "Checking connections from inside the network...";
	ssh root@router 'cat /proc/net/ip_conntrack' > $CONNS_LOG;
else
	echo "Checking connections from a remote location...";
	ssh -p2221 root@router 'cat /proc/net/ip_conntrack' > $CONNS_LOG;
fi;

## grep certain ips? i.e. 192
if [ "$1" != "" ]; then
	GREP="$1";
	echo GREP on : $GREP;
fi;

## Get nr of connections per ip
cat $CONNS_LOG | grep $GREP | awk '{ 
	match($0, /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)
	print substr($0, RSTART, RLENGTH)
	}'  | sort |  uniq -c | sort -n   > $IP_LIST;

## Try to link a name to each ip
cat $IP_LIST | while read -r ip; 
do
	NR=` echo $ip | awk '{print $1}' ` 
	NAME=$(grep "` echo $ip | awk '{print $2}'` " $SCRIPTPATH/names);
	if [ "$NAME" == "" ]; then
		NAME=`echo $ip | awk '{print $2}'`;
	fi;
	## Only interested in ip's with more than 5 connections
	if [ $NR -gt $NR_CONNS_PRINT ]; then 
		echo $NR "-" $NAME
	fi
done;	

echo "-> `wc -l $CONNS_LOG` total";

