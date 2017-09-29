# Router reliability testbench

This should run many simulations where faults are injected into the router and it is checked if the router failed.

 -`run_sim.sh` runs the simulation as many times as the sim_runs file contains lines
 - `sim_runs` contains the paramters whioch should be used for each simulation

 ## Usage
  - Prepare router model and netlist files with the `cell_export_parser`
  - Generate parameters for the simulation runs (10_000 runs here)
    - `cd prepare_sim/sim_run_creator && ./sim_run_creator.py 10000 > ../../sim_runs`
  - Run the simulation:
    - `./run_sim.sh`

 # Subprojects
  - `simulation` contains the actual modelsim simulation files
  - `prepare_sim` contains everything to prepare the simulation arguments
     - `cell_export_parser` can convert a synopsis cell list export to a plain list of all pins of the router.
     - `sim_run_creator` can create a `sim_runs` file using the output of the `cell_export_parser`

 