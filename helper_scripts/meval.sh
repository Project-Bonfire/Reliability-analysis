#!/bin/sh
design=$1
explst=$2


explst_file_name=`basename $explst`
explst_name=${explst_file_name%???????}

if [ "$explst" = "" ] || [ "$design" = "" ];  then
    echo "Usage: $0 <DESIGN> <EXPLST_FILE>"
    echo ""
    echo "Experiment lists found for the current design:"
    ls $DESIGN_DIR/generated_files/results/*.explst
    exit
fi

DESIGN_DIR=$SIM_ROOT_DIR/designs/$design

cat $explst | xargs -n 1 -l bash -c '$SIM_ROOT_DIR/helper_scripts/eval.sh `echo $DESIGN_DIR | rev | cut -d/ -f1 | rev` $0'

evals_file=$DESIGN_DIR/generated_files/results/evals_$explst_name.json

if [ -f "$evals_file" ]; then
    rm -f $evals_file
fi

touch $evals_file

python3 $SIM_ROOT_DIR/simulator/eval_sim/analyzer.py --resultsDir $DESIGN_DIR/generated_files/results --exptlstFile $explst --evalsFile $evals_file
# cat $explst | xargs -n 1 -I % bash -c "cat $DESIGN_DIR/generated_files/results/%/eval.log; echo ''" > $evals_file

echo "=============================================="
echo "Saved all evaluation results to $evals_file"
