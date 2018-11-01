#!/usr/bin/python3

"""
Creates list experiments to run

Input: List of all fault locations in the design (gatelevel netlist)
Output: List of experiments to be run

Output file format:
<runtime before fault injection> <runtime after injection> <fault value (SA-0 / SA-1)> <Lenghth of the fault> <fault location (signal name)>

Usage: python3 sim_run_creator.py input_file output_file num_sims [sim_length_in_ns fault_length]
"""

import argparse
import sys
from random import randrange, choices

if (sys.version_info < (3, 6)):
    print("This script is designed to run on Python 3.6 or newer!")
    exit (1)


# Argument Parsing
parser = argparse.ArgumentParser(
    description='Creates a fault paramter set for the simulation. Outputs one line for each parameter set.\n'
                'Simulation length is earliest-fault-time+latest-fault-time+cooldown-time.')

parser.add_argument('faultlocs_file', 
                        type=argparse.FileType('r'), 
                        help='The file with all possible fault locs.')

parser.add_argument('output_file', 
                        type=argparse.FileType('w'), 
                        help='The file where to store the list of fault experiments')

parser.add_argument('num_experiments', type=int,
                    help='The number of parameter sets to be generated')

parser.add_argument('--latest-fault-time', 
                    nargs='?', type=int,
                    default='10000', 
                    help='The latest fault injection time in nanoseconds.')

parser.add_argument('--earliest-fault-time', nargs='?', 
                    type=int, default='1000', 
                    help='The earliest fault injection time in nanoseconds.')

parser.add_argument('--cooldown-time', nargs='?', 
                    type=int, default='1000', 
                    help='How long after the last fault injection should the simulation keep running.')

parser.add_argument('--length-of-fault', nargs='?', 
                    type=int, default='10', 
                    help='How long should the injected fault last in nanoseconds')

group = parser.add_mutually_exclusive_group()
group.add_argument('--use-module-only', nargs='?', default='all', 
                    choices=['lbdr', 'fifo', 'arbiter', 'xbar', 'all'],
                    help='Choose only fault locations from the given module. "all" for all modules.')

group.add_argument('--module-representative-numbers', action='store_true',
                   help='Does not randomly choose fault injection locations, but tries to make the probabilities stable for each module. '
                        'Therefore, the small modules will have a bigger number of experiments run, than they would have otherwise. '
                        'Ignores _')

parser.add_argument('--no-nofault-line', action='store_true',
                    help='Does not add a nofault line to the beginning of the output.')
args = parser.parse_args()

print("Starting simulation run creator...")
print("==================================")

# Read fault locations file
fault_locations = [line.strip() for line in args.faultlocs_file]
module = args.use_module_only

if module != 'all':
    fault_locations = [location for location in fault_locations if location.split(' ')[2].strip()[1:] == module]

print("Choosing from %d possible fault locations" % len(fault_locations))

sim_length = args.latest_fault_time
offset = args.earliest_fault_time
fault_length_arg = args.length_of_fault
cooldown_time = args.cooldown_time

# Does not add a nofault line to the beginning of the output.
if not args.no_nofault_line:
    print("%d %d %d %d nofault :nofault !nofault" %
          (0, sim_length + cooldown_time, 0, 10), file=args.output_file)

chosen_experiments = []

# Does not randomly choose fault injection locations,
# but tries to make the probabilities stable for each
# module. Therefore, the small modules will have a
# bigger number of experiments run, than they would have
# otherwise. Ignores _

if args.module_representative_numbers:
    modulelines = {}

    # Find all modules in fault locations files
    for location in fault_locations:
        module_name = location.split(' ')[2].strip()[1:]
        modulelines.setdefault(module_name, []).append(location)

    if 'none' in modulelines:
        del modulelines['none']

    module_location_counts = {module_name: len(locs) for module_name, locs in modulelines.items()}
    print("Number of fault locations per module:", module_location_counts)

    print("Experiments created per module:")
    max_module_name_len = len(max(modulelines.keys(), key=len)) + 1

    for module_name in modulelines.keys():
        population = (sim_length - offset) / 10 * module_location_counts[module_name]

        if population == 0:
            print("population of %s is 0. Skipping!" % module_name)
            continue

        dev = 0.5
        z = 1.96
        allowed_margin = 0.02
        ss_pre = z**2 * dev * (1 - dev) / allowed_margin**2  # calculate samplesize
        ss_pre = ss_pre / (1 + (ss_pre - 1) / population)
        ss = ss_pre  # modify based on population

        name_len_difference = max_module_name_len - len(module_name)
        print("\t%s:%sExperiments: %d (population=%d)" %
              (module_name, name_len_difference * ' ', ss, population))
              
        chosen_experiments += choices(modulelines[module_name], k=int(ss))

else:
    chosen_experiments = choices(fault_locations, k=args._)

# Build injection locations file
print("Storing fault injection experiments to:", args.output_file.name)
for injection_location in chosen_experiments:
    time_before_injection = randrange(sim_length - offset) + offset
    time_after_injection = sim_length - time_before_injection + cooldown_time

    # Whether we inject 0 or 1 transient SA-0 or SA-1
    fault_value = randrange(2)
    fault_length = fault_length_arg

    print(" ".join([str(x) for x in [time_before_injection,
                                     time_after_injection, fault_value, fault_length, injection_location]]), 
                                     file=args.output_file)
