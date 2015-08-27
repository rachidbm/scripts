#!/bin/bash

INTERVAL=10;
if [ "$1" != "" ]; then
  INTERVAL=$1;
fi

echo interval in seconds: $INTERVAL;

while true; do
echo "-------------------------------------------------------"
	./check-conns.sh | tail -5
	sleep $INTERVAL;
done;

