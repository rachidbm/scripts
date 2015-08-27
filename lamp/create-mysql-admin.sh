#!/bin/bash

if [ "$1" == "" ]
then
	echo -e "give a username ";
else
	#mysql -p < /bin/sed -e "s/dre/$1/g" create-user.sql 
	/bin/sed -e "s/USERNAME/$1/g" create-user.sql | mysql -p
fi

