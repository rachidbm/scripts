#!/bin/bash
# version: 20100929

#clear;

SCRIPTPATH=`dirname $(readlink -f $0)` 	# Absolute path this script is in. /home/user/bin
CONNS_LOG=/tmp/conns.log			# Store connection info retrieved from router
IP_LIST=/tmp/iplist						# sorted ip list
GREP="." 											# default do not grep anything
CURRENT_IP=`ifconfig eth0 | grep 'inet addr:'| cut -d: -f2 | awk '{ print $1}'`
NR_CONNS_PRINT=0							# Only print ip's which exceeds this number of connections


### Get nr of connections per ip
#cat $CONNS_LOG | grep $GREP | awk '{ 
#	match($0, /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)
#	print substr($0, RSTART, RLENGTH)
#	}'  | sort |  uniq -c | sort -n   > $IP_LIST;

## Get nr of connections per ip
cat $CONNS_LOG | grep $GREP | awk '{ 
	match($0, /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)
	print substr($0, RSTART, RLENGTH)
	}'  
	# | sort |  uniq -c | sort -n ;

