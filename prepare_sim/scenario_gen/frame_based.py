from math import floor
from random import randrange, choice

import itertools

timeframe = 50
sources = [1,4,6,9,5]
destinations = range(16)
time_offset = 50
time_limit = 10000
packet_lengths = range(3,9)

def xyrouting(source,subject,networksize):
    x_source = source % networksize
    y_source = floor(source / networksize)
    x_subj = subject % networksize
    y_subj = floor(subject / networksize)
    def toid(list):
        return [x + y * networksize for x,y in list]
    if y_source<y_subj: #south
        return toid([(x_source,y) for y in range(y_source+1,networksize)])
    if y_source>y_subj: #south
        return toid([(x_source,y) for y in range(0,y_source)])
    if x_source < x_subj:
        return toid([(x,y) for x, y in itertools.product(range(x_source+1,networksize),range(networksize))])
    if x_source > x_subj:
        return toid([(x,y) for x, y in itertools.product(range(0,x_source),range(networksize))])
    if source == subject:
        return list(set(range(networksize**2)) - {subject})

lines=[]
for framestart in range(time_offset,time_limit,timeframe):
    for source in sources:
        length = choice(packet_lengths)
        dest = choice(xyrouting(source,5,4))
        offset= randrange(timeframe-length)
        lines.append("%d ns %d %d %d"%(framestart+offset,source,dest,length))

print("Generated file with fixed timeframes. Number of entries: %d, Framelength: %d ns, start after: %d ns, Packet lengths: range(%d,%d), time limit: %d" %(len(lines),timeframe,time_offset,min(packet_lengths),max(packet_lengths),time_limit))
print("time sourceid destid packetlength")
for l in lines:
    print(l)