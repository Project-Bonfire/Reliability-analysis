#!/bin/sh -e
if [ "$1" = "" ];  then
    echo "Usage: $0 <simparameter string> <routername> <num_processes>"
    echo ""
    echo "possible router names:"
    ls  simulation/routers
    exit
fi


num_processes=17
if [ "$3" = "" ];  then
    num_processes=$3
fi

echo "Num Processes: $num_processes"
scenario=`mktemp`
simruns=`mktemp`

echo ""
echo "Preparing sim:"
./prepare_sim.sh $2 $simruns
echo ""
#


args=$1

packetlength=`cut -d' ' -f1 <<< "$args"`
    framelength=`cut -d' ' -f2 <<< "$args"`
    minpacketsize=`cut -d',' -f1 <<< "$args"`


    python3 prepare_sim/scenario_gen/frame_based.py --packetlength $packetlength --timeframe $framelength >$scenario
    ./run_sim.sh $scenario $2 $simruns $num_processes;
    continue
    foldername=`ls -t results | head -n1` #select newest
    echo "evaluating $foldername"
    echo "Eval start:" >> results/$foldername/"stats.txt"
    echo `date +%Y-%m-%d.%H:%M:%S` >> results/$foldername/"stats.txt"
    python3 eval_sim/eval.py --write-results results/$foldername/all.intmdtresults.gz --output-type key-value-pairs results/$foldername/all.results.gz >> results/$foldername/eval.log
    echo "Eval end:" >> results/$foldername/"stats.txt"
    echo "packetlength : $packetlength" >> results/$foldername/"eval.log"
    echo "framelength : $framelength" >> results/$foldername/"eval.log"
    echo "packetlength : $minpacketsize" >> results/$foldername/"eval.log"
    echo `date +%Y-%m-%d.%H:%M:%S` >> results/$foldername/"stats.txt"

