#!/bin/sh
# small helper that counts the modules in a results file
cat simulation/routers/$1/results.txt | grep '!fifo' | wc -l | xargs echo "fifo "
cat simulation/routers/$1/results.txt | grep '!rtable' | wc -l | xargs echo "rtable "
cat simulation/routers/$1/results.txt | grep '!lbdr' | wc -l | xargs echo "lbdr "
cat simulation/routers/$1/results.txt | grep '!arbiter' | wc -l | xargs echo "arbiter "
cat simulation/routers/$1/results.txt | grep '!xbar' | wc -l | xargs echo "xbar "
cat simulation/routers/$1/results.txt | grep '!fifoc' | wc -l | xargs echo "fifoc "
cat simulation/routers/$1/results.txt | grep '!fifod' | wc -l | xargs echo "fifod "
cat simulation/routers/$1/results.txt | grep '!none' | wc -l | xargs echo "none "
cat simulation/routers/$1/results.txt | wc -l | xargs echo "total "
