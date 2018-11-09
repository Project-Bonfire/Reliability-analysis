###################
#      Setup      #
###################

# Load Environment variables
global env; 
set DESIGN_FOLDER   $env(DESIGN_FOLDER)
set RESULTS_FOLDER  $env(RESULTS_FOLDER)
set PROPERTY_PATH   $env(PROPERTY_PATH)

set INPUT_FILE      $env(INPUT_FILE)
set OUTPUT_FILE     $env(OUTPUT_FILE)
set SCENARIO_FILE   $env(SCENARIO_FILE)
set RESULTS_FILE    $env(RESULTS_FILE)

set START_ID $env(START_ID)

set VERILOG_CORELIB $env(VERILOG_CORELIB)

if {[info exists env(DEBUG)]} {
    set DEBUG $env(DEBUG)

} else {
    set DEBUG "false"
}

puts "Design folder: $DESIGN_FOLDER"
puts "Results folder: $RESULTS_FOLDER/work"
puts "Propery path: $PROPERTY_PATH"
puts "Start ID: $START_ID"
puts "Verilogs's corelib is located at: $VERILOG_CORELIB"


# Define library work
vlib work
file rename work $RESULTS_FOLDER/work
puts "Work folder exists: [file exists $RESULTS_FOLDER/work]"
vmap work $RESULTS_FOLDER/work
# Prevent race condition between instances!

# Map it to the folder of this process

# Include files and compile them

#####################################
# Add and compile code and TB files #
#####################################

vlog $VERILOG_CORELIB

# Compile the design dependant files and run the simulation
source $DESIGN_FOLDER/gatelevel/compile.do

#########################
# SETUP RESULTS LOGGING #
#########################

set concat_result_file [open $RESULTS_FILE "w"]
fconfigure $concat_result_file -translation binary

global env; 
puts "Propery path: $PROPERTY_PATH"
set property_fp [open $PROPERTY_PATH  r]

fconfigure $property_fp -buffering line
gets $property_fp properties
set exp_num $START_ID

###################
# RUN EXPERIMENTS #
###################

while {$properties != ""} {
    puts "Starting experiment #$exp_num..."
    # Split line
    set params [regexp -all -inline {\S+} $properties]
    # Prepare next line
    
    # Set params
    set name [lindex $params 4]
    set tmpfirst [string first "U" $name]

    # If it starts with U
    if {$tmpfirst != 0} {
        append name " "
    }
    append name [lindex $params 5] 
    set time_before  [lindex $params 0] 
    set time_after [lindex $params 1] 
    set val [lindex $params 2] 
    set fault_length [lindex $params 3] 
    #add wave -position insertpoint {sim/:tb_router:R_5:\\$name}

    puts "Breaking the design: Name: '$name' Time: $time_before ns Value: $val Length of fault: $fault_length ns"
    source $DESIGN_FOLDER/record_modules.tcl
    
    # Run the simulation
    run $time_before ns
    # for reference: force -drive {sim/:tb_router:R_5:\FIFO_N/FIFO_MEM_2_reg[0] :D} St1 0 -cancel 1
    # force -freeze sim/:tb_router:R_5:\\$name St0 start_after ns -cancel clock_cycle_length ns
    
    if {$name == "nofault :nofault"} {
         puts "Parameter is nofault, will not break anything."

    } else {
        puts "Run for $time_before. Breaking now!"
        force -freeze "sim/:tb_router:R_5:$name" St$val 0ns -cancel $fault_length ns
        puts "Broke the design!"
    }

    run $time_after ns

    # Reset simulation
    restart

    # Handle the results
    puts $concat_result_file "-----"
    puts $concat_result_file "$exp_num"
    puts $concat_result_file $properties
    puts $concat_result_file "!modules:"

    # Exclude date of the file, only keep the hash.
    foreach file [glob -nocomplain "$RESULTS_FOLDER/*.vcd"] {
        set filename [file tail [file rootname $file]]
        puts $concat_result_file "$filename:[exec tail --lines=+3 $file | sha1sum | cut -d " " -f1]"
    }

    puts $concat_result_file "!input:"
    set input [open "$INPUT_FILE"]
    fconfigure $input -translation binary
    fcopy $input $concat_result_file
    close $input
    puts $concat_result_file "!output:"

    set putput [open "$OUTPUT_FILE"]
    fconfigure $putput -translation binary
    fcopy $putput $concat_result_file
    close $putput
    puts $concat_result_file "#####"

    # No cleanup on debug
    if {$DEBUG != "true"} {
        file delete "$INPUT_FILE"
        file delete "$OUTPUT_FILE"    
        file delete {*}[glob -nocomplain "$RESULTS_FOLDER/*.vcd"]
    }
    puts "finished experiment #$exp_num"
    # Increment line
    gets $property_fp properties
    incr i
}
close $concat_result_file

#vcd flush
exit
