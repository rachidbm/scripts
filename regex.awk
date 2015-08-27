awk '{
	regex="src=\d+\."
  where = match($0, regex)
  if (where)
    print "of", regex, "found at", where #, "in", $0
}'

