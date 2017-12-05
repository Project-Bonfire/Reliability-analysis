#Eval Sim

Evaluates the results of a simulation. Detects faults in the experiments and calculates the fault probability.

 For the parameters see `--help` of eval.py.

## Setup
 To install the dependencies, install the requirements in `requirements.txt` and install the python3 version 
 of SocDep2. You may install the version from this repository by:
 ```
 python3 SocDep2_egged/setup.py install
 ```


## Notes
Extract from resultfile:
 zgrep -A5000 -m 1 ^<id> all.results.gz >> res.res