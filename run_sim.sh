#!/bin/tcsh -f

if ( "$1" == "" ) then      # parentheses not strictly needed in this simple case
    echo "Usage $0 <num_processes>"
    echo "ERROR! Please supply the number of Processes to be spawned!"
    exit 
endif

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


cd simulation
rm -rf results/
mkdir results
set i=0
set curtime=`date +%Y-%m-%d.%H:%M:%S`
mkdir "../results/$curtime"
set num_processes=$1
set num_experiments=`wc -l <../sim_runs`
set per_proc=`python -c "from math import ceil;print ('%d'%ceil($num_experiments/float($num_processes)))"`
echo $per_proc
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
    echo $resultfolder
    #launch vsim instance
    (setenv PROPERTYPATH $propertypath; setenv STARTID $startid; setenv RESULTFOLDER $resultfolder; vsim -t 1ns -c -do simulate.do  >../results/$curtime/Process${x}out.log )&
    # some processes can not launch, maybe this helps?
    sleep 5
    @ x += 1
end
echo "$num_experiments run on $num_processes processes with $per_proc experiments per process"
wait
#move the result to the results folder
mv "results/" "../results/$curtime/"

echo "$num_experiments run on $num_processes processes with $per_proc experiments per process"