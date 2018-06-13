echo $(date +%Y-%m-%d) "   "  `df -h | grep data | awk '{print $2 " " $3 " " $4 " " $5}' `
