#!/bin/sh
# usage: design [foldername]
#   design - design which to evaluate
#   foldername - name of the results folder under the design. If it is not specified, the newest folder is chosen

#  for i; do 
#     echo $i 
#  done

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

  dname=`ls -t $designfolder/generated_files/results | cut -d ' ' -f 1 | head -n1`
else
  dname=$2
fi

folder=$designfolder/generated_files/results/$dname

if [ ! -d "$folder" ]; then
  echo "E R R O R ! Folder $folder does not exist or is not a folder!"
  exit
fi

echo "Evaluating $1 simulation results: $dname" > $folder/eval.log
echo "Results folder: $folder" >> $folder/eval.log
echo >> $folder/eval.log

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

echo "Reading scenario information:" >> $folder/eval.log
echo -e "\tFrame length:        $framelength" >> $folder/eval.log
echo -e "\tMinimum packet size: $minpacketsize" >> $folder/eval.log

mode="write"
if [ -f $folder/all.intmdtresults.gz ]; then
  if [ "$FW" == 0 ]; then
    mode="read"
  fi
fi

echo "$dname - mode: $mode" >> $folder/eval.log
echo >> $folder/eval.log


python3 -u $SIM_ROOT_DIR/simulator/eval_sim/eval.py $folder/all.results.gz \
        --$mode-experiments $folder/all.intmdtresults.gz \
        --fi-info $designfolder/generated_files/fault_injection_info.txt \
        --framelength $framelength \
        --packetlength $minpacketsize \
        --verbose \
        --output-file $folder/eval.json > $folder/eval.log

error_count=`cat $folder/eval.log | grep "E R R O R:" | wc -l`
warn_count=`cat $folder/eval.log | grep "W A R N I N G:" | wc -l`

echo -e "\nF I N I S H: Finished processing $folder:\n \
    logfile: $folder/eval.log\n \
    Errors: $error_count, warnings: $warn_count\n"

