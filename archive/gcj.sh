#!/bin/bash

[ "$1" == "" ] && echo -e "Give a java file to compile..." &&  exit;

# Compile
gcj -c -g -O $1.java

# link, tell wich main needs to be executed...
gcj --main=$1 -o $1 $1.o
