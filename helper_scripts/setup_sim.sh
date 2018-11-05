#!/bin/sh

# helper for setting up new routers.
# Usage - setup_sim.sh <router name> [cell export file]

if [ "$1" = "" ];  then
    echo "Usage: $0 <routername in simulation/routers>"
    echo ""
    echo "The following routers exist:"
    ls simulation/routers
    echo ""
    exit
fi

routerdir=`readlink -f simulation/routers/$1/`
params="simulation/routers/$1/"
if [ ! -d "$params" ]; then
    echo "Error: router '$1' does not exist in 'simulation/routers'."
    echo ""
    echo "The following routers exist:"
    ls simulation/routers
    echo ""
    echo "Usage: $0 <routername in simulation/routers>"
    exit
fi

if [ "$2" == "" ];  then
    params+=" --cellexport Cells_Report_with_Connections_Verbose.txt"
fi

if [ "$2" != "" ];  then
    params+=" --cellexport $2"
fi

outfile=`mktemp`
echo "Cell export parser output will be saved to the temp file: $outfile"
echo "Parsing cellexport..."
python3 prepare_sim/cell_export_parser/convert_to_pins.py $params --temp-file $outfile

echo ""
echo "Ensure that the mapping to the modules looks good."
echo ""

# if [ ! -f "$routerdir/routerinfo.rti" ]; then
#     echo "Creating routerinfo.rti for this router. See the file below and ensure its correct:"
    
#     head -n 3 $outfile > "$routerdir/routerinfo.rti"
#     echo 'ralgo="XYRouting"'>> "$routerdir/routerinfo.rti"
#     echo "info='$1'">> "$routerdir/routerinfo.rti"
#     cat $routerdir/routerinfo.rti
#     echo ""
# else
#     echo "Routerinfo.rti already exists. Please make sure that the data is up to date. See the diff below"
    
#     head -n 3 $outfile > $outfile.tmp
#     rm $outfile
#     mv $outfile.tmp $outfile
#     cat $outfile
#     diff $routerdir/routerinfo.rti $outfile
#     echo ""
# fi

# echo "running sample simulation now! If it takes very long (>2min), there might be errors. Check $outfile then."
# ./run_single_sim.csh scenarios/smallsample.scn $1 '7385 3615 1 10 nofault :nofault ' > $outfile
# resfoldrcommand=`tail -n 1 $outfile` #the last line of the output should be the cd command
# if  [[ $resfoldrcommand == "cd /tmp/"* ]] ;
# then
#     $resfoldrcommand #cd there
#     rm -rf $routerdir/moduleoutputsignals
#     mkdir $routerdir/moduleoutputsignals
    
#     ls .
    
#     find . -name "*.vcd" -exec /bin/sh -c "cat {} | grep -oP '[^/s]+ [^/s]+(?= .end$)' > $routerdir/moduleoutputsignals/`basename {}`.outputs" \;
#     echo "Created $1/moduleoutputsignals folder, please verify that the module output signals are captured correctly!"
    
# else
#     echo ""
#     echo "Error: could not find resultfolder of the sample simulation! (command was: $resfoldrcommand)"
#     echo ""
# fi

# rm $outfile
# echo "Please read the output carefully, to ensure the router was setup the way you want."
