# Designs

This folder contains designs to be analyzed. Add your own designs to this folder. For example design, please check the *LBDR_4_flit_FIFO_Arbiter* design.

## Folder structure

Each design has to be in a separate folder under the current folder and should have the following structure:

- **gatelevel/** -- contains all files need for comping, simulating, an analyzing the gatelevel design.
  - **Cells_Report_with_Connections_Verbose.txt** -- (suggested name) verbose cell report gotten from Synopsis Design Compiler
  - **gate_level_netlist.v** -- Verilog gatelevel netlist which is going to be simulated
  - **compile.do** -- A do file which is sourced during the compilation. It should contain the compilation commands of the gatelevel netlist file and also the testbench and other necessary files needed for simulating the netlist. It should also include the vsim command used for running simulation
  - Test benches and other support files needed for the simulation
- **HDL** -- RTL code of the router and other HDL files. The contents of this folder is not used by the toolchain, unless reference by design related files (like compile.do)
- **designingo.txt** -- Contains information about the design. The first parameter should be *scenario*, which specifies under which folder in /scenarios to look for the simulation scenario for the current design. The *info* parameter contains the name of the design. This file can also include additional user-defined parameters.
- **pattern_to_modules** -- Contains a python dictionary for mapping signal names to modules
- **record_modules.tcl** -- Instructions for saving module output signals
- **generated_files** -- This folder contains the results files automatically generated for the design by the toolchain. The folder will whe automaically created by the tools
