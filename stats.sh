#!/bin/bash -e
#gathers statistics from the results.
for fn in results/*/stats.txt; do
     str=`egrep -A 1  '^started' $fn | tr -d '\n' `
     begin=$(echo $str | cut -d ' ' -f 2 | tr '.' ' ') 
     end=$(echo $str | cut -d ' ' -f 4 | tr '.' ' ') 
     diff=$(($(date -d "$end" '+%s') - $(date -d "$begin" '+%s')))
     if (( $diff <1200 ));  then
        continue
    fi
    if (( $diff >40000 ));  then
        continue
    fi
    echo $diff
     #echo `date -d@$diff -u +%H:%M:%S`
done
