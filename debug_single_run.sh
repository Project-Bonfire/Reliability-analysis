#!/bin/sh -e

export SIM_ROOT_DIR=`pwd`

if [ "$1" = "" ];  then
    echo "Usage: $0 <simparameter string> <designname> <num_processes>"
    echo ""
    echo "possible design names:"
    ls  designs/
    exit
fi


num_processes=17
if [ "$3" != "" ];  then
    num_processes=$3
fi


echo "Num Processes: $num_processes"
echo "Design Name: $2"

design_dir=$SIM_ROOT_DIR/designs/$2
gen_dir=$design_dir/generated_files

exp_file=$gen_dir/experiments.txt

echo ""
echo "====================="
echo "Preparing simulation:"
echo "====================="
$SIM_ROOT_DIR/helper_scripts/prepare_sim.sh $2 $exp_file
echo ""



args=$1
scenario=`mktemp`
echo "Scenario file: $scenario"

echo "==================="
echo "Scenario generation"
echo "==================="

packetlength=`cut -d' ' -f1 <<< "$args"`
framelength=`cut -d' ' -f2 <<< "$args"`
minpacketsize=`cut -d',' -f1 <<< "$args"`

echo $packetlength
echo $framelength
echo $minpacketsize

python3 $SIM_ROOT_DIR/simulator/prepare_sim/scenario_gen/frame_based.py --packetlength $packetlength --timeframe $framelength > $scenario

echo "=================="
echo "Running simulation"
echo "=================="
./run_sim.sh $scenario $2 $exp_file $num_processes;

# foldername=`ls -t results | head -n1` #select newest

# echo "=========="
# echo "Evaluation"
# echo "=========="

# echo "evaluating $foldername"
# echo "Eval start:" >> results/$foldername/"stats.txt"
# echo `date +%Y-%m-%d.%H:%M:%S` >> results/$foldername/"stats.txt"
# python3 eval_sim/eval.py --write-results results/$foldername/all.intmdtresults.gz --output-type key-value-pairs results/$foldername/all.results.gz >> results/$foldername/eval.log

# echo "=========="
# echo "Statistics"
# echo "=========="

# echo "Eval end:" >> results/$foldername/"stats.txt"
# echo "packetlength : $packetlength" >> results/$foldername/"eval.log"
# echo "framelength : $framelength" >> results/$foldername/"eval.log"
# echo "packetlength : $minpacketsize" >> results/$foldername/"eval.log"
# echo `date +%Y-%m-%d.%H:%M:%S` >> results/$foldername/"stats.txt"
