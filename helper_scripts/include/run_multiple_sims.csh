#!/bin/tcsh -f

echo "=========="
echo "SIMULATION"
echo "=========="
echo
echo "Running a set of simulations..."

set scenario=$1
set design_folder=$2
set experiment_file=$3
set num_processes=$4

echo "Scenario file:                $scenario"
echo "Design folder:                $design_folder"
echo "Number of simulation runs:    $experiment_file"
echo "Number of parallel processes: $num_processes"
echo

if ( ! -f "$scenario") then
    echo "E R R O R ! Scenario file '$scenario' not found!"
    echo "Usage $0 <scenario_file> <design_folder> <experiment_file> <num_processes>"
    exit
endif

# shift

if ( ! -d "$design_folder" ) then
    echo "E R R O R ! Design folder '$design_folder' not found!"
    echo "Usage $0 <scenario_file> <design_folder> <experiment_file> <num_processes>"
    exit
endif

# shift

if ( ! -f "$experiment_file" ) then
    echo "E R R O R ! experiment_file file '$experiment_file' not found!"
    echo "Usage $0 <scenario_file> <design_folder> <experiment_file> <num_processes>"
    exit
endif


# shift

if ( "$num_processes" == "" ) then 

    echo "Usage $0 <scenariofile> <routername> <experiment_file> <num_processes>"
    echo "Automatically determining how many processes should be launched!"
    # dont know when its . when , at the last part . so cutting both
    @ curavg = `uptime | cut -d : -f 4 | cut -d ' ' -f 2 |tr -s ' '| cut -d . -f 1| cut -d , -f 1`
    @ curavg += 1
    set limit = 20
    set num_processes = `echo "$limit-$curavg"|bc`
    echo "Current load average is taken as: $curavg."
    echo "Estimating limit for the average of $limit."
    echo "Predicted that the limit will be satisfied with $num_processes processes!"
    echo
else
    set num_processes = $num_processes
endif

echo "Processes to spawn: $num_processes!"
echo
echo "Design: $design_folder"
echo "Scenario: $scenario"
echo "Experiments file: $experiment_file"
echo


# Setup Modelsim
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


# Setup directories
set gen_dir=$design_folder/generated_files

if ( ! -d "$gen_dir" ) then
    mkdir $gen_dir
endif

set results_dir=$gen_dir/results

if ( -d "$results_dir" ) then
    rm -rf $results_dir
endif

mkdir $results_dir

set curtime=`date +%Y-%m-%d.%H:%M:%S`
cd $SIM_ROOT_DIR/simulator/simulation

set i=0
set designinfo=`readlink -f $design_folder/designinfo.txt`

mkdir "$results_dir/$curtime"
mkdir "$results_dir/$curtime/results"

set num_experiments=`wc -l <$experiment_file`
set per_proc=`python -c "from math import ceil;print ('%d'%ceil($num_experiments/float($num_processes)))"`

echo
echo "Running $num_experiments experiments with $num_processes parallel processes -> $per_proc simulations per process."
echo

set cleanupdirs=""
@ x = 1

echo "----------------------"
echo "Staring simulations..."
echo "----------------------"

# Start the timer
set start_time="`date +%s`"
echo

#Launch number of requested processes
while ($x <= $num_processes)
    
    set propertypath=`mktemp`
    set startid=`echo "($x-1)*$per_proc" | bc`
    set startline=`echo "($x-1)* $per_proc+1"|bc`
    set endline=`echo "$startline+$per_proc-1"|bc`

    echo "Starting process $x, Startid: $startid"

    #sed -n 1,${i}p < experiment_file > /tmp/test
    # Create a tmpfile which contains the experiment parameters for this instance

    sed -n ${startline},${endline}p  < $experiment_file >> $propertypath
    set resultfolder=`mktemp -d`
    
    set cleanupdirs="$cleanupdirs $propertypath $resultfolder"
    cp modelsim.ini $resultfolder/modelsim.ini

    echo "Results for this process will be stored in $resultfolder"

    # Launch an instance of vsim, create tmp folders and seperate modelsim.ini - s for each instance, to prevent race conditions.
#     (setenv ROUTERFOLDER $design_folder;setenv SCENARIOFILE $scenario;setenv RESULTFILE ../results/$curtime/results/Process${x}.results;setenv PROPERTYPATH $propertypath; setenv STARTID $startid; setenv RESULTFOLDER $resultfolder; /usr/bin/nice -n 15 vsim -modelsimini $resultfolder/modelsim.ini -novopt -t 1ns -c -do simulate.do  >../results/$curtime/Process${x}out.log )&
    
    # Prevents a race condition when copying library work to tmp folder
    sleep 2
    @ x += 1
    
    echo
end


echo "--------------------"
echo "Finished $num_experiments experiments on $num_processes processes with $per_proc experiments per process"
echo
wait

# Stop the time and calculate time spent
set stop_time="`date +%s`"
set time_spent=`python -c "print ($stop_time - $start_time)"`
echo "Time spent: `date -d@$time_spent -u +%H:%M:%S`"
echo

cd "$results_dir/$curtime"
echo "num_experiments: $num_experiments" >> "stats.txt"
echo "num_processes: $num_processes" >> "stats.txt"
echo "started: $curtime" >> "stats.txt"
echo "finished: `date +%Y-%m-%d.%H:%M:%S`" >> "stats.txt"
echo `uptime | cut -d : -f 4` >> "stats.txt"
cp "$scenario" scenario.scn
cp "$designinfo" designinfo.txt

# Concatinate all results to one single file

cat results/* > all.results
rm -rf "results"
gzip all.results
rm -rf $cleanupdirs

pwd

echo "D E B U G : No actual simulations were run"
