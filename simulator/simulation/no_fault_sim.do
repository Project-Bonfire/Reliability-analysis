vlib work

# Include files and compile them

vlog "gate_level_netlist.v"
vlog "/cad/dk/c/v4.11/verilog/c18a6/c18_CORELIB.v"

vcom "TB_Package_32_bit_credit_based.vhd"
vcom "Router_credit_based_tb.vhd"

# Start the simulation
vsim -novopt -t 1ns -Gsent_file=sent.txt -Grecv_file=received.txt work.tb_router


# Draw waves
do wave_4x4.do
# Run the simulation
run 11000 ns
