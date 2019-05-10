#!/usr/bin/python3

###########################################################################
#                                                                         #
# File:   graph.py                                                        #
# Authors:                                                                #
#       Siavoosh Payandeh Azad (siavoosh.azad@taltech.ee)                 #
#       Karl Janson (karl.janson@taltech.ee)                              #
#                                                                         #
# Last modification date: 2019-05-09                                      #
# ----------------------------------------------------------------------- #
#                                                                         #
# Aggregates reliabilities based on a graph model                         #
#                                                                         #
###########################################################################

import argparse
import json
import re
import sys

import matplotlib
import matplotlib.pyplot as plt
import networkx as nx
import pandas as pd
import random


GREEN = '\033[92m'
RED = '\033[91m'
YELLOW = '\033[93m'
BOLD = '\033[1m'
UNDERLINED = '\033[4m'
RESET_FORMATTING = '\033[0m'

class Attr():
    def __init__(self, IFPP, LFPP, end_node=False):
        self.IFPP = IFPP    # IFPP: Input faults propagation probability
        self.LFPP = LFPP    # LFPP: Logic faults propagation probability
        self.end_node = end_node


def createRelaph(analyzed_results):
    """
    Creates a reliability graph based on the results from the analysis step.

    Parameters:
        analyzed_results: Dictionary containing the fault propagation values from the
                          fault analysis step

    Return:
        relaph: Reliability graph
        pos:    Node positions in the graph, for visualizations
    """
    # pos = {}
    row_counter = 0

    relaph = nx.DiGraph() # Reliability Graph

    IFPPs = analyzed_results['module_input_error_propagation_rate']
    LFPPs = analyzed_results['module_logic_error_propagation_rate']

    for direction in ["N", "E", "W", "S", "L"]:
        relaph.add_node("FIFOC_" + direction,
                        attr=Attr(IFPP=IFPPs['fifoc'], LFPP=LFPPs['fifoc']))

        relaph.add_node("FIFOD_" + direction,
                        attr=Attr(IFPP=IFPPs['fifod'], LFPP=LFPPs['fifod']))

        relaph.add_node("LBDR_" + direction,
                        attr=Attr(IFPP=IFPPs['lbdr'], LFPP=LFPPs['lbdr']))

        relaph.add_node("XBAR_" + direction,
                        attr=Attr(IFPP=IFPPs['xbar'], LFPP=LFPPs['xbar']))

        # pos["FIFOC_" + direction] = (0, row_counter)
        # pos["FIFOD_" + direction] = (0, row_counter + 1)
        # pos["LBDR_" + direction] = (1, row_counter + 0.5)
        # pos["XBAR_" + direction] = (3, row_counter)
        # row_counter += 2

    relaph.add_node("ALLOC", attr=Attr(
        IFPP=IFPPs['arbiter'], LFPP=LFPPs['arbiter']))

    relaph.add_node("OUT")

    # pos["ALLOC"] = (2.5, 6)
    # pos["OUT"] = (4, 2.5)

    for direction in ["N", "E", "W", "S", "L"]:
        # Weight of an edge shows the percentage of the source's 
        # output signals that goes to the destination

        relaph.add_edge("LBDR_" + direction, "FIFOD_" + direction, weight=17.0/32.0)
        relaph.add_edge("XBAR_" + direction, "FIFOD_" + direction, weight=1.0)

        relaph.add_edge("LBDR_" + direction, "FIFOC_" + direction, weight=1.0/9.0)

        relaph.add_edge("ALLOC", "FIFOC_" + direction, weight=1.0/9.0)

        relaph.add_edge("FIFOD_" + direction, "FIFOC_" + direction, weight=7.0/9.0)

        relaph.add_edge("OUT", "FIFOC_" + direction, weight=1.0/9.0)

        relaph.add_edge("ALLOC", "LBDR_" + direction, weight=1.0)

        relaph.add_edge("LBDR_" + direction, "ALLOC", weight=4.0/55.0)

        relaph.add_edge("FIFOC_" + direction, "ALLOC", weight=4.0/55.0)
        relaph.add_edge("XBAR_" + direction, "ALLOC", weight=5.0/55.0)
        relaph.add_edge("OUT", "XBAR_" + direction, weight=1)

        # relaph.add_edge("FIFOD_" + direction, "LBDR_" + direction, weight=17.0/32.0)
        # relaph.add_edge("FIFOD_" + direction, "XBAR_" + direction, weight=1.0)
        # relaph.add_edge("FIFOC_" + direction, "LBDR_" + direction, weight=1.0/9.0)
        # relaph.add_edge("FIFOC_" + direction, "ALLOC", weight=1.0/9.0)
        # relaph.add_edge("FIFOC_" + direction, "FIFOD_" + direction, weight=7.0/9.0)
        # relaph.add_edge("FIFOC_" + direction, "OUT", weight=1.0/9.0)
        # relaph.add_edge("LBDR_" + direction, "ALLOC", weight=1.0)
        # relaph.add_edge("ALLOC", "LBDR_" + direction, weight=4.0/55.0)
        # relaph.add_edge("ALLOC", "FIFOC_" + direction, weight=4.0/55.0)
        # relaph.add_edge("ALLOC", "XBAR_" + direction, weight=5.0/55.0)
        # relaph.add_edge("XBAR_" + direction, "OUT", weight=1)

    relaph.add_edge("OUT", "ALLOC", weight=5.0/55.0)

    return relaph

