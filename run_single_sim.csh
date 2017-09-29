#!/bin/tcsh -f

source /cad/unsetenvs.csh
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
	setenv BREAK_TIME_BEFORE "$argv[1]"
	setenv BREAK_TIME_AFTER "$argv[2]"
	setenv FAULT_VALUE "$argv[3]"
	setenv FAULT_LENGTH "$argv[4]"
	setenv BREAK_NAME "$argv[5] $argv[6]"
	vsim -do simulate.do
	