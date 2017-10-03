import copy

import os

import re

import sys
from collections import Counter
from operator import attrgetter, sub

import itertools

import numpy as np

from ArchGraphUtilities.AG_Functions import *

from RoutingAlgorithms import Routing
from ConfigAndPackages import Config, PackageFile
from RoutingAlgorithms.Calculate_Reachability import is_destination_reachable_via_port, \
    is_destination_reachable_from_source
from RoutingAlgorithms.RoutingGraph_Reports import draw_rg
from SystemHealthMonitoring import SystemHealthMonitoringUnit

from Utilities import misc

misc.generate_file_directories()
turns_health_2d_network = {"N2W": True, "N2E": True, "S2W": True, "S2E": True,
                           "W2N": True, "W2S": True, "E2N": True, "E2S": True}

Config.ag.topology = '2DMesh'
Config.ag.x_size = 4
Config.ag.y_size = 4
Config.ag.z_size = 1
Config.RoutingType = 'MinimalPath'

ag = copy.deepcopy(generate_ag(logging=None))

shmu = SystemHealthMonitoringUnit.SystemHealthMonitoringUnit()
shmu.setup_noc_shm(ag, copy.deepcopy(turns_health_2d_network), False)
noc_rg = copy.deepcopy(Routing.generate_noc_route_graph(ag, shmu, PackageFile.XY_TurnModel, False, False))
dirname = "/home/thilo/git/Reliability-analysis/results/results/"


class Result:
    def __init__(self):
        pass

    name = ""
    # If the run failed somehow, means there are now files present
    errornous = False
    # flags
    unexpected_len_sent = False
    unexpected_len_recv = False
    # number of actual packets
    len_sent = -1
    len_recv = -1

    # due to misrouting or misinjecting
    sents_invalid = 0
    recv_invalid = 0

    # the parameters of the simulation
    params = ""

    def is_valid(self):
        return not (
            self.unexpected_len_recv or self.unexpected_len_sent or self.sents_invalid > 0 or self.recv_invalid > 0 or self.errornous)

    def __str__(self):
        return "[Name %s, Error: %r, unexpected_len_sent %r, unexpected_len_recv %r, len_sent %d, len_recv %d, sents_invalid %d, recv_invalid %d, Params: %s]" % \
               (self.name, self.errornous, self.unexpected_len_sent, self.unexpected_len_recv, self.len_sent,
                self.len_recv, self.sents_invalid, self.recv_invalid, self.params)


class PacketEvent:
    def __init__(self):
        pass

    # According to router 5
    on_in_port = False
    on_out_port = False

    time = 0
    from_node = -1
    to_node = -1
    length = -1
    in_router = -1
    actual_length = -1
    id = -1

    def __str__(self):
        return "[Time=%d,From=%d,To=%d,Length=%d,Event_Location=%d,Actual_Length=%d,ID=%d]" % (
            self.time, self.from_node, self.to_node, self.length, self.in_router, self.actual_length, self.id)

    def switch_dir(self, dir):
        return {"S": "N",
                "N": "S",
                "W": "E",
                "E": "W",
                "L": "L"}[dir]

    def was_going_out_via(self):
        """
        This for incoming packets to determine the right out port of the sending router.
        returns from which side of the adjacent router of router 5 the packet went out
        so a packet from router 4 should return "W"
        :rtype: S|W|E|N as string

        """
        if not self.on_in_port:
            raise AssertionError("this is not an incoming packet event!")
        return self.switch_dir(self.pos_is_in_dir(self.from_node))

    def going_out_via(self):
        """
        returns to which side of the router 5 the packet traveled
        :rtype: S|W|E|N|L as string

        """
        if not self.on_out_port:
            raise AssertionError("this is not an outgoing packet event!")
        return self.pos_is_in_dir(self.in_router)

    def pos_is_in_dir(self, router_id):
        # type: (int) -> str
        """
        returns in which direction according to router 5 the given router id is
        :param router_id:
        :return: W|E|N|S|L as str
        """
        if router_id == 5:
            return "L"
        x = router_id % Config.ag.x_size
        y = router_id / Config.ag.y_size
        if x < 1:
            return "W"
        if x > 1:
            return "E"
        if y < 1:
            return "S"
        if y > 1:
            return "N"


def parse_sent_line(line):
    # type: (str) -> PacketEvent
    """
    Parser for a line of the sent file.
    Lines look like : "Packet generated at 900000 ps From 4 to 6 with length: 8 id: 2"
    :param line: the line to parse
    :return: a Packet event
    """
    m = re.findall(ur"([\d]+)", line)
    pe = PacketEvent()
    pe.time = int(m[0])
    pe.from_node = int(m[1])
    pe.to_node = int(m[2])
    pe.length = int(m[3])
    pe.id = int(m[4])
    pe.in_router = pe.from_node
    pe.actual_length = pe.length
    pe.on_in_port = True
    return pe


def parse_recv_line(line):
    # type: (str) -> PacketEvent
    """
    Parser for a line of the received file.
    Lines look like : "Packet received at 845000 ps InRouter: 1 From: 9 to: 1 length: 8 actual length: 8 id: 1
    :param line: the line to parse
    :return: a Packet event
    """
    m = re.findall(ur"([\d]+)", line)
    pe = PacketEvent()
    pe.time = int(m[0])
    pe.in_router = int(m[1])
    pe.from_node = int(m[2])
    pe.to_node = int(m[3])
    pe.length = int(m[4])
    pe.actual_length = int(m[5])
    pe.id = int(m[6])
    pe.on_out_port = True
    return pe


