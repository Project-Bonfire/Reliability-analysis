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
    echo "        $0 <design_name in designs/folder> [CELL_EXP_LOC=<cell export filename>]"
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

if [ ! -d "$design_dir" ]; then
    echo "Error: design '$1' does not exist in 'designs dir'."
    echo ""
    printHelp
fi

gen_dir=$design_dir/generated_files

if [ ! -d "$gen_dir" ]; then
    mkdir -p $gen_dir
else
    rm -rf $gen_dir
    mkdir -p $gen_dir
fi


fi_file=$gen_dir/fault_injection_info.txt
echo "Fault injection information will be stored in the following file: $fi_file"
echo "Parsing cellexport..."
python3 $SIM_ROOT_DIR/simulator/prepare_sim/cell_export_parser/convert_to_pins.py $design_dir $2 $3 --fault-info-file $fi_file
return_value=$?

echo ""
echo "Ensure that the mapping to the modules looks good."
echo ""

if [ $return_value = 1 ]; then
    echo ""
    echo "Errors detected during the run, exiting"
    exit
fi

if [ $return_value = 2 ]; then
    echo ""
    echo "D E B U G : 'None'-s were found during the run... rerunning with debugging enabled:"
    python3 $SIM_ROOT_DIR/simulator/prepare_sim/cell_export_parser/convert_to_pins.py $gen_dir $2 $3 --fault-info-file $fi_file --debug-nones
    return_value=$?
fi

if [ $return_value = 3 ]; then
    echo ""
    echo "N O T E : Simulation will be disabled when debugging! Not running simulation!"
    echo ""
    exit
fi


outfile=`mktemp`
echo ""
echo "=========================="
echo "SIMULATING TO VERIFY SETUP"
echo "=========================="
echo ""
echo "Running a single sample simulation now! If it takes very long (>2min), there might be errors. In that case, check $outfile"

# Copy the system variable to TCSH
tcsh -fc "setenv MODELSIM_ENV_SETUP `echo $MODELSIM_ENV_SETUP`"

# And run the simulation
$SIM_ROOT_DIR/helper_scripts/include/run_single_sim.csh smallsample.scn $1 '7385 3615 1 10 nofault :nofault ' > $outfile

resfoldrcommand=`tail -n 1 $outfile` #the last line of the output should be the cd command

if  [[ $resfoldrcommand == "E R R O R ! Modelsim environment not working!" ]] ;
then
    echo "Exiting..."
    exit
fi

echo "Simulation result: "
cat $outfile | grep -i error
echo ""


if  [[ $resfoldrcommand == "cd /tmp/"* ]] ;
then
    $resfoldrcommand #cd there
    rm -rf $gen_dir/moduleoutputsignals
    mkdir $gen_dir/moduleoutputsignals
    
    ls .
    
    find . -name "*.vcd" -exec /bin/sh -c "cat {} | grep -oP '[^/s]+ [^/s]+(?= .end$)' > $gen_dir/moduleoutputsignals/`basename {}`.outputs" \;
    echo "Created $1/moduleoutputsignals folder, please verify that the module output signals are captured correctly!"
    
else
    echo ""
    echo "Error: could not find resultfolder of the sample simulation! (command was: $resfoldrcommand)"
    echo ""
fi

rm $outfile
echo ""
echo "A T T E N T I O N : Please read the output carefully, to ensure the design was setup the way you want."
echo ""

