#!/bin/sh

KEYFILE="~/.ssh/authorized_keys"

if [ "$1" = "" ]
then
	echo "please provide a host to send the public key to"
else
	#ssh-keygen
	host=$1
	echo Sending my public key to \"$host\"

	cat ~/.ssh/id_rsa.pub | ssh $host "chmod 600 $KEYFILE; cat - >> $KEYFILE; chmod 400 $KEYFILE;"
fi

