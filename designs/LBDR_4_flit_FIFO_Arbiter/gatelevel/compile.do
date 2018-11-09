# All variables environmental variables are automatically transferred from 
# simulator/simulation/simulate.do and are usable in this file

# Compile the netlist
vlog "$DESIGN_FOLDER/gatelevel/gate_level_netlist.v"

# Compile testbench
vcom -O5 "$DESIGN_FOLDER/gatelevel/TB_Package_32_bit_credit_based.vhd"
vcom -O5 "$DESIGN_FOLDER/gatelevel/Router_credit_based_tb.vhd"
 
# Start the simulation
vsim -novopt -t 1ns -Gsent_file=$INPUT_FILE -Grecv_file=$OUTPUT_FILE -Gscenario_file=$SCENARIO_FILE work.tb_router
