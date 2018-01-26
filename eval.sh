#!/bin/sh
# usage> foldername
folder=$1
echo "evaluating $folder"

rm -f $folder/eval.log   
framelength=$(grep -oP 'Framelength: \K\d+' $folder/scenario.scn)
minpacketsize=$(grep -oP 'lengths: range\(\K\d+' $folder/scenario.scn)
mode="write"
if [ -f $folder/all.intmdtresults.gz ]; then
  mode="read"
fi
echo "$folder: $framelength $minpacketsize mode: $mode"
python3 eval_sim/eval.py --$mode-results $folder/all.intmdtresults.gz --routerinfo $folder/routerinfo.rti --output-type key-value-pairs $folder/all.results.gz >> $folder/eval.log

echo "framelength : $framelength" >> $folder/"eval.log"
echo "packetlength : $minpacketsize" >> $folder/"eval.log"

echo "Finished $folder"

