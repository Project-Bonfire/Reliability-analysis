# Copyright (C) Siavoosh Payandeh Azad
# the main idea of reach-ability is from the following paper:
# NoCDepend: A flexible and scalable Dependability Technique for 3D Networks-on-Chip
# how ever, at the moment we only implemented a 2D version of it.
#
# Modifications by Karl Janson in 2019:
#   - Removed functions not needed by the tool
#

from networkx import has_path, shortest_path_length

from ..ArchGraphUtilities.AG_Functions import manhattan_distance
from ..ConfigAndPackages import Config


def is_destination_reachable_via_port(noc_rg, source_node, port, destination_node, report):
    """
    checks if there is a path from source node's port to local port of destination node
    :param noc_rg: NoC Routing Graph
    :param source_node: source node ID
    :param port: port from which a path search starts from source node
    :param destination_node: destination node ID
    :param report: boolean, which enables printing reports to console
    :return: True if there is a path from source's port to destination, False, if no path is found
    """
    # the Source port should be output port since this is output of router to other routers
    source = str(source_node)+str(port)+str('O')
    # the destination port should be output port since this is output of router to PE
    # (which will be connected to PE's input port)
    destination = str(destination_node)+str('L')+str('O')
    if has_path(noc_rg, source, destination):
        return True
    else:
        if report:
            print(("\t\tNO PATH FOUND FROM: ", source, "TO:", destination))
        return False


def is_destination_reachable_from_source(noc_rg, source_node, destination_node):
    """
    checks if destination is reachable from the local port of the source node
    the search starts from the local port
    :param noc_rg: NoC routing graph
    :param source_node: source node id
    :param destination_node: destination node id
    :return: True if there is a path else, False
    """
    # the Source port should be input port since this is input of router
    # (which will be connected to PE's output port)
    source = str(source_node)+str('L')+str('I')
    # the destination port should be output port since this is output of router to PE
    # (which will be connected to PE's input port)
    destination = str(destination_node)+str('L')+str('O')
    if has_path(noc_rg, source, destination):
        if Config.RotingType == 'MinimalPath':
            path_length = shortest_path_length(noc_rg, source, destination) - 1 # TODO: guessed fix by Thilo
            minimal_hop_count = manhattan_distance(source_node, destination_node)
            if (path_length/2) == minimal_hop_count:
                return True
        else:
            return True
    else:
        return False