def build_tree(reltree, current_node, relaph, path, path_counter):

    relaph_weights = nx.get_edge_attributes(relaph, 'weight')
    current_path_node = path[0]

    # Find the successor node exists already, if so, use it, 
    # otherwise create a new node.
    successor_exists = False

    if len(path) > 1:
        for successor in list(reltree.successors(current_node)):
            if re.match(current_path_node + '+', successor):
                current_path_node = successor
                successor_exists = True
                break

    if not successor_exists:
        # Pull node data from relaph
        new_node_IFPP = relaph.node[current_path_node]['attr'].IFPP
        new_node_LFPP = relaph.node[current_path_node]['attr'].LFPP

        node_name = current_path_node + '-' + str(path_counter)

        is_end_node = (len(path) == 1)
        reltree.add_node(node_name, attr=Attr(IFPP=new_node_IFPP, 
                                            LFPP=new_node_LFPP,
                                            end_node=is_end_node))

        edge_weight = relaph_weights[(current_node.split('-')[0], current_path_node)]

        # Randomize the edge color for better reading
        seed = list(reltree.nodes()).index(current_node)
        random.seed(seed)
        color = '#%02x%02x%02x' % (random.randint(0, 200), 
                                    random.randint(0, 200), 
                                    random.randint(0, 200))

        reltree.add_edge(current_node, node_name, weight=edge_weight, color=color)

     
    if len(path) > 1:
        current_node = node_name if not successor_exists else current_path_node
        path.pop(0)
        reltree = build_tree(reltree, current_node, relaph, path, path_counter)

    return reltree


def process_graph(relaph, starting_node, reltree):

    reltree.add_node(starting_node, attr=Attr(IFPP=1, LFPP=1))
    counter = 0

    paths = [
        ['OUT', 'ALLOC', 'LBDR_N', 'FIFOD_N'],
        ['OUT', 'FIFOC_L', 'ALLOC', 'LBDR_N', 'FIFOD_N'],
        ['OUT', 'ALLOC', 'FIFOC_N'],
        ['OUT', 'ALLOC', 'LBDR_N', 'FIFOC_N'],
        ['OUT', 'ALLOC', 'LBDR_N', 'FIFOD_N', 'FIFOC_N']

    ]
    # Goes through all simple paths from all modules to the output
    for component in list(relaph.nodes):
        paths = sorted(list(nx.all_simple_paths(relaph, starting_node, component)))

        for i, path in enumerate(paths):
            counter += 1
            print(str(counter) + ':\tPATH', path)

            # Remove the first element since it is the starting_node
            path.pop(0)
            reltree = build_tree(reltree, starting_node, relaph, path, counter)
        
            # if counter == 47:
            #     print('=' * 10)
            #     return reltree
    
    for node in list(reltree.nodes):
        if len(list(reltree.predecessors(node))) > 1:
            print('Too many predecessors! Node:', node)

    print('=' * 10)
    return reltree

