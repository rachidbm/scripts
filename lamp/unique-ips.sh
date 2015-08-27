#!/bin/bash
[ "$1" == "" ] && echo -e "give an _access.log as paramter" &&  exit;
awk < $1 '{print $1}' | sort -u
