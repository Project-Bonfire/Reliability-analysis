#!/usr/bin/python

import sys

# usage: python sim_run_creator.py num_sims [sim_length_in_ns fault_length]
from random import randrange

lines = [line.strip() for line in open('../cell_export_parser/results.txt')]

sim_length = int(sys.argv[2]) if len(sys.argv) > 2 else 9000
offset = 1000
fault_length_arg = int(sys.argv[3]) if len(sys.argv) > 3 else 10

for n in range(int(sys.argv[1])):
    break_time_before = randrange(sim_length) + offset
    break_time_after = sim_length - break_time_before
    fault_value = randrange(2)
    fault_length = fault_length_arg
    break_name = lines[randrange(len(lines))] #' '.join(lines[randrange(len(lines))].split(' ')[:2])
    print(" ".join([str(x) for x in [break_time_before,break_time_after,fault_value,fault_length,break_name]]))