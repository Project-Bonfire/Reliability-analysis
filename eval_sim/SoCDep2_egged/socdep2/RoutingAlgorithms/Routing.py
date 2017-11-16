# Copyright (C) 2015 Siavoosh Payandeh Azad

from networkx import all_simple_paths, DiGraph, has_path, all_shortest_paths
from re import search
from socdep2.ConfigAndPackages import Config
from socdep2.ArchGraphUtilities.AG_Functions import manhattan_distance
from RoutingGraph_Reports import report_turn_model


def generate_noc_route_graph(ag, shmu, turn_model, report, detailed_report):
    """
    This function takes the Architecture graph and the health status of the Architecture
    and generates the route graph... route graph is a graph that has all the paths available
    and we can find graph algorithms to find paths...
    :param ag: Architecture Graph
    :param shmu: System Health Monitoring Unit
    :param turn_model: turn model for the network['E2N', 'E2S', 'W2N', 'W2S']
    :param report: boolean, which decides if function should print reports to console?
    :param detailed_report: boolean, decides if function should print detailed report to console
    :return: RouteGraph
    """

    # ACKNOWLEDGEMENT:: The Routing Graph is based on the idea from Thilo Kogge's Bachelor's Thesis

    # all the links that go inside the router are called in
    #
    #              _______|____|______
    #             |       O    I      |
    #             |                  O|----> E out
    # W in ---->  |I                  |
    #             |                  I|<---- E in
    #             |                   |
    # W out <---- |O                  |
    #             |                 O/
    #             |_____I___O______I/
    #                   |   |
    #
    # the turns should be named with port 2 port naming convention...
    # E2N is a turn that connects input of East port of the router to
    # output of north

    # todo: add virtual channel support for the routing graph...
    if report:
        print ("===========================================")
        print ("STARTING BUILDING ROUTING ARCHITECTURE...")
        report_turn_model(turn_model)

    # the order is crucial... do not change
    # to find out why its important, check: connect direct paths
    if Config.ag.z_size == 1:
        port_list = ['N', 'W', 'L', 'E', 'S']
    elif Config.ag.z_size > 1:
        port_list = ['U', 'N', 'W', 'L', 'E', 'S', 'D']

    noc_rg = DiGraph()
    for node in ag.nodes():
        if detailed_report:
            print ("GENERATING PORTS:")
        for port in port_list:
            if detailed_report:
                print ("\t", str(node)+str(port)+str('I'), "&", str(node)+str(port)+str('O'))
            noc_rg.add_node(str(node)+str(port)+str('I'), Node=node, Port=port, Dir='I')
            noc_rg.add_node(str(node)+str(port)+str('O'), Node=node, Port=port, Dir='O')
        if detailed_report:
            print ("CONNECTING LOCAL PATHS:")
        for port in port_list:       # connect local to every output port
            if port != 'L':
                noc_rg.add_edge(str(node)+str('L')+str('I'), str(node)+str(port)+str('O'))
                if detailed_report:
                    print ("\t", 'L', "--->", port)
                noc_rg.add_edge(str(node)+str(port)+str('I'), str(node)+str('L')+str('O'))
                if detailed_report:
                    print ("\t", port, "--->", 'L')
        if detailed_report:
            print ("CONNECTING DIRECT PATHS:")
        for i in range(0, int(len(port_list))):   # connect direct paths
            if port_list[i] != 'L':
                if detailed_report:
                    print ("\t", port_list[i], "--->", port_list[len(port_list)-1-i])
                in_id = str(node)+str(port_list[i])+str('I')
                out_id = str(node)+str(port_list[len(port_list)-1-i])+str('O')
                noc_rg.add_edge(in_id, out_id)

        if detailed_report:
            print ("CONNECTING TURNS:")
        for turn in turn_model:
            if turn in shmu.SHM.node[node]['TurnsHealth']:
                if shmu.SHM.node[node]['TurnsHealth'][turn]:
                    in_port = turn[0]
                    out_port = turn[2]
                    if in_port != out_port:
                        noc_rg.add_edge(str(node)+str(in_port)+str('I'), str(node)+str(out_port)+str('O'))
                    else:       # just for defensive programming reasons...
                        print ("\033[31mERROR::\033[0m U-TURN DETECTED!")
                        print ("TERMINATING THE PROGRAM...")
                        print ("HINT: CHECK YOUR TURN MODEL!")
                        raise ValueError('U-TURN DETECTED IN TURN MODEL!')
                    if detailed_report:
                        print ("\t", in_port, "--->", out_port)
        if detailed_report:
            print ("------------------------")

    for link in ag.edges():     # here we should connect connections between routers
        port = ag.edge[link[0]][link[1]]['Port']
        if shmu.SHM[link[0]][link[1]]['LinkHealth']:
            if detailed_report:
                print ("CONNECTING LINK:", link, "BY CONNECTING:", str(link[0])+str(port[0])+str('-Out'),
                       "TO:", str(link[1])+str(port[1])+str('-In'))
            noc_rg.add_edge(str(link[0])+str(port[0])+str('O'), str(link[1])+str(port[1])+str('I'))
        else:
            if detailed_report:
                print ("BROKEN LINK:", link)
    if report:
        print ("ROUTE GRAPH IS READY... ")
    return noc_rg


