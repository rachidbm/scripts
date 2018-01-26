#!/bin/bash

# version : 20090924

sort -n | \
awk 'BEGIN {u[0]="K";u[1]="M";u[2]="G";}
     { size=$1;sub(/^[^\t]+\t+/,"");name=$0
       for (i=3;i>=0;--i) {
         if ( size > 1024 ^i)
            {printf "%.1f%s\t%s\n",(size / 1024^i),u[i],name;next}}}'

