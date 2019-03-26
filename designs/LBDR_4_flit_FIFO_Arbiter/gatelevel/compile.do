# All variables environmental variables are automatically transferred from 
# simulator/simulation/simulate.do and are usable in this file

puts "Scenario file: $SCENARIO_FILE"

# Compile the netlist
vlog "$DESIGN_FOLDER/gatelevel/gate_level_netlist.v"
# vcom "$DESIGN_FOLDER/HDL/Packages/router_pack.vhd"

# vcom "$DESIGN_FOLDER/HDL/RTL/LBDR_input_wire.vhd"
# vcom "$DESIGN_FOLDER/HDL/RTL/allocator_input_wire.vhd"
# vcom "$DESIGN_FOLDER/HDL/RTL/FIFO_control_part_input_wire.vhd"
# vcom "$DESIGN_FOLDER/HDL/RTL/FIFO_control_part.vhd"
# vcom "$DESIGN_FOLDER/HDL/RTL/FIFO_data_path_input_wire.vhd"
# vcom "$DESIGN_FOLDER/HDL/RTL/FIFO_data_path.vhd"
# vcom "$DESIGN_FOLDER/HDL/RTL/FIFO_one_hot_credit_based.vhd"
# vcom "$DESIGN_FOLDER/HDL/RTL/LBDR.vhd"
# vcom "$DESIGN_FOLDER/HDL/RTL/arbiter_out.vhd"
# vcom "$DESIGN_FOLDER/HDL/RTL/allocator.vhd"
# vcom "$DESIGN_FOLDER/HDL/RTL/xbar_input_wire.vhd"
# vcom "$DESIGN_FOLDER/HDL/RTL/xbar.vhd"
# vcom "$DESIGN_FOLDER/HDL/RTL/Router_32_bit_credit_based.vhd"

# Compile testbench
vcom "$DESIGN_FOLDER/gatelevel/stephens_package.vhd"
vcom "$DESIGN_FOLDER/gatelevel/TB_Package_32_bit_credit_based.vhd"
vcom "$DESIGN_FOLDER/gatelevel/Router_credit_based_tb.vhd"
 
# Start the simulation
vsim -novopt -t 1ns -Gsent_file=$INPUT_FILE -Grecv_file=$OUTPUT_FILE -Gscenario_file=$SCENARIO_FILE -Gdumps_folder=$DUMPS_FOLDER work.tb_router
