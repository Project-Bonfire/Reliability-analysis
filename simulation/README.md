# Testbench

This testbench runs the simulation of a single router by adding packet generators and consumers to each of its ports.
It then injects a single fault into the router.
The output of the simulation can be found in sent.txt and received.txt

The parameters for injecting the faults are specified in a file which is given via an env var.
For each line in this file, the experiment will be run once and the output will be copied to the results folder.

There are several race conditions when multiple instances are launched in parallel. For that, seperate folders for compilation (vlib, vmap)
and a seperate modelsimini has to be set for each instance. (see `../run_sim.sh`)

## Output
The output is written to a file given as `RESULTFILE`.
An experiment is written down as:
```
-----
<experimentid>
<experimentparams>
!sent:
<one line for each packet sent into the router>
!recv:
<one line for each packet received from the router>
#####
```
The `sent` and `recv` lines are key value pairs which are seperated by a `;`.


## Parameters

The parameters for a single experiment are:
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
```
    setenv PROPERTYPATH $propertypath; 
    setenv STARTID $startid; 
    setenv RESULTFOLDER $resultfolder;
```

### Scenariofile
The scenariofile contains the scenario for the simulation. The scenario is the script for the packet generators, when to create which packets.
It has the following format:

```
Commentline. Completly ignored
time sourceid destid packetlength
time sourceid destid packetlength
500 ns 1 5 8
...
```
Notice that the statements are exectued sequentially  so order is important.
time is in ns. Mind the Space! The packet is scheduled for the next clock cycle then.
Sending packets is delayed when there is not enough credit.

## Running the Simulation

The simulation can be run with `vsim -t 1ns -c -do simulate.do`. `-c` runs the simulation headless.


## Replace router

The router can be simply replaced by changing the `Router_32_bit_credit_based_gate_level_without_hierarchy.v` file. The path can be changed in the `simulation.do`.

The module should have no hirachy. Also a list of the names of all pins is needed.

### Generate Pin Names
To get a list of all pins one can export the full list of all cells of the design. The export must conatin the input and output ports of the cells.

The `../cell_export_parser` folder contains a converter which takes the export of the Synopsys Design Compiler and compains it to the required list.
Also see the readme there.



#### Behrads description of what we did


1) First, We took the RTL code of the router along with its internal components. Using ModelSim (QuestaSim) from Mentor Graphics, we simulated the design, using a test-bench. The test-bench has packet injectors and packet consumers implemented in it at software layer, which act as Processing Elements (PEs). We have focused on random uniform traffic so far. One of the considered cases is that all input ports of the router send to the same direction or to different directions (destinations).
We have focused on router 5 in a 4x4 2D Mesh topology. XY routing is assumed and the router has connectivity to all its 4 neighbors and its local port. 
2) After making sure that the design at RTL works with the written test-bench, we synthesized the design using Synopsys Design Compiler (and Design Vision as part of it for visualization pusposes) using AMS 180 nm CMOS technology library (TYPICAL one, CORELIB). We broke the hierarchy (ungrouped everything) and using a synthesis script, we got the gate-level net-list of the router, which are in terms of the cells defined in AMS library. 
3) We exported the full list of all cells in the synthesized design and parsed it. 
4) To make sure everything works, we put the Verilog gate-level net-list of the design and tested it again with the same previous test-bench. The results matched. The way we check the results, one of them is checking two files received.txt and sent.txt. The number of lines should match, showing that every packet that was injected into the network has been eventually received by its destination.  
5) Using TCL script, we injected faults at different locations in the net-list and simulated each scenario to see the effect of the injected fault at gate-level on system-level behaviour of the NoC router -> For instance: mis-routing, mis-arbitrating, routing request(s) getting muted, corrupted data, flit loss or duplicated flit, ... . -> Similar work has been done in Peh's paper, but they have focused on the effect of process variation and run-time variation on system-level faults in a NoC router. 