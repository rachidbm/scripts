history |tr '\011' ' ' |tr -s " "| cut -d' ' -f3 |sort  |uniq -c |sort -nb |tail -n10