def gen_noc_route_graph_from_file(ag, shmu, routing_file_path, report, detailed_report):
    """
    This function might come very handy specially in relation to different routing algorithms that we can
    implement to increase reachability... (for example odd-even)
    :param ag: Architecture graph
    :param shmu: System health monitoring unit
    :param routing_file_path: is the path to a file that contains routing information for each individual router
    :param report: boolean, which decides if function should print reports to console?
    :param detailed_report: boolean, decides if function should print detailed report to console
    :return: noc routing graph
    """
    if report:
        print ("===========================================")
        print ("STARTING BUILDING ROUTING ARCHITECTURE...")
    noc_rg = DiGraph()
    try:
        routing_file = open(routing_file_path, 'r')
    except IOError:
        print ('CAN NOT OPEN', routing_file_path)
    nodes_covered_in_file = []
    while True:
        line = routing_file.readline()
        if "Ports" in line:
            ports = routing_file.readline()
            port_list = ports.split()
            if detailed_report:
                print ("PortList", port_list)
        if "Node" in line:
            node_id = int(search(r'\d+', line).group())
            nodes_covered_in_file.append(node_id)
            if detailed_report:
                print ("NodeID", node_id)
                print ("GENERATING PORTS:")
            for port in port_list:
                if detailed_report:
                    print ("\t", str(node_id)+str(port)+str('I'), "&", str(node_id)+str(port)+str('O'))
                noc_rg.add_node(str(node_id)+str(port)+str('I'), Node=node_id, Port=port, Dir='I')
                noc_rg.add_node(str(node_id)+str(port)+str('O'), Node=node_id, Port=port, Dir='O')
            if detailed_report:
                print ("CONNECTING LOCAL PATHS:")
            for port in port_list:       # connect local to every output port
                if port != 'L':
                    noc_rg.add_edge(str(node_id)+str('L')+str('I'), str(node_id)+str(port)+str('O'))
                    if detailed_report:
                        print ("\t", 'L', "--->", port)
                    noc_rg.add_edge(str(node_id)+str(port)+str('I'), str(node_id)+str('L')+str('O'))
                    if detailed_report:
                        print ("\t", port, "--->", 'L')
            if detailed_report:
                print ("CONNECTING DIRECT PATHS:")
            for i in range(0, int(len(port_list))):   # connect direct paths
                if port_list[i] != 'L':
                    if detailed_report:
                        print ("\t", port_list[i], "--->", port_list[len(port_list)-1-i])
                    in_id = str(node_id)+str(port_list[i])+str('I')
                    out_id = str(node_id)+str(port_list[len(port_list)-1-i])+str('O')
                    noc_rg.add_edge(in_id, out_id)
            if detailed_report:
                print ("CONNECTING TURNS:")
            line = routing_file.readline()
            turns_list = line.split()
            for turn in turns_list:
                if turn in shmu.SHM.node[node_id]['TurnsHealth']:
                    if shmu.SHM.node[node_id]['TurnsHealth'][turn]:
                        in_port = turn[0]
                        out_port = turn[2]
                        if in_port != out_port:
                            noc_rg.add_edge(str(node_id)+str(in_port)+str('I'), str(node_id)+str(out_port)+str('O'))
                        else:   # just for defensive programming reasons...
                            print ("\033[31mERROR::\033[0m U-TURN DETECTED!")
                            print ("TERMINATING THE PROGRAM...")
                            print ("HINT: CHECK YOUR TURN MODEL!")
                            raise ValueError('U-TURN DETECTED IN TURN MODEL!')
                        if detailed_report:
                            print ("\t", in_port, "--->", out_port)
            if detailed_report:
                print ("------------------------")
        if line == '':
            break
    for node in ag.nodes():
        if node not in nodes_covered_in_file:
            if detailed_report:
                print ("GENERATING PORTS:")
            for port in port_list:
                if detailed_report:
                    print "\t", str(node)+str(port)+str('I'), "&", str(node)+str(port)+str('O')
                noc_rg.add_node(str(node)+str(port)+str('I'), Node=node, Port=port, Dir='I')
                noc_rg.add_node(str(node)+str(port)+str('O'), Node=node, Port=port, Dir='O')
            if detailed_report:
                print ("CONNECTING LOCAL PATHS:")
            for port in port_list:       # connect local to every output port
                if port != 'L':
                    noc_rg.add_edge(str(node)+str('L')+str('I'), str(node)+str(port)+str('O'))
                    if detailed_report:
                        print ("\t", 'L', "--->", port)
                    noc_rg.add_edge(str(node)+str(port)+str('I'), str(node)+str('L')+str('O'))
                    if detailed_report:
                        print ("\t", port, "--->", 'L')
            if detailed_report:
                print ("CONNECTING DIRECT PATHS:")
            for i in range(0, int(len(port_list))):   # connect direct paths
                if port_list[i] != 'L':
                    if detailed_report:
                        print ("\t", port_list[i], "--->", port_list[len(port_list)-1-i])
                    in_id = str(node)+str(port_list[i])+str('I')
                    out_id = str(node)+str(port_list[len(port_list)-1-i])+str('O')
                    noc_rg.add_edge(in_id, out_id)

    for link in ag.edges():     # here we should connect connections between routers
        port = ag.edge[link[0]][link[1]]['Port']
        if shmu.SHM[link[0]][link[1]]['LinkHealth']:
            if detailed_report:
                print ("CONNECTING LINK:", link, "BY CONNECTING:", str(link[0])+str(port[0])+str('-Out'),
                       "TO:", str(link[1])+str(port[1])+str('-In'))
            noc_rg.add_edge(str(link[0])+str(port[0])+str('O'), str(link[1])+str(port[1])+str('I'))
        else:
            if detailed_report:
                print ("BROKEN LINK:", link)
    if report:
        print ("ROUTE GRAPH IS READY... ")
    return noc_rg


