#!/bin/bash

# automatic tomcat restart script
# author slash4.de 
# 28.09.2009 - v1.0 created

echo "stopping tomcat ..."
/sbin/service tomcat stop
# ^^^ maybe your tomcat service name is tomcat5 instead of tomcat 

echo "Waiting grace time, 20s..."
sleep 20

echo "checking if tomcat still alive"

#TOMCAT_PID=`ps -ef | grep java | grep -v grep | awk '{print $2}'`
# Not a water thight way of checking if tomcat is still running!!
# it also returns other java processes!
# Better get the correct pid from a pid file defined in catalina.sh


if [ -n "$TOMCAT_PID" ]
then
  echo "tomcat still alive ... going to kill it"
  kill -n 9 $TOMCAT_PID
  sleep 2
fi

# restart tomcat
echo "starting tomcat again ..."
/sbin/service tomcat start

