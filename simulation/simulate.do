#setenv BREAK_NAME allocator_unit/arb_N_X/state_reg[1] :QN
#setenv BREAK_TIME_BEFORE 1000
#setenv BREAK_TIME_AFTER 1000
#setenv FAULT_VALUE 0
#setenv FAULT_LENGTH 10


vlib work

# Include files and compile them

vlog "/cad/dk/c/v4.11/verilog/c18a6/c18_CORELIB.v"	
vlog "Router_32_bit_credit_based_gate_level_without_hierarchy.v"	
vcom "TB_Package_32_bit_credit_based.vhd"
vcom "Router_credit_based_tb.vhd"

# Start the simulation
vsim work.tb_router

# Draw waves
#do wave_4x4.do
#vcd file wave.vcd
#vcd add -r -optcells 

#get envs
set name $env(BREAK_NAME)
set time_before  $env(BREAK_TIME_BEFORE)
set time_after $env(BREAK_TIME_AFTER)
set val $env(FAULT_VALUE)
set fault_length $env(FAULT_LENGTH)

#add wave -position insertpoint {sim/:tb_router:R_5:\\$name}

puts "Breaking the circuit: Name: $name Time: $time_before ns Value: $val Length of fault: $fault_length ns"

# Run the simulation
run $time_before ns
# for reference: force -drive {sim/:tb_router:R_5:\FIFO_N/FIFO_MEM_2_reg[0] :D} St1 0 -cancel 1
# force -freeze sim/:tb_router:R_5:\\$name St0 start_after ns -cancel clock_cycle_length ns
force -freeze sim/:tb_router:R_5:\\$name St$val 0ns -cancel $fault_length ns
run $time_after ns

#vcd flush

exit
