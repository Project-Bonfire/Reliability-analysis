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

set property_path=`mktemp`
set start_id=0
set temp_folder=`mktemp -d`
cp modelsim.ini $temp_folder/modelsim.ini
echo "$*" >> $property_path

set res_folder=$desing_folder/generated_files/results/single/


if (-d $res_folder) then
    rm -rf $res_folder
endif

mkdir -p $res_folder

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
setenv RESULTS_FOLDER $res_folder;\
setenv INPUT_FILE "$res_folder/sent.txt";\
setenv OUTPUT_FILE "$res_folder/received.txt";\
setenv VERILOG_CORELIB "$VERILOG_CORELIB";\
vsim  -modelsimini $temp_folder/modelsim.ini -novopt -t 1ns -c -do simulate.do\
)

echo "Find the results here:"
echo "cd $res_folder"
echo "Tmp Folder was here:"

#this should be the last line of output, or change the code in ./setup.sh
echo "cd $temp_folder"
