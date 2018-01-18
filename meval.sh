#!/bin/sh
# usage> 
# $1 filename with experiments paths 
# $2 evalname
# $3 read or write
git pull
cat $1 | xargs -n 1 -P 4 -I % ./eval.sh % $3
rm ~/public_html/evals$2.log
cat $1 | xargs -n 1 -I % bash -c "cat %/eval.log; echo ''" > ~/public_html/evals$2.log
