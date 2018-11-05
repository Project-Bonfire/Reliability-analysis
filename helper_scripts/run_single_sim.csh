#!/bin/tcsh -f
#Usage: $0 <scnfile> <desing_file> '<faultsimline>'
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

set scnfile = $SIM_ROOT_DIR/scenarios/$1
set desing_file = $SIM_ROOT_DIR/designs/$2
echo "Used design: $desing_file"
shift
shift # take first parameter and shift it away then.

cd $SIM_ROOT_DIR/simulator/simulation

# rm -rf results/
rm -rf $SIM_ROOT_DIR/results/single

set propertypath=`mktemp`
set startid=0
set resultfolder=`mktemp -d`
cp modelsim.ini $resultfolder/modelsim.ini
echo "$*" >> $propertypath
mkdir $SIM_ROOT_DIR/results/single
(setenv DEBUG "true";setenv ROUTERFOLDER $desing_file;setenv SCENARIOFILE $scnfile;setenv RESULTFILE $SIM_ROOT_DIR/results/single/Process1.results;setenv PROPERTYPATH $propertypath; setenv STARTID $startid; setenv RESULTFOLDER $resultfolder; vsim  -modelsimini $resultfolder/modelsim.ini -novopt -t 1ns -c -do simulate.do  )

echo "Find the results here:"
echo "cd $SIM_ROOT_DIR/results/single"
echo "Tmp Folder was here:"

#this should be the last line of output, or change the code in ./setup.sh
echo "cd $resultfolder"