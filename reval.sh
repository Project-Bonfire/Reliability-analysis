#!/bin/sh
git pull
cat eval_all.tmp | xargs -n 1 -P 20 -I % ./eval.sh % read
rm ~/public_html/evalsnew.log
cat eval_all.tmp | xargs -n 1 -I % bash -c "cat %/eval.log; echo ''" > ~/public_html/evalsnew.log
