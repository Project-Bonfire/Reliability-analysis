#!/bin/bash

design=$1
sim_scenario_config=$2
experiment_file=$3
num_processes=$4

desing_folder=$SIM_ROOT_DIR/designs/$design
echo "Used design: $desing_folder"

scenario_folder=$SIM_ROOT_DIR/scenarios/`cat $SIM_ROOT_DIR/designs/LBDR_4_flit_FIFO_Arbiter/designinfo.txt | grep -i "scenario=" | cut -d= -f2`
echo "Using scenario folder: $scenario_folder" 

if [ ! -d "$scenario_folder" ]; then
    echo "E R R O R ! Scenario name not defined!"
    exit
fi

sim_config_file=$scenario_folder/$sim_scenario_config
echo "Using simulation configuration file $sim_config_file"

if [ ! -f $sim_config_file ]; then
    echo "Simulation configuration file does not exist!"
    exit
fi

num_of_configurations=`wc -l < $sim_config_file`

# make newlines the only separator
IFS=$'\n'

# Default to 17 CPUs
if [ "$4" = "" ]; then
    num_processes=17
fi

scenario=$desing_folder/generated_files/scenario.scn

x=0
for sim_config in `cat $sim_config_file`; do
    echo "Found configuration $sim_config"
    echo

    generator_file=$scenario_folder/scenario_gen/scn_generator.py

    if [ -f $generator_file ]; then
        python3 $generator_file $sim_config $desing_folder $scenario

    else
        echo "N O T E : No scenario generator found!, not running it!"
        echo "If this is not what you intended, ensure the scenario generator is located at $scenario_folder/scenario_gen/generator.py"
    fi

    $SIM_ROOT_DIR/helper_scripts/include/run_multiple_sims.csh $scenario $desing_folder $experiment_file $num_processes

    let x++

    echo "Finished $x injection runs out of $num_of_configurations..."
done