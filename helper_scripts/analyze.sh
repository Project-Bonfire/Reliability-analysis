#!/bin/sh

designfolder=$SIM_ROOT_DIR/designs/$1
results_folder=$designfolder/generated_files/results
resultsfile=$results_folder/$2

if [ ! -d "$designfolder" ]; then
  echo "E R R O R ! Design $1 not found!"
  echo "Possible designs are:"
  echo
  ls -d -- $SIM_ROOT_DIR/designs/*/ | xargs -n 1 basename
  echo
  exit
fi


if [ ! -d "$results_folder" ]; then
  echo "E R R O R ! No simulation resutlts found for design $1! Nothing to evaluate!"
  exit
fi

if [ ! -f "$resultsfile" ]; then
  echo "E R R O R ! Specified results file not found! Valid results files are:"
  ls $results_folder | grep json
  exit
fi

python3 $SIM_ROOT_DIR/simulator/eval_sim/analyzer.py --resultsFolder $results_folder --resultsFile $resultsfile 
