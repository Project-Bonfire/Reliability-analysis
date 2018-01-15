#!/usr/bin/python
import numpy
import numpy as np, scipy.stats as st

# usage: python sim_run_creator.py num_sims [sim_length_in_ns fault_length]
from random import randrange
import random

import argparse
import sys
import scipy

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
group = parser.add_mutually_exclusive_group()
group.add_argument('--use-module-only',nargs='?', choices=['lbdr','fifo','arbiter','xbar','all'],
                    default='all',help='Choose only fault locations from the given module. "all" for all modules.')
group.add_argument('--module-representative-numbers',action='store_true',
                    help='Does not randomly choose fault injection locations, but tries to make the probabilities stable for each module. '
                         'Therefore, the small modules will have a bigger number of lines, then they would have otherwise. Ignores numexperiments')
parser.add_argument('--no-nofault-line',action='store_true',
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

if not args.no_nofault_line:
    print("%d %d %d %d nofault :nofault !nofault"%(0,sim_length+cooldown_time,0,10))

chosenparams = []

if args.module_representative_numbers:
    modulelines = {}
    for k in ['fifo','lbdr','arbiter','xbar']:
        modulelines[k] = [l for l in lines if l.split(' ')[2].strip()[1:].startswith(k)]
    lens = {k: len(v) for k, v in modulelines.items()}
    for k in ['fifo', 'lbdr', 'arbiter', 'xbar']:
        population = (sim_length-offset) / 10 * lens[k]
        if population == 0:
            print("population of %s is 0. Skipping!"%k,file=sys.stderr)
            continue
        dev = 0.5
        z = 1.96
        allowed_margin = 0.02
        ss = z**2 *dev*(1-dev)/allowed_margin**2 #calculate samplesize
        ss = ss/(1+(ss-1)/population) # modify based on population
        chosenparams += random.choices(modulelines[k],k=int(ss))
else:
    chosenparams = random.choices(lines,k=args.numexperiments)



for break_name in chosenparams:
    break_time_before = randrange(sim_length-offset) + offset
    break_time_after = sim_length - break_time_before + cooldown_time
    fault_value = randrange(2)
    fault_length = fault_length_arg
    print(" ".join([str(x) for x in [break_time_before,break_time_after,fault_value,fault_length,break_name]]))