
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

If these requirements are fulfilled, it the design has to be synthesized to gate level with Synopsis Design Compiler.

For more details on setting up the design, please refer to the ReadMe in teh *designs* folder.

## Usage

Most of the tool suite's functionality can be accessed by using the `make` command while in the root folder.
The configuration of the tool suite (such as changing the paths to different components) is done by editing the `Makefile.include` file.
