#!/usr/bin/python

import sys
import urllib

# Get a file-like object for the Python Web site's home page.
# f = urllib.urlopen("http://bla.nl")
print sys.argv

if (len(sys.argv) > 1):

	#print 'arg: ' + sys.argv[1];
	f = urllib.urlopen(sys.argv[1])
	
	# Read from the object, storing the page's contents in 's'.
	s = f.read()
	f.close()
	print s
else:
  print "[ERROR] - please provide an url."

# print "done"
