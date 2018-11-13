#!/bin/tcsh -f
# Usage: $0 <scnfile> <desing_folder> '<faultsimline>'

if ( "$MODELSIM_ENV_SETUP" != "" ) then
    echo "Using Modelsim/Questasim setup script: $MODELSIM_ENV_SETUP"
    source $MODELSIM_ENV_SETUP
    vsim -version

    # Check if Modelsim is working
    if ("$?" == 1) then
        echo "E R R O R ! Modelsim environment not working!"
        exit
    endif

endif

set desing_folder=$SIM_ROOT_DIR/designs/$2
echo "Used design: $desing_folder"

set scenario_folder=$SIM_ROOT_DIR/scenarios/`cat $SIM_ROOT_DIR/designs/LBDR_4_flit_FIFO_Arbiter/designinfo.txt | grep -i "scenario=" | cut -d= -f2`
echo "Using scenario folder: $scenario_folder" 

if ( $scenario_folder == "") then
    echo "E R R O R ! Scenario name not defined!"
    exit
endif

set scnfile="$scenario_folder/$1"
echo "Using scenario file: $scnfile" 

if ( ! -f "$scnfile") then
    echo "E R R O R ! Scenario file '$1' not found in the scenario folder"
    exit
endif

shift
shift # take first parameter and shift it away then.

cd $SIM_ROOT_DIR/simulator/simulation

# rm -rf results/
rm -rf $SIM_ROOT_DIR/results/single

set property_path=`mktemp`
set start_id=0
set results_folder=`mktemp -d`
cp modelsim.ini $results_folder/modelsim.ini
echo "$*" >> $property_path
mkdir $SIM_ROOT_DIR/results/single

set res_folder=$desing_folder/generated_files/results/single/

if (! -d $res_folder) then
    mkdir -p $res_folder
endif

if (! -f $desing_folder/designinfo.txt) then
    echo "E R R O R ! The specified design does not have a designinfo.txt file!"
    exit
endif

# Running the simulation
(\
setenv DEBUG "true";\
setenv DESIGN_FOLDER $desing_folder;\
setenv SCENARIO_FILE $scnfile;\
setenv RESULTS_FILE $res_folder/Process1.results;\
setenv PROPERTY_PATH $property_path;\
setenv START_ID $start_id;\
setenv RESULTS_FOLDER $results_folder;\
setenv INPUT_FILE "$RESULTS_FOLDER/sent.txt";\
setenv OUTPUT_FILE "$RESULTS_FOLDER/received.txt";\
setenv VERILOG_CORELIB "$VERILOG_CORELIB";\
vsim  -modelsimini $results_folder/modelsim.ini -novopt -t 1ns -c -do simulate.do\
)

echo "Find the results here:"
echo "cd $SIM_ROOT_DIR/results/single"
echo "Tmp Folder was here:"

#this should be the last line of output, or change the code in ./setup.sh
echo "cd $results_folder"