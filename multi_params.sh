#!/bin/sh -e
#The first argument is the name of the matrix file

if [ "$1" = "" ];  then
    echo "Usage: $0 <matrix file>"
    exit
fi


num_processes=17

matrixfile=`readlink -f $1`
echo "Outputfile for the matrix is $matrixfile"
touch $matrixfile
echo "Num Processes: $num_processes"
scenario=`mktemp`
for args in "3,4 70" "3,4 90" "3,4 120" "3,4 300" "3,4 500" "3,4 600" "3,4 700" "5,6 110" "5,6 140" "5,6 190" "5,6 300" "5,6 500" "5,6 600" "5,6 700" "10,11 270" "10,11 350" "10,11 500" "10,11 700" "20,21 370" "20,21 420" "20,21 500" "20,21 700" "30,31 580" "30,31 580" "30,31 590" "30,31 610"; do
#"3,4 150" "3,4 70" "3,4 100" "3,4 150" "3,4 200" "3,4 400"  "5,6 100" "5,6 130" "5,6 150" "5,6 200" "5,6 400" "10,11 160" "10,11 200" "10,11 300" "10,11 400" "20,21 300" "20,21 400" "20,21 600" "20,21 800" "20,21 290" "3,4 80" "3,4 90" "3,4 110" "3,4 120" "3,4 130" "3,4 140" "3,4 250" "3,4 300" "3,4 350" "3,4 500" "3,4 600" "3,4 700" "3,4 800" "5,6 110" "5,6 120" "5,6 140" "5,6 160" "5,6 170" "5,6 180" "5,6 190" "5,6 300" "5,6 500" "5,6 600" "5,6 700" "5,6 800" "10,11 170" "10,11 180" "10,11 190" "10,11 220" "10,11 240" "10,11 250" "10,11 270" "10,11 290" "10,11 350" "10,11 450" "10,11 500" "10,11 600" "10,11 700" "10,11 800"; do"40,41 650" "40,41 800" "40,41 700" "15,16 250" "15,16 300" "15,16 400" "15,16 800" "10,11 250" "20,21 290" "20,21 280" "3,4 100" 

    packetlength=`cut -d' ' -f1 <<< "$args"`
    framelength=`cut -d' ' -f2 <<< "$args"`
    minpacketsize=`cut -d',' -f1 <<< "$args"`
    echo "$args: packetlength: $packetlength framelength: $framelength "
    echo -n > $scenario
    python3 prepare_sim/scenario_gen/frame_based.py --packetlength $packetlength --timeframe $framelength >$scenario
    ./run_sim.sh $scenario $num_processes;
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