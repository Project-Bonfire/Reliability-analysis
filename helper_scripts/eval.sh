#!/bin/sh
# usage: design [foldername]
#   design - design which to evaluate
#   foldername - name of the results folder under the design. If it is not specified, the newest folder is chosen

designfolder=$SIM_ROOT_DIR/designs/$1

if [ ! -d "$designfolder" ]; then
  echo "E R R O R ! Design $1 not found!"
  echo "Possible designs are:"
  echo
  ls -d -- $SIM_ROOT_DIR/designs/*/ | xargs -n 1 basename
  echo
  exit
fi


if [[ $2 == "" ]]; then

  if [ ! -d "$designfolder/generated_files/results/" ]; then
    echo "E R R O R ! No simulation resutlts found for design $1! Nothing to evaluate!"
    exit
  fi

  fname=`ls -t $designfolder/generated_files/results | cut -d ' ' -f 1 | head -n1`
else
  fname=$2
fi

folder=$designfolder/generated_files/results/$fname

if [ ! -d "$folder" ]; then
  echo "E R R O R ! Folder $folder does not exist or is not a folder!"
  exit
fi

echo "Evaluating $1 simulation results: $fname"
echo "Results folder: $folder"
echo

if [ -f "$folder/eval.log" ]; then
  rm -f $folder/eval.log
fi

if [ ! -f "$folder/scenario.scn" ]; then
  echo "Scenario file not found: $folder/scenario.scn"
  echo "Cannot do evaluation"
  exit
fi

framelength=$(grep -oP 'Framelength: \K\d+' $folder/scenario.scn)
minpacketsize=$(grep -oP 'lengths: range\(\K\d+' $folder/scenario.scn)

echo "Reading scenario information:"
echo -e "\tFrame length:        $framelength"
echo -e "\tMinimum packet size: $minpacketsize"

mode="write"
if [ -f $folder/all.intmdtresults.gz ]; then
  mode="read"
fi

echo "$folder - mode: $mode"
python3 $SIM_ROOT_DIR/simulator/eval_sim/eval.py --$mode-results $folder/all.intmdtresults.gz --routerinfo $folder/designinfo.txt --output-type key-value-pairs $folder/all.results.gz >> $folder/eval.log

echo "framelength : $framelength" >> $folder/"eval.log"
echo "packetlength : $minpacketsize" >> $folder/"eval.log"

echo "Finished processing of $folder"

