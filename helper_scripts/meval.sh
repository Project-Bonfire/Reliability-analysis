#!/bin/sh
design=$1
explst=$2
num_processes=$3
force_write=$4

if [ ! -f $EXPLST_FILE ]; then
    echo "E R R O R! Experiment list file specified in the parameters does not exist!"
    echo "Valid experimet list files are:"
    ls $DESIGN_DIR/generated_files/results/*.explst
    exit
fi

if [ "$force_write" = "" ]; then
    force_write=0
fi

echo
echo "FORCE WRITING=$force_write"
echo

explst_file_name=`basename $explst`
explst_name=${explst_file_name%???????}

if [ "$explst" = "" ] || [ "$design" = "" ];  then
    echo "Usage: $0 <DESIGN> <EXPLST_FILE> <NUM_EVAL_PROC> <FORCE_WRITE>"
    echo ""
    echo "Experiment lists found for the current design:"
    ls $DESIGN_DIR/generated_files/results/*.explst
    exit
fi

DESIGN_DIR=$SIM_ROOT_DIR/designs/$design

# Experiment
echo "List of experiments:"
echo "--------------------"
cat $explst

num_experiments=`wc -l <$explst`

per_proc=`python -c "from math import ceil;print ('%d'%ceil($num_experiments/float($num_processes)))"`

echo
echo "----------------------"
echo "Staring evaluations..."
echo "----------------------"

# Start the timer
start_time="`date +%s`"
echo
echo "Evaluation started at `date -d@$start_time -u +%H:%M:%S`"
echo

export FW=$force_write

for(( i=1; i<=$num_processes; ++i )) do

    proc_exp_file=`mktemp`

    startid=`echo "($i-1)*$per_proc" | bc`
    startline=`echo "($i-1)*$per_proc+1"|bc`
    endline=`echo "$startline+$per_proc-1"|bc`


    echo "Starting process $i, Startid: $startid"

    head -n $endline $explst | tail -n $per_proc >> $proc_exp_file

    # Process the file
    cat $proc_exp_file | xargs -n 1 -l bash -c '$SIM_ROOT_DIR/helper_scripts/eval.sh `echo $DESIGN_DIR | rev | cut -d/ -f1 | rev` $0' &



done

# sleep 5

echo
echo "--------------------"
echo "Running $num_experiments evaluations on $num_processes processes with $per_proc evaluations per process..."
echo "This will take a while..."
echo "--------------------"

wait # Wait for all processes to finish

# Stop the time and calculate time spent
stop_time="`date +%s`"
time_spent=`python -c "print ($stop_time - $start_time)"`

echo
echo "--------------------"
echo "All done!"
echo "Time spent on Evaluation: `date -d@$time_spent -u +%H:%M:%S`"
echo

evals_file=$DESIGN_DIR/generated_files/results/evals_$explst_name.json

if [ -f "$evals_file" ]; then
    rm -f $evals_file
fi

touch $evals_file

python3 $SIM_ROOT_DIR/simulator/eval_sim/json_join.py --resultsDir $DESIGN_DIR/generated_files/results --exptlstFile $explst --evalsFile $evals_file

echo "=============================================="
echo "Saved all evaluation results to $evals_file"