def simpleAggregation(relaph, from_module, to_module, include_logic_errors):
    """
    Performs a simple graph-based reliability aggregation on the reliability graph
    between 'from_module' and 'to_module'.

    Parameters:
        relaph: Weighted reliability graph
        from_module: Module from where to start the aggregation
        to_module: Module where to end the aggregation
        include_logic_errors: True if the propagation of a logic fault to the output
                              of the module output should be taken into account
                              while aggregating the reliability. False if it should
                              not be taken into account
        
    Return:
        Probability of a fault propagating into the output of the system
    """
    total_probability = 1

    print('All simple paths from', from_module, 'to', to_module + ':')

    for path in list(nx.all_simple_paths(relaph, from_module, to_module)):
        print('\t '+ BOLD + YELLOW + 'PATH:' + RESET_FORMATTING, path)

        probability = relaph.node[path[0]]['attr'].LFPP if include_logic_errors else 1

        print('\t\tProb of fault in', '%8s' % path[0], ' Module:', probability)

        for i in range(0, len(path) - 1):
            probability = probability * relaph.adj[path[i]][path[i + 1]]['weight']

            if path[i + 1] != to_module:
                print('\t\tProb at the IN  of', '%8s' %
                      path[i + 1], ':', probability)

                probability = probability * \
                    relaph.node[path[i + 1]]['attr'].IFPP

                print('\t\tProb at the OUT of', '%8s' %
                      path[i + 1], ":", probability)

        total_probability *= (1 - probability)
        print('\tProb at the path: ' + GREEN, probability, RESET_FORMATTING)
        print('\t' + '-' * 10)

    return (1 - total_probability)

def draw_graph(relaph, args):
    """
    Draws a the reliability graph into a file and optionally displays it also on the screen

    Parameters:
        relaph: The reliability graph
        args:   Program arguments
    """
    print(30 * '-')
    print('Generating graph figure...')

    A = nx.nx_agraph.to_agraph(relaph)

    A.layout('dot', args='-Nfontsize=10 -Nwidth=".2" -Nheight=".2" -Nmargin=0 -Gfontsize=8 -Granksep=7')
    A.draw(args.results_folder + '/relaph.pdf')

def node_to_module_name(node_name):
    """
    Finds the name replaces the node name with the name for the module name in the design.

    Parameters:
        node_name: Name of the node to convert to module name

    Return:
        The module name which corresponds to the node name

    Raises:
        RuntimeError: If module 'node_name' cannot be matched to any module name
    """

    node_map = {
        r'FIFOC_?': 'fifoc',
        r'FIFOD_?': 'fifod',
        r'LBDR_?': 'lbdr',
        r'XBAR_?': 'xbar',
        r'ALLOC': 'arbiter'
    }

    for key, value in node_map.items():
        if re.match(key, node_name):
            return value

    raise RuntimeError('Invalid node name: ', node_name)

def output_results(result_dict):
    """
    Prints out the results.
    Parameters:
        result_dict:    Dictionary containing the aggregation and simulation results
                        Format for each module:
                            result_dict[module_name_1][affregation]
                            result_dict[module_name_1][simulation]
                            result_dict[module_name_1][diff]
                            ....
                            result_dict[module_name_n][affregation]
                            result_dict[module_name_n][simulation]
                            result_dict[module_name_n][diff]
    """

    # Build dataframes from the stored data and print it on screen

    result_df = pd.DataFrame.from_dict(result_dict)
    result_df['diff'] = result_df['simulation'] - result_df['aggregation']
    result_df = result_df.apply(lambda a : a * 100)

    print()
    print(BOLD + GREEN + '===========================' + RESET_FORMATTING)
    print()

    print(RED + BOLD + UNDERLINED + 'AGGREGATION RESULTS (in %)' + RESET_FORMATTING)
    print()

    print(GREEN + BOLD + UNDERLINED + 'WITH LOGIC FAULTS' + RESET_FORMATTING)
    print(result_df)
    print()

    print(YELLOW + BOLD + 'Statistcs for \'diff\' column:' + RESET_FORMATTING)
    print(GREEN + BOLD + 'Min:'  + RESET_FORMATTING, (str(result_df['diff'].min()) + '%').rjust(15))
    print(GREEN + BOLD + 'Max:'  + RESET_FORMATTING, (str(result_df['diff'].max()) + '%').rjust(15))
    print(GREEN + BOLD + 'Mean:' + RESET_FORMATTING, (str(round(result_df['diff'].mean(), 2)) + '%').rjust(14))
    print()
    print('Sum ', sum(result_df['aggregation']))

