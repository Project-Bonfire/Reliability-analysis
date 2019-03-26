#!/usr/bin/python3

"""
Creates list experiments to run

Input: List of all fault locations in the design (gatelevel netlist)
Output: List of experiments to be run

Output file format:
<runtime before fault injection> <runtime after injection> <fault value (SA-0 / SA-1)> <Length of the fault> <fault location (signal name)>

Usage: python3 sim_run_creator.py input_file output_file num_sims [sim_length_in_ns args.fault_length]
"""

import argparse
import sys
from random import randrange, choices

def main(args):

    # Read fault locations file
    fault_locations = [line.strip() for line in args.faultlocs_file]

    print("Choosing from %d possible fault locations" % len(fault_locations))
    print()

    # Does not add a nofault line to the beginning of the output.
    if not args.no_nofault_line:
        print("%d %d %d %d nofault :nofault !nofault" %
            (0, args.latest_fault_time + args.cooldown_time, 0, 10), file=args.output_file)

    chosen_experiments = []

    # Does not randomly choose fault injection locations,
    # but tries to make the probabilities stable for each
    # module. Therefore, the small modules will have a
    # bigger number of experiments run, than they would have
    # otherwise. Ignores _

    modulelines = {}

    # Find all modules in fault locations files
    for location in fault_locations:
        module_name = location.split(' ')[2].strip()[1:]
        modulelines.setdefault(module_name, []).append(location)

    if 'none' in modulelines:
        del modulelines['none']

    max_module_name_len = len(max(modulelines.keys(), key=len)) + 1

    module_fault_location_counts = {module_name: len(locs) for module_name, locs in modulelines.items()}

    print("Number of fault locations per module")
    for module_name in sorted(modulelines.keys(), key=lambda x: x[0]):
        name_len_difference = max_module_name_len - len(module_name)
        print("\t%s:%s%d" %
                (module_name, name_len_difference * ' ', module_fault_location_counts[module_name]))

    print()
    print("Experiments created per module:")

    for module_name in sorted(modulelines.keys(), key=lambda x: x[0]):

        name_len_difference = max_module_name_len - len(module_name)

        if args.module_representative_numbers:

            # Population = <number of fault injection time points> * <number of fault injectionlocations>
            population = (args.latest_fault_time - args.earliest_fault_time) / args.fault_length * \
                module_fault_location_counts[module_name]

            if population == 0:
                print("population of %s is 0. Skipping!" % module_name)
                continue

            dev = 0.5
            z = 1.96
            allowed_margin = 2 * 0.01
            # calculate samplesize
            ss = z**2 * dev * (1 - dev) / allowed_margin**2

            ss_m = ss / (1 + ((ss - 1) / population))

            print("\t%s:%sExperiments: %d (population=%d)" %
                (module_name, name_len_difference * ' ', ss_m, population))

            chosen_experiments += choices(modulelines[module_name], k=int(ss_m))

        else:
            chosen_experiments += modulelines[module_name]
        
            print("\t%s:%sExperiments: %d" %
            (module_name, name_len_difference * ' ', len(modulelines[module_name])))

    print()
    print('Total number of experiments to run (2 experiments will be done for each injection point - one for SA-0 and one for SA-1):', len(chosen_experiments) * 2)
    print()

    # Build injection locations file
    print("Storing fault injection experiments to:", args.output_file.name)
    print()

    # SA-1
    for injection_location in chosen_experiments:
        time_before_injection = randrange(args.latest_fault_time - args.earliest_fault_time) + args.earliest_fault_time
        time_after_injection = args.latest_fault_time - time_before_injection + args.cooldown_time

        # Whether we inject 0 or 1 transient SA-0 or SA-1
        fault_value = 1 #randrange(2)

        print(" ".join([str(x) for x in [time_before_injection,
                                        time_after_injection, fault_value, args.fault_length, injection_location]]),
            file=args.output_file)

    # SA-0
    for injection_location in chosen_experiments:
        time_before_injection = randrange(args.latest_fault_time - args.earliest_fault_time) + args.earliest_fault_time
        time_after_injection = args.latest_fault_time - time_before_injection + args.cooldown_time

        # Whether we inject 0 or 1 transient SA-0 or SA-1
        fault_value = 0 #randrange(2)

        print(" ".join([str(x) for x in [time_before_injection,
                                        time_after_injection, fault_value, args.fault_length, injection_location]]),
            file=args.output_file)


if __name__ == '__main__':
    if (sys.version_info < (3, 6)):
        print("This script is designed to run on Python 3.6 or newer!")
        exit(1)


    # Argument Parsing
    parser = argparse.ArgumentParser(
        description='Creates a fault parameter set for the simulation. Outputs one line for each parameter set.\n'
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
                        type=int, default='10000',
                        help='How long after the last fault injection should the simulation keep running.')

    parser.add_argument('--fault-length', nargs='?',
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

    main(args)
