#!/bin/tcsh -f
# Sets up the environment to for running ModelSim / QuestaSim. 

# == Please edit the file to fit your environment! ==

#source /cad/unsetenvs.csh

# setenv PATH /bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin
# setenv MANPATH /usr/man:/usr/share/man:/usr/local/man:/usr/local/share/man

# setenv M_16_EDA

setenv PATH /bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin
setenv MANPATH /usr/man:/usr/share/man:/usr/local/man:/usr/local/share/man
setenv LD_LIBRARY_PATH /cad/eda/mentor/2017-18/ftlib/lib:/cad/eda/mentor/2017-18/ftlib/lib64:/lib:/lib64:/usr/lib:/usr/lib64:"$LD_LIBRARY_PATH"

setenv M_18_EDA

#source /cad/cadrc.include_new
#          echo " "
#          echo "Environment ready for Mentor Graphics 2016 EDA version."
#          echo " "
#          breaksw

source /cad/cadrc.include_new
# source /eda/mentor/2017-18/scripts/QUESTA-SV-AFV_10.4c-5_RHELx86.csh
