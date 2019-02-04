
# Reliability Tester

This repository consists the tool suite for assessing reliability of designs by running Monte Carlo fault injection campaigns on the designs to collect statistics about its reliability.

## Folder Structure

```
[root]
    |
    +- [dependencies] - Dependencies required by the tool for running
    |
    +- [designs] - Contains designs to be evaluated. Also per-design evaluation results are stored there
    |
    +- [doc] - Files included in documentation
    |
    +- [helper_scripts] - Scripts needed for evaluation
    |
    +- [scenarios] - Simulation scenarios / test vectors used for inputs of the design
    |
    +- [simulator] - Files ans scripts used for running the Monte Carlo simulation and result evaluation
```

## Preparation for Usage

### Setting Up Connection to Questasim

The toolchain relies on Modelsim / Questasim to run the simulations. For that reason it is important to make sure that the tool is accessible by the design.

Since on many setups the tools need the environment to set up before the tool is run (such as setting up the path variables and etc.), the tool suite includes a customizable script which is run automatically every time the tool needs to access the `vsim` command. This is done as follows:

1. Write a custom script (or modify the existing one) which sets up the environment.
2. Make the `export MODELSIM_ENV_SETUP` variable in `Makefile.include` point to that script
3. Check if the tool suite can access the simulator by running `make test_vsim_environment` in the root folder of this tool chain.
4. If the configuration is correct, the command will print the version of Questasim it is running. If you see an error message again, something is wrong with your configuration and you need to fix it before proceeding.

### Setting Up the Design to be Analyzed

#### Design Preparations

For the toolchain to be able to analyze the design, it is needed that it is slightly modified:

1. All logic should be inside sub-modules, not directly in the top module file. This is needed for the tool to be able to detect which fault injection location belongs to which component. The tool will ignore all fault injection locations which it cannot assign to a sub-module.
2. The top level module should be modified so that all the the output signals of the sub-modules would be visible in the port of the top module.

In order to maintain the name of each router module after synthesis, the synthesis scripts are modified in a way that each router component is ungrouped and the sub-modules would carry the name of the corresponding module it belongs to. This is performed by breaking the hierarchy of the design during synthesis process. 
This would make it possible later for the reliability analysis to know the fault injection location belongs to what component of the router. The synthesis tool reports the inputs and outputs of each cell in the gate-level netlist, along with the gate-level netlist itself and later used for fault injection experiments.

For more details on setting up the design, please refer to the ReadMe in teh *designs* folder.

#### Setting Up Scenarios

TBD

## Usage

Most of the tool suite's functionality can be accessed by using the `make` command while in the root folder.
The configuration of the tool suite (such as changing the paths to different components) is done by editing the `Makefile.include` file.

The tool has the following commands:

### Setting Up a Design

This is used for setting up the design. This step will parse the cell list of the design and analyze it to find all possible fault injection locations and assign them to sub-modules.

`make setup DESIGN=<design_name in designs/folder> [CELL_EXP_LOC=<cell export filename>]`

**DESIGN** - Name of the design to setup. It has to be the name of the folder of the design under the *root/designs/* folder. Don't add the full path there.

**[CELL_EXP_LOC]** - (optional), the path of the verbose cell report file gotten from the synthesis is located, relative to the *DESIGN* folder. Defaults to *gatelevel/Cells_Report_with_Connections_Verbose.txt"*

### Preparations for Simulation

This step processes the set up design and generates a list of random fault injection experiments.

`make prepare DESIGN=<design_name in designs/folder> [OUTPUT_FILE=<output file>]`

**DESIGN** - Name of the design to setup. It has to be the name of the folder of the design under the *root/designs/* folder. Don't add the full path there.

**[OUTPUT_FILE]** - (optional), path where to store the list of experiments. Defaults to *&lt;DESIGN_DIR&gt;/generated_files/experiments.txt*

### Monte-Carlo Fault Simulation

`make simulate DESIGN=<design_name in designs/folder> [SIM_SCENARIO_CONFIG=<scenario>] [EXP_FILE=<experiments_file>] [NUM_PROC=<int>]`

**DESIGN** - Name of the design to setup. It has to be the name of the folder of the design under the *root/designs/* folder. Don't add the full path there.

**[SIM_SCENARIO]** - scenario file which specifies the input vectors for the design during the simulation. Defaults to *sim_single_point.txt*. Most probably you want to override it.

**[EXP_FILE]** - experiments file built in the `make prepare` phase. Defaults to *&lt;DESIGN_DIR&gt;/generated_files/experiments.txt*

**[NUM_PROC]** - How many parallel processes to use for simulation. Should be smaller or equal to the total amount of experiments, but not larger that the CPU cores in the computer the simulation is run on. Defaults to 17.

### Evaluating the results

`make evaluate <DESIGN>`

`make multi_eval <DESIGN> [EXPLST_FILE]`

`make analyze <DESIGN> [RES_FILE]`
