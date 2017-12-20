#Eval Sim

Evaluates the results of a simulation. Detects faults in the experiments and calculates the fault probability.

 For the parameters see `--help` of eval.py.

## Setup
 To install the dependencies, install the requirements in `requirements.txt` and install the python3 version 
 of SocDep2. You may install the version from this repository by:
 ```
 python3 SocDep2_egged/setup.py install
 ```


## Resulting statistics:

 - `num_runs`: the number of runs
 - `num_violations`: the number of experiments where a invariant of the router was violated
 -  `ratio_violations`: `num_violations / num_runs`
 -  `sim_errors`: the number of program errors while running / evaluating the simulation.
 -  `module_changed_counts`: the number of experiments, where the output of the module changed for the 4 modules: `lbdr fifo arbiter xbar`
 -  `param_module_counts`: the number of experiments where the fault was introduced into the module.
 -  `param_module_changed_counts`: the number of experiments where the fault was introduced into the module's output and the module changed.
 -  `param_module_changed_ratios`:  `param_module_changed_counts / param_module_counts`. The ratio of a fault introduced into a module causing the module's output to change
 -  `param_module_changed_and_invalid_counts`: The fault was introduced into the module, the modules output changed and an invariant of the router was violated.
 -  `param_module_changed_and_invalid_ratios`: `param_module_changed_and_invalid_counts / param_module_changed_counts`. The probability of a fault, which is changing the output of the module where it was introduced, causing system failure.
 -  `module_output_changed_when_system_failed_counts` : the number of experiments where the system failed and the output of the module changed.

## Notes
Extract from resultfile:
 zgrep -A5000 -m 1 ^<id> all.results.gz >> res.res