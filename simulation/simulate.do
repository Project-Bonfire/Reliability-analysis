#setenv BREAK_NAME allocator_unit/arb_N_X/state_reg[1] :QN
#setenv BREAK_TIME_BEFORE 1000
#setenv BREAK_TIME_AFTER 1000
#setenv FAULT_VALUE 0
#setenv FAULT_LENGTH 10


vlib work

# Include files and compile them

vlog "/cad/dk/c/v4.11/verilog/c18a6/c18_CORELIB.v"	
vlog "Router_32_bit_credit_based_gate_level_without_hierarchy.v"	
vcom -O5 "TB_Package_32_bit_credit_based.vhd"
vcom -O5 "Router_credit_based_tb.vhd"

global env; 
puts $env(PROPERTYPATH) 
puts $env(RESULTFOLDER)
set RESULTFOLDER $env(RESULTFOLDER)
puts $env(STARTID)
# Start the simulation
vsim -t 1ns -Gsent_file=$RESULTFOLDER/sent.txt -Grecv_file=$RESULTFOLDER/received.txt work.tb_router

# Draw waves
#do wave_4x4.do
#vcd file wave.vcd
#vcd add -r -optcells 
global env; 
puts $env(PROPERTYPATH) 
set fp [open $env(PROPERTYPATH)  r]
#delete old results
file mkdir results 


fconfigure $fp -buffering line
gets $fp data
set i $env(STARTID)
while {$data != ""} {
  
    file mkdir "results/$i"
    #split line
    set params [regexp -all -inline {\S+} $data]
    #prepare next line
    
    #set params
    set name [lindex $params 4]
    append name " "
    append name [lindex $params 5] 
    set time_before  [lindex $params 0] 
    set time_after [lindex $params 1] 
    set val [lindex $params 2] 
    set fault_length [lindex $params 3] 
    #add wave -position insertpoint {sim/:tb_router:R_5:\\$name}

    puts "Breaking the circuit: Name: $name Time: $time_before ns Value: $val Length of fault: $fault_length ns"

    # Run the simulation
    run $time_before ns
    # for reference: force -drive {sim/:tb_router:R_5:\FIFO_N/FIFO_MEM_2_reg[0] :D} St1 0 -cancel 1
    # force -freeze sim/:tb_router:R_5:\\$name St0 start_after ns -cancel clock_cycle_length ns
    force -freeze sim/:tb_router:R_5:$name St$val 0ns -cancel $fault_length ns
    puts "Broke the circuit: Name: $name Time: $time_before ns Value: $val Length of fault: $fault_length ns"
    run $time_after ns
    #reset simulation
    restart
    #handle results
    file rename "$RESULTFOLDER/sent.txt" "results/$i/sent.txt"
    file rename "$RESULTFOLDER/received.txt" "results/$i/received.txt"
    set fo [open "results/$i/params.txt" "w"] 
    puts $fo $data
    close $fo

    #increment line
    gets $fp data
    incr i
}
#

#vcd flush

exit
