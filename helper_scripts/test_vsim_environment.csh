#!/bin/tcsh -f
# Tests if vsim is working

if ( "$MODELSIM_ENV_SETUP" != "" ) then
    echo "Using Modelsim/Questasim setup script: $MODELSIM_ENV_SETUP"
    source $MODELSIM_ENV_SETUP
    vsim -version

    # Check if Modelsim is working
    if ("$?" == 1) then
        echo "E R R O R ! Modelsim environment not working!"
    else
        echo "C O N G R A T S ! Your environment script seems to be functioning!"
    endif

endif
