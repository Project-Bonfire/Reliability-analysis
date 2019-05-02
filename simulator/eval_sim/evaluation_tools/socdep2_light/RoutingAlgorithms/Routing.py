# Copyright (C) 2015 Siavoosh Payandeh Azad
#
# Modifications by Karl Janson in 2019:
#   - Removed functions not needed by the tool
#


from networkx import DiGraph
from ..ConfigAndPackages import Config

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
        print("\tUSING TURN MODEL: ", turn_model)
        # report_turn_model(turn_model)

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
                print(("\t", str(node)+str(port)+str('I'), "&", str(node)+str(port)+str('O')))
            noc_rg.add_node(str(node)+str(port)+str('I'), Node=node, Port=port, Dir='I')
            noc_rg.add_node(str(node)+str(port)+str('O'), Node=node, Port=port, Dir='O')
        if detailed_report:
            print ("CONNECTING LOCAL PATHS:")
        for port in port_list:       # connect local to every output port
            if port != 'L':
                noc_rg.add_edge(str(node)+str('L')+str('I'), str(node)+str(port)+str('O'))
                if detailed_report:
                    print(("\t", 'L', "--->", port))
                noc_rg.add_edge(str(node)+str(port)+str('I'), str(node)+str('L')+str('O'))
                if detailed_report:
                    print(("\t", port, "--->", 'L'))
        if detailed_report:
            print ("CONNECTING DIRECT PATHS:")
        for i in range(0, int(len(port_list))):   # connect direct paths
            if port_list[i] != 'L':
                if detailed_report:
                    print(("\t", port_list[i], "--->", port_list[len(port_list)-1-i]))
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
                        print(("\t", in_port, "--->", out_port))
        if detailed_report:
            print ("------------------------")

    for link in ag.edges():     # here we should connect connections between routers
        port = ag.edge[link[0]][link[1]]['Port']
        if shmu.SHM[link[0]][link[1]]['LinkHealth']:
            if detailed_report:
                print(("CONNECTING LINK:", link, "BY CONNECTING:", str(link[0])+str(port[0])+str('-Out'),
                       "TO:", str(link[1])+str(port[1])+str('-In')))
            noc_rg.add_edge(str(link[0])+str(port[0])+str('O'), str(link[1])+str(port[1])+str('I'))
        else:
            if detailed_report:
                print(("BROKEN LINK:", link))
    if report:
        print ("ROUTE GRAPH IS READY... ")
    return noc_rg
