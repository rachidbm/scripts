#!/usr/bin/python

import os, glob
from os.path import join, getsize


for root, dirs, files in os.walk('.'):
    for f in files:
			print os.path.join(root, f)
			#print f

print "==============="


#for root, dirs, files in os.walk('.'):
#    print root, "consumes",
#    print sum(getsize(join(root, name)) for name in files),
#    print "bytes in", len(files), "non-directory files"

