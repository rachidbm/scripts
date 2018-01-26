#!/bin/bash

## version: 20101004

## Download up-to-date backups from different locations 


source `dirname $(readlink -f $0)`/functions.sh     # include funtions

## bla
mkdir -p ~/backup/bla/
log "Get backup from bla.nl";
scp bla.nl:~/backup/bla/newest ~/backup/bla/$TODAY.tgz

## Clean up older backups?

