#!/bin/sh

# An helper script for setting up new designs
# Usage - setup_sim.sh <router name> [cell export file]

printHelp ()
{
    echo "Usage:"
    echo "    When running from Makefile:"
    echo "        make setup DESIGN=<design_name in designs/folder> [CELL_EXP_LOC=<cell export filename>]"
    echo ""
    echo "    When running the script directly:"
    echo "        $0 <design_name in designs/folder> [<cell export filename>]"
    echo ""
    echo "The following designs exist:"
    ls $SIM_ROOT_DIR/designs
    echo ""
    exit
}

if [ -z "$SIM_ROOT_DIR" ]; then
    echo "Environment variable SIM_ROOT_DIR not defined! It should be pointing to the root of the repo."
    exit
fi 

echo $SIM_ROOT_DIR
if [ ! -d $SIM_ROOT_DIR/helper_scripts ]; then
    echo "The SIM_ROOT_DIR environment variable points to a wrong folder. Please run the makefile from the root folder."
    exit
fi

if [ "$1" = "" ];  then
    printHelp
fi

echo "Processing design $1"

design_dir=`readlink -f $SIM_ROOT_DIR/designs/$1/`
params="$SIM_ROOT_DIR/designs/$1/"
if [ ! -d "$params" ]; then
    echo "Error: design '$1' does not exist in 'designs dir'."
    echo ""
    printHelp
fi

if [ "$2" == "" ];  then
    params+=" --cellexport Cells_Report_with_Connections_Verbose.txt"
else
    params+=" --cellexport $2"
fi

fi_file=$design_dir/fault_injection_info.txt
echo "Fault injection information will be stored in the following file: $fi_file"
echo "Parsing cellexport..."
python3 $SIM_ROOT_DIR/simulator/prepare_sim/cell_export_parser/convert_to_pins.py $params --fault-info-file $fi_file

echo ""
echo "Ensure that the mapping to the modules looks good."
echo ""

outfile=`mktemp`
echo ""
echo "=========================="
echo "SIMULATING TO VERIFY SETUP"
echo "=========================="
echo ""
echo "Running a single sample simulation now! If it takes very long (>2min), there might be errors. In that case, check $outfile"
$SIM_ROOT_DIR/helper_scripts/run_single_sim.csh smallsample.scn $1 '7385 3615 1 10 nofault :nofault ' > $outfile

echo "Simulation result: "
cat $outfile | grep -i error
echo ""

resfoldrcommand=`tail -n 1 $outfile` #the last line of the output should be the cd command
if  [[ $resfoldrcommand == "cd /tmp/"* ]] ;
then
    $resfoldrcommand #cd there
    rm -rf $design_dir/moduleoutputsignals
    mkdir $design_dir/moduleoutputsignals
    
    ls .
    
    find . -name "*.vcd" -exec /bin/sh -c "cat {} | grep -oP '[^/s]+ [^/s]+(?= .end$)' > $design_dir/moduleoutputsignals/`basename {}`.outputs" \;
    echo "Created $1/moduleoutputsignals folder, please verify that the module output signals are captured correctly!"
    
else
    echo ""
    echo "Error: could not find resultfolder of the sample simulation! (command was: $resfoldrcommand)"
    echo ""
fi

rm $outfile
echo ""
echo "A T T E N T I O N : Please read the output carefully, to ensure the design was setup the way you want."
