#!/bin/sh -e
if [ "$1" = "" ];  then
    echo "Usage: $0 <simname> <routername> <numproc>"
    echo ""
    echo "possible router names:"
    ls  simulation/routers
    exit
fi
if [ "$2" = "" ];  then
    echo "Usage: $0 <simname> <routername> <numproc>"
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
for args in "3,4 60" "3,4 80" "3,4 100" "3,4 150" "3,4 200" "3,4 400" "3,4 800" "5,6 100" "5,6 120" "5,6 130" "5,6 150" "5,6 200" "5,6 400" "5,6 800" "10,11 250" "10,11 270" "10,11 290" "10,11 300" "10,11 400" "10,11 800" "20,21 350" "20,21 390" "20,21 400"  "20,21 500"  "20,21 600"  "20,21 800" "50,51 650" "50,51 700" "50,51 750" "50,51 800";  do


    packetlength=`cut -d' ' -f1 <<< "$args"`
    framelength=`cut -d' ' -f2 <<< "$args"`
    minpacketsize=`cut -d',' -f1 <<< "$args"`
    echo "$args: packetlength: $packetlength framelength: $framelength "
    echo -n > $scenario
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
    echo "" >> ~/www/evalsnew.log
    cat results/$foldername/"eval.log" >> ~/www/evals.log
    #percentage=`cat results/$foldername/eval.log | cut -d' ' -f3`
    #echo "$minpacketsize $framelength $percentage" >> $matrixfile
    #rm ~/www/matrix.png
    #gnuplot -c ./plot_fault_rates.plt > ~/www/matrix.png
done