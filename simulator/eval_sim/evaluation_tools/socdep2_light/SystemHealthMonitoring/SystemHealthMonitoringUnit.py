# Copyright (C) 2015 Siavoosh Payandeh Azad
#
# Modifications by Karl Janson in 2019:
#   - Removed functions not needed by the current toolchain
#   - Converted to Python3
#   - Converted to work with Networkx 2.x
#

import random
import re
from copy import deepcopy

import networkx

from ..ConfigAndPackages import Config


class SystemHealthMonitoringUnit:
    def __init__(self):
        self.SHM = networkx.DiGraph()   # System Health Map

    def setup_noc_shm(self, ag, turns_health, report):
        if report:
            print ("===========================================")
            print ("PREPARING SYSTEM HEALTH MAP...")
        if not Config.SetRoutingFromFile:
            for node in ag.nodes():
                self.SHM.add_node(node, TurnsHealth=deepcopy(turns_health), NodeHealth=True, NodeSpeed=100,
                                  RouterTemp=10, NodeTemp=random.randint(0, Config.MaxTemp))
        else:
            try:
                routing_file = open(Config.RoutingFilePath, 'r')
            except IOError:
                print(('CAN NOT OPEN', Config.RoutingFilePath))

            while True:
                line = routing_file.readline()
                if "Ports" in line:
                    ports = routing_file.readline()
                    port_list = ports.split()
                    print(("port_list:", port_list))
                if "Node" in line:
                    node_id = int(re.search(r'\d+', line).group())
                    node_turns_health = deepcopy(turns_health)
                    line = routing_file.readline()
                    turns_list = line.split()
                    for turn in list(node_turns_health.keys()):
                        if turn not in turns_list:
                            node_turns_health[turn] = False
                    self.SHM.add_node(node_id, TurnsHealth=deepcopy(node_turns_health), NodeHealth=True,
                                      NodeSpeed=100, RouterTemp=0, NodeTemp=0)
                if line == '':
                    break
            for node in ag.nodes():
                if node not in self.SHM.nodes():
                    self.SHM.add_node(node, TurnsHealth=deepcopy(turns_health), NodeHealth=True,
                                      NodeSpeed=100, RouterTemp=0, NodeTemp=0)
        for link in list(ag.edges()):
            self.SHM.add_edge(link[0], link[1], LinkHealth=True)

        # self.system_degradation = self.calculate_system_degradation()
        if report:
            print ("SYSTEM HEALTH MAP CREATED...")