assumed_sent = -1
results = []
counter = 0
for name in os.listdir(dirname):
    counter += 1
    if counter % 100 == 0:
        print("Processed: %d"%counter)

    res = Result()
    res.name = name
    try:
        recv = [parse_recv_line(line) for line in open(dirname + name + "/received.txt", "r").readlines() if
                line.strip()]
        sent = [parse_sent_line(line) for line in open(dirname + name + "/sent.txt", "r").readlines() if line.strip()]
        res.params = open(dirname + name + "/params.txt", "r").readlines()[0].strip()
        res.len_recv = len(recv)
        res.len_sent = len(sent)
        if assumed_sent == -1:
            assumed_sent = len(sent)
        res.unexpected_len_sent = len(sent) != assumed_sent
        # If the first one is faulty, we run into problems here.
        # But that might not happen anyways
        if False and len(sent) != assumed_sent:
            print("WARNING: The sent file of '%s' has an unexpected length of %d, expected %d." % (
                name, len(sent), assumed_sent))
        res.unexpected_len_recv = len(recv) != len(sent)
        for p in sent:
            reulst = False
            if p.from_node is not 5:
                result = is_destination_reachable_via_port(noc_rg, p.from_node, p.was_going_out_via(), p.to_node, False)
            else:
                result = is_destination_reachable_from_source(noc_rg, 5, p.to_node)
            if not result:
                print(
                    "WARNING: Generated Packet was not valid according to routing algorithm. Packet was sent from %d %s to %d via router 5. %s" % (
                        p.from_node, p.was_going_out_via(), p.to_node, str(p)))
                res.sents_invalid += 1
        for p in recv:
            result = is_destination_reachable_via_port(noc_rg, 5, p.going_out_via(), p.to_node, False)
            if not result:
                print(
                    "WARNING: Generated Packet was not valid according to routing algorithm. Packet was sent from %d %s to %d via router 5. %s" % (
                        p.from_node, p.was_going_out_via(), p.to_node, str(p)))
                res.sents_invalid += 1

    except:
        print("Unexpected error:", sys.exc_info()[0])
        res.errornous = True
    results.append(res)
failcounter = 0
print("failed runs:")
for res in results:
    if not res.is_valid():
        print(res)
        failcounter += 1

all_result = (
    attrgetter('name', 'errornous', 'unexpected_len_sent', 'unexpected_len_recv', 'len_sent', 'len_recv',
               'sents_invalid',
               'recv_invalid', 'params')(obj) for obj in results)
names, errors, uls, ulr, ls, lr, si, ri, params = itertools.izip_longest(*all_result)

print("------------Statistics---------------")
print('Total Number of runs: %d' % counter)
print ("Runs with unexpected behavior: %d Ratio: %f" % (failcounter, failcounter / counter))
print('IDs: %s' % ' '.join(sorted([obj.name for obj in results if not obj.is_valid()])))
print('Total number of errors: %d' % sum(errors))
print('Total number of runs with an unexpected amount of sent packets: %d' % sum(uls))
print('Total number of runs with an unexpected amount of recv packets: %d' % sum(ulr))
print('Maximum number of sent packets: %d' % max(ls))
print('Average number of sent packets: %f' % (sum(ls) / float(len(ls))))
print('Minimum number of sent packets: %d' % min(ls))
print('Maximum number of recv packets: %d' % max(lr))
print('Average number of recv packets: %f' % (sum(lr) / float(len(lr))))
print('Minimum number of recv packets: %d' % min(lr))
print('Average difference between number of sent and received packets: %f' % (sum(map(sub, ls, lr)) / float(len(ls))))
avg_dif_wdif_list = filter(lambda x: x != 0, map(sub, ls, lr))
avg_dif_wdif = sum(map(abs, avg_dif_wdif_list)) / float(len(avg_dif_wdif_list))
print('Average difference between number of sent and received packets (only when different): %f' % avg_dif_wdif)
print('Average absolute difference between number of sent and received packets (only when different): %f' % (
    sum(map(abs, avg_dif_wdif_list)) / float(len(avg_dif_wdif_list))))
print('Variance of the difference between number of sent and received packets (only when different): %f' % np.var(
    avg_dif_wdif_list))

print('Average number of wrong injected packets: %d' % (sum(si) / float(len(si))))
print('Average number of wrong routed packets (XY Routing): %d' % (sum(ri) / float(len(ri))))
print('Maximum number of wrong routed packets (XY Routing): %d' % max(ri))

paramlist = [obj.params.split(' ') for obj in results if not obj.is_valid()]
breaktimes, breaktimesa, faultvalues, faultlengths, breakname1, breakname2 = itertools.izip_longest(*paramlist)
breaktimes = map(int, breaktimes)
faultvalues = map(int, faultvalues)
print('Average breaktime which lead to a fault: %f' % (sum(breaktimes) / float(len(breaktimes))))
print('Maximum breaktime which lead to a fault: %f' % (max(breaktimes)))
print('Average faultvalue: %f' % (sum(faultvalues) / float(len(faultvalues))))
print('Which pins broke something statistic: ')
print(Counter(breakname2))
# Look at difflib, maybe matching blocks
total = 0
for pattern in ['U', '\\LBDR', '\\FIFO']:
    tmp = len(filter(lambda s: s.startswith(pattern), breakname1))
    total += tmp
    print('"%s" broke something: %d' % (pattern, tmp))
if total < len(breakname2):
    print('Missed %d patterns!', (len(breakname2) - counter))
print("------------Statistics---------------")
