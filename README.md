# Router reliability testbench

This should run many experiments where faults are injected into the router and it is checked if the router failed.

 - `run_sim.sh <number_of_processes>` runs the simulation as many times as the sim_runs file contains lines
 - `sim_runs` contains the paramters which should be used for each simulation
 - `setup_sim.sh` compiles the exported cell file to a list of breakable pins. See `prepare_sim/cell_export_parser/README.md` for further information.
 - `prepare_sim.sh <number of experiments>` prepares the sim_runs file. It contains `<number of experiments>`lines then. 
 - `results` contains all results of simulations. Each run creates a folder with the current date and time. In the Folder, there are the log files of the simulation and the results from the experiments
 - `eval_sim` contains the evaluator for the output of the experiments.
 
The simulation is paralelized on the number of given processes. For that a temp file and folder are created. The tempfile contains the parameterlist for this process, the tempfolder is used to store the results.
The results are copied then into the resultsfolder. The foldername in the resultsfolder is the startdate and time.

 ## Usage
  - Prepare router model and netlist files with the `cell_export_parser`
  - Generate parameters for the simulation runs (10_000 runs here)
    - `./prepare_sim.sh 10000`
  - Run the simulation:
    - `./run_sim.sh <num_processes>`
  - You can run a simle simulation with a given line by calling (example line):
    - `./run_single_sim.csh 49308 692 0 10 U3116 :A1`

 # Subprojects
See the README's of the subprojects to get further information.

  - `simulation` contains the actual modelsim simulation files
  - `prepare_sim` contains everything to prepare the simulation arguments
     - `cell_export_parser` can convert a synopsis cell list export to a plain list of all pins of the router.
     - `sim_run_creator` can create a `sim_runs` file using the output of the `cell_export_parser`
     NOTE:
     force -freeze {sim:/tb_router/R_5/\allocator_unit/U34 /Q} 1'h0 0
  - `eval_sim` contains the evaluation tool for the simulation results. 

 

 
