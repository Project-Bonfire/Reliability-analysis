#!/usr/bin/python3

"""
Scenario generator for network-on-chip (NoC).
In generates simulation scenarios for the NoC routers

usage: scn_generator.py <option_string for packet generators> <folder of the design to be analyzed> <output scenario file>
"""


import argparse
import itertools
import os
import sys
from math import floor
from random import choice, randrange

# Add here the names of functions used for implementation of different routing algorithms routing
ROUTING_HANDLERS = [
    'xyRouting'
]

def xyRouting(source, curr_addr, networksize):
    """
    Calculates destination address using the XY routing algorithm so that
    the routing path would pass through the router with curr_addr

    Params:
        source: source of the packet
        curr_addr: the addess of the router where the packet has to go through
        networksize: size of the network (only single side, as a square network (X=Y) is assumed)

    Return:
        The address of the destination node.
    """

    def toID(list):
        return [x + y * networksize for x, y in list]

    x_source = source % networksize
    y_source = floor(source / networksize)
    x_address = curr_addr % networksize
    y_address = floor(curr_addr / networksize)

    if y_source < y_address:  # south
        return toID([(x_source, y) for y in range(y_source+1, networksize)])

    if y_source > y_address:  # south
        return toID([(x_source, y) for y in range(0, y_source)])

    if x_source < x_address:
        return toID([(x, y) for x, y in itertools.product(range(x_source+1, networksize), range(networksize))])

    if x_source > x_address:
        return toID([(x, y) for x, y in itertools.product(range(0, x_source), range(networksize))])

    if source == curr_addr:
        return list(set(range(networksize**2)) - {curr_addr})


def main():
    """
    Main function.
    """

    parser = argparse.ArgumentParser(
        description='Generates a scenariofile for processing a NoC router')
    parser.add_argument('optionstr', type=str,
                        help='Options for the packet generators. Expected format is "<min_packet_length>,<max_packet_length> <frame_length>"')

    parser.add_argument('designfolder', type=str,
                        help='Folder where the currently analyzed design is located')

    parser.add_argument('scnfile', type=str,
                        help='Scenario file to be generated')

    args = parser.parse_args()

    try:
        options = args.optionstr.strip('"').split(' ')
        packetlength = [int(s) for s in options[0].split(',')]
        timeframe = int(options[1])

    except (ValueError, IndexError) as err:
        print('E R R O R: Invalid option string:',
              args.optionstr, file=sys.stderr)
        print('The expected format is: "<min_packet_length>,<max_packet_length> <frame_length>"', file=sys.stderr)
        print('THe message was:', err, file=sys.stderr)
        print()
        exit(1)

    time_offset = 300
    time_limit = 10000
    usable_time = time_limit - time_offset

    # Since in those experiments we are investigating Router 5 in a 4x4 network and we need data to pass through the router,
    # we investigate only packets sent from Router 5 and its neighboring routers
    sources = [1, 4, 6, 9, 5]

    print('Frame length: %d,  Packet length: %s' %
          (timeframe, str(packetlength)))

    # Detect routing algorithm from the design configuration
    ralgo = None
    try:
        with open(os.path.join(args.designfolder, 'designinfo.txt'), 'r') as design_info:
            for line in design_info:
                if 'ralgo_name' in line:
                    ralgo = line.split('=')[1].replace('\"', '').strip()
                    print("Detected routing algorithm:", ralgo)
                    break

    except FileNotFoundError as err:
        print('\nE R R O R ! Cannot access design info file:', os.path.join(
            args.designfolder, 'designinfo.txt'), file=sys.stderr)
        print('The error was:', err, '\n', file=sys.stderr)
        sys.exit(1)

    except IndexError as err:
        print('\nE R R O R ! Badly formatted \'ralgo_name\' string in designinfo.txt. The correct format is:', file=sys.stderr)
        print('ralgo_name="<name_of_the_routing_algorithm>"', file=sys.stderr)
        print('The error was:', err, '\n', file=sys.stderr)
        sys.exit(1)

    if ralgo not in ROUTING_HANDLERS:
        print('E R R O R ! Unknown routing algorithm:', ralgo, file=sys.stderr)
        print('Usable values are:', ROUTING_HANDLERS, file=sys.stderr)

    # Calculate the scenarios
    scn_lines = []
    for framestart in range(time_offset, usable_time, timeframe):
        for source in sources:
            packet_length = choice(packetlength)
            dest = choice(eval(ralgo + '(source, 5, 4)')) # ex: yxRouting(source, 5, 4)
            offset = randrange(timeframe - packet_length)

            scn_lines.append("%d ns %d %d %d" %
                             (framestart+offset, source, dest, packet_length))

    # Store the differences in a file
    try:
        with open(args.scnfile, 'w') as scn_file:
            print('Generated file with fixed timeframes. Number of entries: %d, Framelength: %d ns, '
                    'start after: %d ns, Packet lengths: range(%d,%d), time limit: %d' %
                  (len(scn_lines), timeframe, time_offset, min(packetlength), max(packetlength), time_limit), file=scn_file)

            print('time sourceid destid packetlength', file=scn_file)

            count = 0
            for idx, line in enumerate(scn_lines):
                print(line, file=scn_file)
                count = idx

            print("Generated %d scenario lines" % count)
            print()

    except FileNotFoundError as err:
        print('\nE R R O R ! Cannot write scenario file:',
              args.scnfile, file=sys.stderr)
        print('The error was:', err, '\n', file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':

    if (sys.version_info < (3, 6)):
        print('This script is designed to run on Python 3.6 or newer!')
        exit(1)

    print('======================')
    print('NoC SCENARIO GENERATOR')
    print('======================')

    main()
