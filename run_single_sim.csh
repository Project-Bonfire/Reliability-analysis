#!/bin/tcsh -f

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

set propertypath=`mktemp`
set startid=0
set resultfolder=`mktemp -d`
cp modelsim.ini $resultfolder/modelsim.ini
echo "$*" >> $propertypath

(setenv PROPERTYPATH $propertypath; setenv STARTID $startid; setenv RESULTFOLDER $resultfolder; vsim  -modelsimini $resultfolder/modelsim.ini -novopt -t 1ns  -do simulate.do  )

mv "results/" "$resultfolder/res"
echo "Find the results here:"
echo "cd $resultfolder/res"