def update_noc_route_graph(noc_rg, from_port, to_port, add_or_remove):
    """
    we would like to eliminate the path or turn that is not working anymore...
    :param noc_rg: noc routing graph
    :param from_port: from port id
    :param to_port: to port id
    :param add_or_remove: either add or remove path
    :return: None
    """
    # print "ROUTING GRAPH BEING UPDATED..."
    if add_or_remove == 'REMOVE':
        if (from_port, to_port) in noc_rg.edges():
            noc_rg.remove_edge(from_port, to_port)
        else:
            print "CONNECTION DIDN'T EXIST IN ROUTE GRAPH"
    if add_or_remove == 'ADD':
        if (from_port, to_port) in noc_rg.edges():
            print "CONNECTION DIDN'T EXIST IN ROUTE GRAPH"
        else:
            noc_rg.add_edge(from_port, to_port)
    # print "ROUTING GRAPH UPDATED..."
    return None


def find_route_in_route_graph(noc_rg, critical_rg, non_critical_rg, source_node, destination_node, report):
    """
    :param noc_rg: NoC Routing Graph
    :param critical_rg:
    :param non_critical_rg:
    :param source_node: Source node on AG
    :param destination_node: Destination node on AG
    :param report : boolean to switch on/off reports to console
    :return: return a path (by name of links) on AG from source to destination if possible, None if not.
    """
    if Config.EnablePartitioning:
        if source_node in Config.GateToNonCritical:
            current_rg = non_critical_rg
        elif source_node in Config.GateToCritical:
            current_rg = critical_rg
        elif source_node in Config.CriticalRegionNodes:
            current_rg = critical_rg
        else:
            current_rg = non_critical_rg
    else:
        current_rg = noc_rg
    source = str(source_node)+str('L')+str('I')
    destination = str(destination_node)+str('L')+str('O')
    if has_path(current_rg, source, destination):
        if Config.RotingType == 'MinimalPath':
            all_paths = return_minimal_paths(current_rg, source_node, destination_node)
        elif Config.RotingType == 'NonMinimalPath':
            all_paths = list(all_simple_paths(current_rg, source, destination))
        else:
            raise ValueError("Invalid RotingType")
        all_links = []
        for j in range(0, len(all_paths)):
            path = all_paths[j]
            links = []
            for i in range(0, len(path)-1):
                if int(search(r"\d+", path[i]).group()) != int(search(r"\d+", path[i+1]).group()):
                    links.append((int(search(r"\d+", path[i]).group()), int(search(r"\d+", path[i+1]).group())))
            all_links.append(links)
        if report:
            print "\t\tFINDING PATH(S) FROM: ", source, "TO:", destination, " ==>", all_links

        return all_links, len(all_paths)
    else:
        if report:
            print "\t\tNO PATH FOUND FROM: ", source, "TO:", destination
        return None, None


def return_minimal_paths(current_rg, source_node, destination_node):
    """
    returns all minimal paths from source node to destination node, under current routing graph constraints
    :param current_rg: current routing graph
    :param source_node: source node id
    :param destination_node: destination node id
    :return: list of all minimal paths
    """
    all_minimal_paths = []
    max_hop_count = manhattan_distance(source_node, destination_node)
    source = str(source_node)+str('L')+str('I')
    destination = str(destination_node)+str('L')+str('O')
    all_paths = list(all_shortest_paths(current_rg, source, destination))
    for Path in all_paths:
        if (len(Path)-2)/2 <= max_hop_count:
            all_minimal_paths.append(Path)
    return all_minimal_paths
