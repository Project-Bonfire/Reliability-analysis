#!/bin/tcsh -f
# Sets up the environment to for running ModelSim / QuestaSim. 

# == Please edit the file to fit your environment! ==

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
