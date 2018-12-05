#!/bin/sh
# Parses the analyzed cell reports and generates a set of fault injection experiments, by injecting
# faults at random times at random injection points, which were collected previously by the
# design setup tool

printHelp ()
{
    echo "Usage:"
    echo "    When running from Makefile:"
    echo "        make prepare DESIGN=<design_name in designs/folder> [OUTPUT_FILE=<output file>]"
    echo ""
    echo "    When running the script directly:"
    echo "        $0 <design_name in designs/folder> <output file>"
    echo ""
    echo "The following designs exist:"
    ls $SIM_ROOT_DIR/designs
    echo ""
    exit
}

echo "Preparing simulation...."
echo "------------------------"

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

gen_dict=$SIM_ROOT_DIR/designs/$1/generated_files

if [ ! -d $gen_dict ]; then
    echo "The design $1 is not properly set up yet"
    echo "Please setup the design first by running \"make setup DESIGN=$1\""
    exit
fi

if [ "$2" = "" ]; then
    experiments_file=$gen_dict/experiments.txt
else
    experiments_file=$2
fi

python3 $SIM_ROOT_DIR/simulator/prepare_sim/sim_run_creator/sim_run_creator.py $gen_dict/results.txt $experiments_file 0 --module-representative-numbers --cooldown-time 4000
