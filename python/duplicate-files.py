#!/usr/bin/python

# version: 20100920


import os, sys, glob, datetime, tempfile
import hashlib

def md5(fileName, excludeLine="", includeLine=""):
    """Compute md5 hash of the specified file"""
    m = hashlib.md5()
    try:
        fd = open(fileName,"rb")
    except IOError:
        print "Unable to open the file in readmode:", fileName
        return
    content = fd.readlines()
    fd.close()
    for eachLine in content:
        if excludeLine and eachLine.startswith(excludeLine):
            continue
        m.update(eachLine)
    m.update(includeLine)
    return m.hexdigest()

## Determine directory to look for duplicate files
path='.'
if len(sys.argv) > 1 and (sys.argv[1]):
	path = sys.argv[1]
print "Looking in dir:", path

d = dict()
#print len(d)

time=datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
#print "sep: "+os.sep

#dupfiles = open('/tmp/duplicate-files-'+time, 'w')
#rmfiles = open('/tmp/remove-duplicate-files-'+time, 'w')

dupfiles = open('/tmp/duplicate-files', 'w')
rmfiles = open('/tmp/remove-duplicate-files', 'w')
## Loop all files
for root, dirs, files in os.walk(path):
	print dirs 
	for file in files:
		f = os.path.join(root, file)
		cs = md5(f)
		if(cs in d):
			dupfiles.write(f + " is dubbel met: "+ d[cs] + "\n")
			rmfiles.write("rm \""+f+"\";\n")
		else:
			d[cs] = f
		#print "%s %s" %(md5(f), f)

print "Duplicate files stored in: " + dupfiles.name
print "Remove duplicate files: " + rmfiles.name
