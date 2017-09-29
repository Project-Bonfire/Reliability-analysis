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
set i=0
set curtime=`date +%Y-%m-%d.%H:%M:%S`
mkdir "../results/$curtime"
foreach line ( "`cat ../sim_runs`" )
        set args=`echo $line:q | sed 's/,/ /g'`
        echo "Current run: $args"
	@ i++
	setenv BREAK_TIME_BEFORE "$args[1]"
	setenv BREAK_TIME_AFTER "$args[2]"
	setenv FAULT_VALUE "$args[3]"
	setenv FAULT_LENGTH "$args[4]"
	setenv BREAK_NAME "$args[5] $args[6]"
	vsim -c -do simulate.do
	set respath="../results/$curtime/$i"
	mkdir "$respath"
	echo "$line" > "$respath/params.txt"
	mv ./received.txt "$respath/received.txt"
	mv ./sent.txt "$respath/sent.txt"
end
