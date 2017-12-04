#!/bin/sh -e

curavg=`uptime | cut -d : -f 4 | cut -d ' ' -f 2 |tr -s ' '| cut -d . -f 1| cut -d , -f 1`
curavg+=1
limit=20
num_processes=`echo "$limit-$curavg"|bc`

scenario=mktemp
for args in  "3,4 50" "3,4 100" "3,4 200" "3,4 400" "5,6 50" "5,6 100" "5,6 200" "5,6 500" "10,11 100" "10,11 200" "10,11 400" "20,21 200" "20,21 400" "20,21 800"  ; do
    packetlength=`cut -d' ' -f1 <<< "$args"`
    framelength=`cut -d' ' -f2 <<< "$args"`
    echo "$args: packetlength: $packetlength framelength: $framelength "
    echo -n > $scenario
    python3 prepare_sim/scenario_gen/frame_based.py --packetlength $packetlength --timeframe $framelength >$scenario
    ./run_sim.sh $scenario 13;

done