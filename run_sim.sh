#!/bin/tcsh -f
if ( "$1" == "" ) then 
    echo "Usage $0 <scenariofile> <num_processes>"
    exit
endif
if ( "$2" == "" ) then 
     # parentheses not strictly needed in this simple case
    echo "Usage $0 <scenariofile> <num_processes>"
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
    set num_processes = $2
endif

echo "Processes to spawn: $num_processes!"
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

set scnfile=`readlink -f $1`
set curtime=`date +%Y-%m-%d.%H:%M:%S`
cd simulation
rm -rf results/
mkdir results
set i=0

mkdir "../results/$curtime"
mkdir "../results/$curtime/results"
set num_experiments=`wc -l <../sim_runs`
set per_proc=`python -c "from math import ceil;print ('%d'%ceil($num_experiments/float($num_processes)))"`
echo "$per_proc tasks per process."
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
    sed -n ${startline},${endline}p  < ../sim_runs >> $propertypath
    set resultfolder=`mktemp -d`
    cp modelsim.ini $resultfolder/modelsim.ini
    echo $resultfolder
    #launch vsim instance, create tmp folders and seperate modelsiminis for each instance, to prevent race conditions.
    (setenv SCENARIOFILE $scnfile;setenv RESULTFILE ../results/$curtime/results/Process${x}.results;setenv PROPERTYPATH $propertypath; setenv STARTID $startid; setenv RESULTFOLDER $resultfolder; /usr/bin/nice -n 15 vsim -modelsimini $resultfolder/modelsim.ini -novopt -t 1ns -c -do simulate.do  >../results/$curtime/Process${x}out.log )&
    # prevents race condition when copying library work to tmp folder
    sleep 1
    @ x += 1
end
echo "$num_experiments runs on $num_processes processes with $per_proc experiments per process"
wait

cd "../results/$curtime"
echo "started: $curtime finished: " >> "stats.txt"
echo `date +%Y-%m-%d.%H:%M:%S` >> "stats.txt"
echo `uptime | cut -d : -f 4` >> "stats.txt"
cp "$scnfile" scenario.scn
#concat all results to one single file
cat results/* > all.results
rm -rf "results"
gzip all.results

#write stats.txt file


echo "Finished! $num_experiments run on $num_processes processes with $per_proc experiments per process"
pwd