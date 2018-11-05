#!/bin/tcsh -f
set scnfile=`readlink -f $1`
if ( ! -f "$scnfile" ) then
echo " scnfile: $scnfile "
    echo "Usage $0 <scenariofile> <routername> <sim_runs> <num_processes>"
    exit
endif

shift
set routerfile="routers/$1"
if ( ! -d "simulation/$routerfile" ) then
echo " scnfile: $scnfile routername: $routerfile "
    echo "Usage $0 <scenariofile> <routername> <sim_runs> <num_processes>"
    exit
endif
shift
set simruns="$1"
if ( ! -f "$simruns" ) then
echo " scnfile: $scnfile routername: $routerfile simrunfile: $simruns"
    echo "Usage $0 <scenariofile> <routername> <sim_runs> <num_processes>"
    exit
endif

shift
if ( "$1" == "" ) then 
     # parentheses not strictly needed in this simple case
    echo "Usage $0 <scenariofile> <routername> <sim_runs> <num_processes>"
    echo "Automatically determining how many processes should be launched!"
    # dont know when its . when , at the last part . so cutting both
    @ curavg = `uptime | cut -d : -f 4 | cut -d ' ' -f 2 |tr -s ' '| cut -d . -f 1| cut -d , -f 1`
    @ curavg += 1
    set limit = 20
    set num_processes = `echo "$limit-$curavg"|bc`
    echo "Current load average is taken as: $curavg."
    echo "Estimating limit for the average of $limit."
    echo "Predicted that the limit will be satisfied with $num_processes processes!"
    echo ""
else
    set num_processes = $1
endif

echo "Processes to spawn: $num_processes! scnfile: $scnfile routername: $routerfile simrunfile: $simruns"
echo ""


#source /cad/unsetenvs.csh
setenv PATH /bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin
setenv MANPATH /usr/man:/usr/share/man:/usr/local/man:/usr/local/share/man

setenv M_16_EDA

#source /cad/cadrc.include_new
#          echo " "
#          echo "Environment ready for Mentor Graphics 2016 EDA version."
#          echo " "
#          breaksw

source /eda/mentor/2015-16/scripts/QUESTA-SV-AFV_10.4c-5_RHELx86.csh


set curtime=`date +%Y-%m-%d.%H:%M:%S`
cd simulation
rm -rf results/
mkdir results
set i=0
set routerinfo=`readlink -f $routerfile/routerinfo.rti`
mkdir "../results/$curtime"
mkdir "../results/$curtime/results"
set num_experiments=`wc -l <$simruns`
set per_proc=`python -c "from math import ceil;print ('%d'%ceil($num_experiments/float($num_processes)))"`
echo "$per_proc tasks per process."
set cleanupdirs=""
@ x = 1
#Launch number of requested processes
while ($x <= $num_processes)
    
    set propertypath=`mktemp`
    set startid=`echo "($x-1)*$per_proc" | bc`
    set startline=`echo "($x-1)* $per_proc+1"|bc`
    set endline=`echo "$startline+$per_proc-1"|bc`
    echo "Startid: $startid"
    #sed -n 1,${i}p < sim_runs > /tmp/test
    # create tmpfile which contains the experiment parameters for this instance
    sed -n ${startline},${endline}p  < $simruns >> $propertypath
    set resultfolder=`mktemp -d`
    set cleanupdirs="$cleanupdirs $propertypath $resultfolder"
    cp modelsim.ini $resultfolder/modelsim.ini
    echo $resultfolder
    #launch vsim instance, create tmp folders and seperate modelsiminis for each instance, to prevent race conditions.
    (setenv ROUTERFOLDER $routerfile;setenv SCENARIOFILE $scnfile;setenv RESULTFILE ../results/$curtime/results/Process${x}.results;setenv PROPERTYPATH $propertypath; setenv STARTID $startid; setenv RESULTFOLDER $resultfolder; /usr/bin/nice -n 15 vsim -modelsimini $resultfolder/modelsim.ini -novopt -t 1ns -c -do simulate.do  >../results/$curtime/Process${x}out.log )&
    # prevents race condition when copying library work to tmp folder
    sleep 2
    @ x += 1
end
echo "$num_experiments runs on $num_processes processes with $per_proc experiments per process"
wait

cd "../results/$curtime"
echo "num_experiments: $num_experiments" >> "stats.txt"
echo "num_processes: $num_processes" >> "stats.txt"
echo "started: $curtime finished: " >> "stats.txt"
echo `date +%Y-%m-%d.%H:%M:%S` >> "stats.txt"
echo `uptime | cut -d : -f 4` >> "stats.txt"
cp "$scnfile" scenario.scn
cp "$routerinfo" routerinfo.rti
#concat all results to one single file
cat results/* > all.results
rm -rf "results"
gzip all.results
rm -rf $cleanupdirs
#write stats.txt file


echo "Finished! $num_experiments run on $num_processes processes with $per_proc experiments per process"
pwd