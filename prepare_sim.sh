#!/bin/sh

 if [ "$1" = "" ];  then
    echo "Usage: $0 <routername in simulation/routers> <output file>"
    exit
fi
 if [ "$2" = "" ];  then
    echo "Usage: $0 <routername in simulation/routers> <output file>"
    exit
fi
python3 prepare_sim/sim_run_creator/sim_run_creator.py simulation/routers/$1/results.txt $2 0 --module-representative-numbers

