# Testbench

This testbench runs the simulation of a single router by adding packet generators and consumers to each of its ports.
It then injects a single fault into the router.

The parameters for injecting the faults are specified in a file which is given via an env var.
For each line in this file, the experiment will be run once and the output is written to the resultfile.

There are several race conditions when multiple instances are launched in parallel. For that, seperate folders for compilation (vlib, vmap)
and a seperate modelsimini has to be set for each instance. (see `../run_sim.sh`)

# routerinfo
For the current router a `routerinfo.rti` file has to be supplied.
The file contains key value pairs with basic information about the router.
In the example below, you can see the `routerinfo.rti` file for the tablebased router.

```
modules=['fifo','lbdr','xbar','arbiter','none']
nrfaultlocs=4930
locspermodule={'all':4930,'fifo':3573,'fifoc':2361,'fifod':1212,'lbdr':1048,'xbar':288,'arbiter':21,'none':0}
ralgo_name="XYRouting"
info="table based routing"
```
 - `modules` is a list of all the module names of the router
 - `nrfaultlocs` is the number of fault injection locations of the router
 - `locspermodule` is a dictionary, which specifies for each module how many fault injection locations it has
 - `ralgo_name` is the name of the used routing algorithm
 - `info` is an info string which describes the router

## Output
The output is written to a file given as `RESULTFILE`.
What happened during an experiment is written down as:
```
-----
<experimentid>
<experimentparams>
!modules:
<one line for each module of the router in the format:
[arbiter|xbar|fifo|lbdr|...]:<hash of the vcd file of that modules outputs>
>
!sent:
<one line for each packet sent into the router>
!recv:
<one line for each packet received from the router>
#####
```
The `sent` and `recv` lines are key value pairs which are seperated by a `;`.
The modules are the hashes of the module files of the outputs.


## Parameters

The parameters for a single experiment (one line of the `PROPERTYPATH` file) are:
 - `BREAK_NAME` The name of the pin to break.
    The name has to be in the format specified by the vars in the `modelsim.ini` file. (`DatasetSeparator`,`PathSeparator`). If you want to do a dryrun, specify `nofault :nofault`
 - `BREAK_TIME_BEFORE` The time the simulation should run before the break is issued.
 - `BREAK_TIME_AFTER` The time the simulation shoud run after the break is issued.
 - `FAULT_VALUE` To what the value of the pin should be set.
 - `FAULT_LENGTH` How long it should keep this value.

 All times are in nano seconds (ns).

The parameters for the whole simulation are given via env vars:
    
- `PROPERTYPATH` is the path to the file containing a line of parameters for each experiment
- `STARTID` is the id which should be used to start counting up the number of experimentresults in the `results` folder
- `RESULTFOLDER` is a folder which is used temporarly for results before they are copied to the experiment results folder. This may be removed in further versions, and the result will be written to the correct destination directly.
- `RESULTFILE` is the file where the results of the experiments are written to. See section `output`.
- `SCENARIOFILE` the scenariofile contains the scenario for these experiments.
- `DEBUG` The debug flag should be set to `"true"` when cleanup should not be done, therefore, the `RESULTFOLDER` will staz populated.
- `ROUTERFOLDER` the path where the `gate_level_netlist.v` is found that contains the router that should be simulated. 
```
    setenv PROPERTYPATH $propertypath; 
    setenv STARTID $startid; 
    setenv RESULTFOLDER $resultfolder;
    setenv RESULTFILE $resultfile;
    setenv SCENARIOFILE $scenariofile;
```

### Scenariofile
The scenariofile contains the scenario for the simulation. The scenario is the script for the packet generators, when to create which packets.
It has the following format:

```
Commentline. Completly ignored
time sourceid destid packetlength
500 ns 1 5 8
...
```
Notice that the statements are exectued sequentially  so order is important.
time is in ns. Mind the Space! The packet is scheduled for the next clock cycle then.
Sending packets is delayed when there is not enough credit.

## Running the Simulation

The simulation can be run with `vsim -t 1ns -c -do simulate.do`. `-c` runs the simulation headless.


# Router
The router that should be used can be specified with the env var `ROUTERFOLDER`.
This folder has to contain a `gate_level_netlist.v` file which contains the router without hirachy.
Also the folder has to contain a `pattern_to_modules.py` and a `record_modules.tcl` file.
`pattern_to_modules.py` to match pins to modules during setup and `record_modules.tcl` to setup recording of the modules outputs during the experiments.

For further information, see the section setup in the `../README.md`


