#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Author: Rachid BM <rachidbm@ubuntu.com>
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


# Analyze translations in a PO file and pick out possible flaws like:
# - Translation doesn't end with a period or colon (while original does)
# - Translation doesn't contain a underscore (while original does)

import sys
import optparse

try:
    import polib
except ImportError:
    print >> sys.stderr, 'This script requires python-polib: \nsudo apt-get install python-polib'
    sys.exit(1)

def print_entry(msgid, msgstr, error_message): 
    """ Print the entry and its error level """
    print error_message
    print msgid.strip().encode("utf-8") 
    print msgstr.strip().encode("utf-8")
    print


class TranslationChecker(object):

    def __init__(self):
        self.counter_error = 0
        self.counter_warning = 0

    def print_error(self, msgid, msgstr, message):
        self.counter_error = self.counter_error + 1
        print_entry(msgid, msgstr, "ERROR: {0}".format(message))

    def print_warning(self, msgid, msgstr, message):
        self.counter_warning = self.counter_warning + 1
        if self.options.show_warnings:
            print_entry(msgid, msgstr, "WARNING: {0}".format(message))

    def run_checker(self):
        """ Check all translated entries of the given PO file """

        # Support for command line options.
        USAGE = """%prog [OPTIONS] PATTERN

Analyze translations in a PO file and pick out possible flaws like:
 - Translation doesn't end with a period or colon (while original does)
 - Translation doesn't contain a underscore (while original does)
"""

        parser = optparse.OptionParser(usage = USAGE)
        parser.add_option('-w', '--show-warnings', dest='show_warnings', action='store_true',
            help = 'Prints warnings.')

        parser.set_defaults(show_warnings = False)
        
        (self.options, args) = parser.parse_args()

        # Error checking (the pattern must be specified)
        if len(args) < 1:
            print >> sys.stderr, 'ERROR: Not enough arguments, the PO file must be specified.'
            sys.exit(1)

        pofile = args[0]
        print "Reading PO file: {0}".format(pofile)

        po = polib.pofile(pofile)
        
        for entry in po.translated_entries():
            self.check_entry(entry)
        print "Found {0} error(s) and {1} warning(s). Add -w to show warnings". \
            format(self.counter_error, self.counter_warning)


    def check_entry(self, entry):
        """ Checks the translation of an entry on possible flaws """
        if entry.msgid_plural:
            # Singular
            original = entry.msgid
            translation = entry.msgstr_plural.values()[1]

            # Only check plural when singular gave no error
            if self.is_proper_string(entry, original, translation):
                # Plural
                original = entry.msgid_plural
                translation = entry.msgstr_plural.values()[0]
                self.is_proper_string(entry, original, translation)
        else:
            original = entry.msgid
            translation = entry.msgstr
            self.is_proper_string(entry, original, translation)


    def is_proper_string(self, entry, original, translation):
        """ Checks two strings of an entry on possible flaws 
            Returns False when an error or warning is found, True otherwise
        """
        if original.strip().endswith("..."): 
            if not (translation.strip().endswith("...")   \
                or translation.strip().endswith("…".decode("utf-8"))):
                """ Error; period doesn't match """
                self.print_error(original, translation, " ... periods doesn't match")
                return False
            elif "..." in translation:
                """ Warning; Prefer … over ... """
                self.print_warning(original, translation, " ...  Prefer … over ...")
                return False
            else:
                return True
        elif original.endswith(".") and not translation.endswith("."):
            """ Error; period doesn't match """
            self.print_error(original, translation, " . period doesn't match.")
            return False
        elif not original.endswith(".") and translation.endswith("."):
            """ Warning; period doesn't match (original string doesn't end with period) """
            self.print_warning(original, translation, " period doesn't match (original string doesn't end with period).")
            return False
        elif (original.endswith(":") and not translation.endswith(":")) \
            or (not original.endswith(":") and translation.endswith(":")):
            """ Error; Colon doesn't match """
            self.print_error(original, translation, " : Colon doesn't match")
            return False
        elif "_" in original and not "_" in translation:
            """Warning; forgot an underscore? """
            self.print_warning(original, translation, " _ forgot an underscore?")
            return False
        elif "..." in translation:
            """ Warning; Prefer … over ... """
            self.print_warning(original, translation, " ...  Prefer … over ...")
            return False
        elif translation.count("'") > 1:
            """ Warning; in Dutch we prefer ‘ ’ over ' '  """
            self.print_warning(original, translation, "Quotation; in Dutch prefer ‘ ’ over ' ' ")
            return False
        return True


## Run the actual program
tc = TranslationChecker()
tc.run_checker()
