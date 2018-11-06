#!/bin/sh
# usage> 
# $1 filename with experiments paths 
# $2 evalname
if [ "$1" = "" ] || [ "$2" = "" ]|| [ "$3" = "" ];  then
    echo "Usage: $0 <filename> <evalname> <numproc>"
    echo ""
    echo "possible explst names:"
    ls  results/*.explst
    exit
fi
cat $1 | xargs -n 1 -P $3 -I % ./eval.sh % 
rm ~/public_html/evals$2.log
cat $1 | xargs -n 1 -I % bash -c "cat %/eval.log; echo ''" > ~/public_html/evals$2.log
