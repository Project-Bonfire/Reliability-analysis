#!/bin/tcsh -f
set scenario=mktemp
for $args  ("3,3 50","3,3 100", "3,3 200", "3,3 400",
            "5,5 50", "5,5 100", "5,5 200", "5,5 500",
            "10,10 100", "10,10 200", "10,10 400", 
            "20,20 200","20,20 400","20,20 800")
    set packetlengths=echo "$args" | cut -d' ' -f1
    set framelength=echo "$args" | cut -d' ' -f2
    echo "packetlength: $packetlength framelength: $framelength"
    python3 prepare_sim/scenario_gen/frame_based.py --packetlengths $packetlengths --timeframe $framelength > $scenario
    ./prepare_sim.sh 10000
    ./run_sim.sh $scenario && truncate -s 0 $scenario

end