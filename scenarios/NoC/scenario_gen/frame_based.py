import argparse
import itertools
import sys
from math import floor
from random import choice, randrange


def parseRange(minimum):
    def parseRange(string):
        args = string.split(",")
        if len(list(filter(lambda s: not s.isdigit(), args))) > 0:
            raise argparse.ArgumentTypeError(
                "Numbers of the range must be digits. And at least %d" % minimum)
        args = [int(x) for x in args]
        if len(args) == 1:
            return range(minimum, args[0])
        if len(args) == 2:
            return range(args[0], args[1])
        if len(args) == 3:
            return range(args[0], args[1], args(2))
        raise argparse.ArgumentTypeError(
            "Must have between 1 and 3 parameters, seperated by `,`, all digits.")
    return parseRange

def xyRouting(source, destination, networksize):
    
    def toID(list):
        return [x + y * networksize for x, y in list]
    
    x_source = source % networksize
    y_source = floor(source / networksize)
    x_subj = destination % networksize
    y_subj = floor(destination / networksize)


    if y_source < y_subj:  # south
        return toID([(x_source, y) for y in range(y_source+1, networksize)])

    if y_source > y_subj:  # south
        return toID([(x_source, y) for y in range(0, y_source)])

    if x_source < x_subj:
        return toID([(x, y) for x, y in itertools.product(range(x_source+1, networksize), range(networksize))])

    if x_source > x_subj:
        return toID([(x, y) for x, y in itertools.product(range(0, x_source), range(networksize))])

    if source == destination:
        return list(set(range(networksize**2)) - {destination})

def main():
    """
    Main function.
    """

    parser = argparse.ArgumentParser(description='Generates a scenariofile for processing a NoC router')

    parser.add_argument('--timeframe', type=int,
                        help='Sets the timeframe. The packetgenerators send one packet in each timeframe.')
                        
    parser.add_argument('--packetlength', type=parseRange(3),
                        help='The packetlengths in the format `min,max`. Example 3,7. Minimal 3. ')

    args = parser.parse_args()

    destinations = range(16)

    time_offset = 300
    time_limit = 10000
    usable_time = time_limit - time_offset
    sources = [1, 4, 6, 9, 5]

    print("Frame length: %d,  Packet length: %s" % (args.timeframe, str(args.packetlength)), file=sys.stderr)

    lines = []
    for framestart in range(time_offset, usable_time, args.timeframe):
        for source in sources:
            packet_length = choice(args.packetlength)
            dest = choice(xyRouting(source, 5, 4))
            offset = randrange(args.timeframe - packet_length)
            
            lines.append("%d ns %d %d %d" %
                        (framestart+offset, source, dest, packet_length))

    print("Generated file with fixed timeframes. Number of entries: %d, Framelength: %d ns, start after: %d ns, Packet lengths: range(%d,%d), time limit: %d" %
        (len(lines), args.timeframe, time_offset, min(args.packetlength), max(args.packetlength), time_limit))

    print("time sourceid destid packetlength")

    for l in lines:
        print(l)


if __name__ == '__main__':

    if (sys.version_info < (3, 6)):
        print("This script is designed to run on Python 3.6 or newer!")
        exit(1)

    main()
