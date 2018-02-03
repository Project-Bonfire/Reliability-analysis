# Router reliability testbench
A toolsuite which allows to asses reliability properties of NoC-routers.
For this, the reliability of routers is estimated in benchmarks, where many experiments are run.
In the experiments, transient faults are simulated in the router during a scenario is run and it is evaluated if the router violated its specification invariants.

This toolsuite therefore has tools from the following categories:
  1. Setup of the router
  2. Running the Benchmark
  3. Evaluating the Benchmark
  4. Statistics and plotting

The standard workflow for assessing a router is as follows:
 1. Setup: `setup_sim.sh`
 2. Benchmark: `multi_params.sh`
 3. Collect benchmarks of the same router: `gen_explst_by_rti.sh`
 3. Evaluation: `meval.sh`
 4. Plot: `eval_sim/plot.py`
 5. Compare routers using the plot dashboard: `plots.php`

  For these tasks, the main entry points are scripts in this directory (only important/required parameters are listed):

 - `setup_sim.sh <routername>` sets up a router for benchmarking. Also helps to verify that the router is set up properly.
    1. `routername` is the name of a folder in `simulation/routers`. 
 - `run_sim.sh <scenariofile> <routername> <sim_runs> <num_processes>` runs as many experiments as the sim_runs file contains lines. 
    1. `scenariofile` specifies the used scenarios. You can find some in `scenarios/`, or generate them.
    2. `routername` is the name of a folder in `simulation/routers`. 
    3. `sim_runs` is the path to the file with the fault injection parameters.
    4. `num_processes` is the number of parallel processes which should be used during benchmarking.
 - `count_modules.sh <routername>` is a small helper that counts the number of fault locations for each module. Be careful, when modules prefix each other.
 - `prepare_sim.sh <routername> <output file>` prepares a file with the experiments for a benchmark. Satisfies error margins.
 - `multi_params.sh <simname> <routername> <numproc>` runs multiple simulation runs with different scenarios. It evaluates these scenarios and writes the framelength, the packetsize and the fault probability to the output file. 
    1. `simname` The name of the benchmark, currently not used. 
 - `gen_explst_by_rti.sh <searchpattern in rti file>` helps creating .explst files. The explst file can help to store all experiment names which belong to a specific router setup.
 - `meval.sh <explst> <evalname> <numproc>`
    1. `explst`: the path to the explst file, which contains on each line a benchmark output folder that should be evaluated.
    2. `evalname`: the name for this collection of benchmarks. Is used for the output file.
    3. `numproc`: is the number of parallel processes which should be used.
 - `plots.php` Is php script, which generates a dashboard which presents all the plots from each router in the same folder. See section plot dashboard below.
 - `run_single_sim.csh <scnfile> <routername> '<faultsimline>'` runs a single simulation for testing purposes, also sets the debug flag, so no cleanup is done.
    1. `scnfile`: specifies the used scenarios. You can find some in `scenarios/`, or generate them.
    2. `routername`: is the name of a folder in `simulation/routers`. 
    3. `faultsimline`: the fault injection parameters that should be used. Avoid exclamation marks (module is not needed for sim) and put it in quotes.
 - `stats.sh <explst>` gathers the time each benchmark took from the explst and echos it.
 
## Results
The folder `results` contains all results of simulations. 
Each benchmark creates a folder with the current date and time. 
In the Folder, there are the log files of the simulation and the results from the experiments in `all.results.gz`. 
This is a compressed text file which contains all the experiments.
During evaluation, a `all.intmdtresults.gz` file is created, which contains the assessed experiments, before they are accumulated. 

## Simulation
The simulation is tested using QuestaSim.

The simulation is paralelized on the number of given processes. For that a temp file and folder are created. 
The tempfile contains the parameterlist for this process, the tempfolder is used to store the results.
The results are copied then into the resultsfolder. The foldername in the resultsfolder is the startdate and time.

 ## Examples
  - You can run a simle simulation with a given line by calling (example line):
    - `./run_single_sim.csh <scenariofile> <routername> 49308 692 0 10 U3116 :A1`
`

 # Subprojects
See the `README`'s of the subprojects to get further information.

  - `simulation` contains the actual modelsim simulation files with the router and the script to run the fault injection.
  - `prepare_sim` contains everything to prepare the simulation arguments
     - `cell_export_parser` can convert a synopsis cell list export to a plain list of all pins of the router.
     - `sim_run_creator` can create a `sim_runs` file using the output of the `cell_export_parser`
     - `scenario_gen` generates scenarios for the simulation.
  - `eval_sim` contains the evaluation tool for the simulation results. 

 

 # Plot Dashboard
The plot dashboard is the `plots.php` script, which can be linked from a folder which is serverd by a webserver which also contains the plots from different reliability assessments.
The structure has to be as follows:
  - .
    - `plots.php`
    - One folder for each router
      - one `.png` file for each plot
      - a `.txt` file with the same prefix as the `.png` with the description

# Setup
The setup phase creates all the files that are needed during an assessment.

To setup a router a gate level netlist with broken hirarchy but sensible cellnames and an verbose export of all cells is needed (Supported is the format from  the Synopsys Design Compiler).

At first, the matching from cellnames to modulenames has to be setup. 
For this the  files `pattern_to_modules.py` and  `record_modules.tcl` have to be created in the folder of the router. 
See examples in the routers in `simulation/routers` for further information.

 - `pattern_to_modules.py` contains a map from regular expressions to module names.
 - `record_modules.tcl` sets up the recording of the module outputs during the simulation. This information will be used to see if the output of a module has been changed by the fault injection.

When these two files are present, the setup process can be done with the `setup.sh` script.
The output of this script should be read carefully, as it contains hints if the setup was successfull.

The script gathers the fault injection locations creates the `routerinfo.rti` file and runs a test simulation.
Also, from the test simulation, the list of pins which are recorded as module outputs are written to the `moduleoutputsignals` folder of the router.
