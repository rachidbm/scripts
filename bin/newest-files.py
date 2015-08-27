#!/usr/bin/python

# version: 20130316

import os, time, sys
from os.path import join

max_files = 10   # Default 

if len(sys.argv) > 1:
    try:
        max_files = int(sys.argv[1])
    except:
        print >> sys.stderr, "ERROR: '{0}' is an invalid number, using the " \
            "default: {1}".format(sys.argv[1], max_files)


def printList(fileList): 
    for f in fileList:
        print time.strftime("%d-%m-%Y %H:%M:%S", time.localtime(f[0])), f[1]


fileList = []
for root, dirs, files in os.walk('.'):
    for f in files:
        fp = os.path.join(root, f)
        try:
            fileList.append( ((os.path.getmtime(fp)), fp) )
        except:
            #print >> sys.stderr, "ERROR on file: ", fp
            pass

#sortedList = fileList.sort(key=operator.itemgetter(0), reverse=True )
sortedList = sorted(fileList, key=lambda f:f[0])

if len(sortedList) <= max_files:     # print whole list
    printList(sortedList)
else:   # print tail of list
    printList(sortedList[len(sortedList)-max_files:])
