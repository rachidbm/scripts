sudo  egrep -ri "$(date '+%b %e')"'.*(missing|error|fail|valid|fatal|corrupt|warning|wrong|illegal| fault|caused)' /var/log/*  | sort -u
