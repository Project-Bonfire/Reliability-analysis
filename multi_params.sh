#!/bin/sh -e
#The first argument is the name of the matrix file

if [ "$1" = "" ];  then
    echo "Usage: $0 <matrix file>"
    exit
fi

curavg=`uptime | cut -d : -f 4 | cut -d ' ' -f 2 |tr -s ' '| cut -d . -f 1| cut -d , -f 1`
curavg+=1
limit=20
num_processes=13

matrixfile=`readlink -e $1`
echo "Outputfile for the matrix is $matrixfile"
touch $matrixfile
echo "Num Processes: $num_processes"
scenario=`mktemp`
for args in  "3,4 70" "3,4 100" "3,4 150" "3,4 200" "3,4 400"  "5,6 100" "5,6 130" "5,6 150" "5,6 200" "5,6 400" "10,11 150" "10,11 200" "10,11 300" "10,11 400" "20,21 300" "20,21 400" "20,21 600" "20,21 800"  ; do
    packetlength=`cut -d' ' -f1 <<< "$args"`
    framelength=`cut -d' ' -f2 <<< "$args"`
    minpacketsize=`cut -d',' -f1 <<< "$args"`
    echo "$args: packetlength: $packetlength framelength: $framelength "
    echo -n > $scenario
    python3 prepare_sim/scenario_gen/frame_based.py --packetlength $packetlength --timeframe $framelength >$scenario
    ./run_sim.sh $scenario $num_processes;
    foldername=`ls -t results | head -n1` #select newest
    echo "evaluating $foldername"
    python3 eval_sim/eval.py --output-type single_line results/$foldername/all.results.gz >> results/$foldername/eval.log
    percentage=`cat results/$foldername/eval.log | cut -d' ' -f3`
    echo "$minpacketsize $framelength $percentage" >> $matrixfile
done