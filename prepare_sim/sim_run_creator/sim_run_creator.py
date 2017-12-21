#!/usr/bin/python

import sys
import re
import ast

# usage: python sim_run_creator.py num_sims [sim_length_in_ns fault_length]
from random import randrange

import argparse

parser = argparse.ArgumentParser(description='Creates a fault paramter set for the simulation. Outputs one line for each parameter set.\nSimulation length is earliest-fault-time+latest-fault-time+cooldown-time.')
parser.add_argument('numexperiments', type=int, help='The number of parameter sets to be generated')
#parser.add_argument('--verbose',action='store_true',
#                    help='Prints progress and additional information.')
parser.add_argument('--latest-fault-time',nargs='?', type=int,
                    default='10000',help='The latest fault injection time in nanoseconds.')
parser.add_argument('--earliest-fault-time',nargs='?', type=int,
                    default='1000',help='The earliest fault injection time in nanoseconds.')
parser.add_argument('--cooldown-time',nargs='?', type=int,
                    default='1000',help='How long after the last fault injection should the simulation keep running.')
parser.add_argument('--length-of-fault',nargs='?', type=int,
                    default='10',help='How long should the injected fault last in nanoseconds')
parser.add_argument('--use-module-only',nargs='?', choices=['lbdr','fifo','arbiter','xbar','all'],
                    default='all',help='Choose only fault locations from the given module. "all" for all modules.')
parser.add_argument('--no-nofault-line',action='store_false',
                    help='Does not add a nofault line to the beginning of the output.')
args = parser.parse_args()



lines = [line.strip() for line in open('../cell_export_parser/results.txt')]
module=args.use_module_only
if module != 'all':
    lines = [l for l in lines if l.split(' ')[2].strip()[1:] == module]

sim_length = args.latest_fault_time
offset = args.earliest_fault_time
fault_length_arg = args.length_of_fault
cooldown_time = args.cooldown_time

for n in range(args.numexperiments):
    break_time_before = randrange(sim_length-offset) + offset
    break_time_after = sim_length - break_time_before + cooldown_time
    fault_value = randrange(2)
    fault_length = fault_length_arg
    break_name = lines[randrange(len(lines))] #' '.join(lines[randrange(len(lines))].split(' ')[:2])
    print(" ".join([str(x) for x in [break_time_before,break_time_after,fault_value,fault_length,break_name]]))