#!/usr/bin/python

# version: 20110614
#
# Note: The printed file sizes are approximate! The can differ from what th OS 
# says, but the order is correct. Default 1 KB is 1000 bytes

import os, time, sys
from os.path import join, getsize

max_files = 10   # Default 
SUFFIXES = {1000: ['KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
            1024: ['KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB']}

def approximate_size(size, a_kilobyte_is_1024_bytes=False):
    """Convert a file size to human-readable form.

    Keyword arguments:
    size -- file size in bytes
    a_kilobyte_is_1024_bytes -- if True (default), use multiples of 1024
                                if False, use multiples of 1000
    Returns: string
    """
    if size < 0:
        raise ValueError('number must be non-negative')
    size = float(size)
    multiple = 1024 if a_kilobyte_is_1024_bytes else 1000
    for suffix in SUFFIXES[multiple]:
        size /= multiple
        if size < multiple:
            return '{0:.1f} {1}'.format(size, suffix)

    raise ValueError('number too large')


def printList(fileList): 
    for f in fileList:
        #print time.strftime("%d-%m-%Y %H:%M:%S", time.gmtime(f[0])), f[1]
        print "{0}  \t{1}".format(approximate_size(f[0]), f[1])


if len(sys.argv) > 1:
    try:
        max_files = int(sys.argv[1])
    except:
        print >> sys.stderr, "ERROR: '{0}' is an invalid number, using the " \
            "default: {1}".format(sys.argv[1], max_files)


fileList = []
for root, dirs, files in os.walk('.'):
    for f in files:
        fp = os.path.join(root, f)
        try:
            fileList.append( ((os.path.getsize(fp)), fp) )
        except:
            #print >> sys.stderr, "ERROR on file: ", fp
            pass


#sortedList = fileList.sort(key=operator.itemgetter(0), reverse=True)
sortedList = sorted(fileList, key=lambda f:f[0])

if len(sortedList) <= max_files:     # print whole list
    printList(sortedList)
else:   # print tail of list
    printList(sortedList[len(sortedList)-max_files:])
