#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# ends-with-dot - Checks if the original string and the translation both ends 
#    with dot or not. 
#
# Copyright (c) 2011 Canonical Services Ltd.
#
# Original author: Rachid BM <rachidbm@ubuntu.com>
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 3, as published
# by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranties of
# MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program.  If not, see <http://www.gnu.org/licenses/>.

import sys
import optparse

try:
    import polib
except ImportError:
    print >> sys.stderr, 'You need python-polib: \nsudo apt-get install python-polib'
    sys.exit(1)


def print_error(entry):
    print entry.msgid.strip().encode("utf-8")," ___ ", entry.msgstr.strip().encode("utf-8")
    #counter = counter + 1
    
#counter = 0

# Support for command line options.
USAGE = """%prog [OPTIONS] PATTERN

Checks if the original string and the translation both end with dot or 
not. """
parser = optparse.OptionParser(usage = USAGE)

(options, args) = parser.parse_args()

# Error checking (the pattern must be specified)
if len(args) < 1:
    print >> sys.stderr, 'ERROR: Not enough arguments, the PO file must be specified'
    sys.exit(1)

pofile = args[0]
print "Reading PO file: {0}".format(pofile)

po = polib.pofile(pofile)
for entry in po:
    
    if entry.msgid.strip().endswith("..."): 
        if not (entry.msgstr.strip().endswith("...") or entry.msgstr.strip().endswith("…".decode("utf-8"))):
            print_error(entry)
    elif entry.msgid.strip().endswith(".") and not entry.msgstr.strip().endswith("."):
        print_error(entry)
#    elif not entry.msgid.strip().endswith(".") and entry.msgstr.strip().endswith("."):
#        print_error(entry)
    elif entry.msgid.strip().endswith(":") and not entry.msgstr.strip().endswith(":"):
        print_error(entry)
    elif not entry.msgid.strip().endswith(":") and entry.msgstr.strip().endswith(":"):
        print_error(entry)
        

#print "{0} error(s) found.".format(counter)
