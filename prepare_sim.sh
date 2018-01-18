#!/bin/sh
 if [ "$1" = "" ];  then
    echo "Usage: $0 <routername in simulation/routers>"
    exit
fi
python prepare_sim/sim_run_creator/sim_run_creator.py simulation/routers/$1/results.txt --module-representative-numbers 0 > ./sim_runs

