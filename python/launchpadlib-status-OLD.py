#!/usr/bin/env python

from launchpadlib.launchpad import Launchpad
print "hoi"

cachedir = "/tmp/cache/"

lp = Launchpad.login_anonymously('get status of translations', 'production', cachedir)
#bug_one = lp.bugs[1]
#print bug_one.title
#print sorted(bug_one.lp_attributes)
ubuntu = lp.distributions["ubuntu"]
archive = ubuntu.main_archive
series = ubuntu.current_series
print archive.getPublishedSources(exact_match=True,
    source_name="apport",
    distro_series=series)[0].display_name

