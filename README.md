# Router reliability testbench

This should run many simulations where faults are injected into the router and it is checked if the router failed.

 -`run_sim.sh` runs the simulation 
 - `sim_runs` contains the paramters whioch should be used for each simulation

 # Subprojects
  - `simulation` contains the actual modelsim simulation files
  - `cell_export_parser` can convert a synopsis cell list export to a plain list of all pins of the router.