def main(args, ar):
    """
    Generates a reliability graph and parses it to generate probabilities of faults
    propagating to the output og the system

    Parameters:
        args: Command line arguments of the program
        ar:   File pointer to the JSON file containing the processed results
    """

    # Dictionary to store aggregation and simulation results for each module
    result_dict = {
        'aggregation': {},
        'simulation': {}
    }


    analyzed_results = json.load(ar)
    # Generate reliability graph
    relaph = createRelaph(analyzed_results)

    rel_tree = nx.DiGraph()

    rel_tree = process_graph(relaph, 'OUT', rel_tree)

    print('===================================')

    # # Print connection data
    # print('-' * 30)
    # print('Reporting the nodes in the graph:')

    # for node in sorted(list(relaph.nodes())):
    #     if node != 'OUT':
    #         print('\t', node, '\tIFPP:', relaph.node[node]['attr'].IFPP, 
    #               '\tLFPP:', relaph.node[node]['attr'].LFPP)

    # print('-' * 30)

    # print('All edges in the graph along with percentage of the source\'s output signals in this path:')
    # for edge in sorted(list(relaph.edges())):
    #     print('\t', edge, relaph.adj[edge[0]][edge[1]]['weight'])

    # print('-' * 30)


    # # Do simple aggregation
    # for from_node in sorted(list(relaph.nodes)):

    #     if from_node != 'OUT':
            
    #         print()
    #         print(BOLD + GREEN + '===========================' + RESET_FORMATTING)
    #         print()
    #         print(BOLD + RED + UNDERLINED + from_node + RESET_FORMATTING,)
    #         print(BOLD + YELLOW + UNDERLINED + 'Without LFPP' + RESET_FORMATTING)

    #         total_probability = simpleAggregation(relaph, from_node, 'OUT', False)
    #         sim_result = round(analyzed_results['percentage_tl_errors_caused_by_module']
    #                                             [node_to_module_name(from_node)], 4)

    #         print()
    #         print(BOLD + YELLOW + UNDERLINED + 'With LFPP' + RESET_FORMATTING)

    #         total_probability = simpleAggregation(relaph, from_node, 'OUT', True)
    #         print('Total propagation probability: ' 
    #                 + RED + BOLD + UNDERLINED + str(total_probability) 
    #                 + RESET_FORMATTING)
            
    #         result_dict['aggregation'][from_node] = round(total_probability, 4)
    #         result_dict['simulation'][from_node] = sim_result
    #         # result_dict[from_node]['diff'] = result_dict[from_node]['simulation'] \
    #                                                     # - result_dict[from_node]['aggregation']

    # output_results(result_dict)

    # Draw the graph
    if not args.no_drawing:
        draw_graph(rel_tree, args)


if __name__ == '__main__':

    if (sys.version_info < (3, 6)):
        print('This script is designed to run on Python 3.6 or newer!')
        exit(1)

    # Parse arguments
    parser = argparse.ArgumentParser('Graph Based Reliability Evaluator')

    drawing = parser.add_mutually_exclusive_group()
    drawing.add_argument('--no-drawing', action='store_true',
                         help='Do not draw the graph into a file')
    drawing.add_argument('--gui', action='store_true',
                         help='Display the generated graph in GUI')

    parser.add_argument('--results-file', type=str,
                        help='JSON results file from the simulation')

    parser.add_argument('--analyzed-results', type=str,
                        help='JSON file with analyzed results')

    parser.add_argument('--results-folder', type=str,
                        help='Path to the results folder')

    args = parser.parse_args()

    # If switch matplotlib's backend to headless mode
    if not args.gui:
        matplotlib.use("Agg")

    with open(args.analyzed_results, 'r') as ar:
        main(args, ar)
