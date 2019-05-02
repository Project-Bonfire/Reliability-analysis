import sys

import argparse
import matplotlib
import matplotlib.pyplot as plt

import networkx as nx

class Attr():
    def __init__(self, IFPP, LFPP):
        self.IFPP = IFPP    # IFPP: Input faults propagation probability
        self.LFPP = LFPP    # LFPP: Logic faults propagation probability

def createRelaph():
    relaph = nx.DiGraph()  # Reliability Graph
    pos = {}
    row_counter = 0

    for direction in ["N", "E", "W", "S", "L"]:
        relaph.add_node("FIFOC_" + direction, attr=Attr(IFPP=0.32, LFPP=0.46))
        relaph.add_node("FIFOD_" + direction, attr=Attr(IFPP=0.24, LFPP=0.25))
        relaph.add_node("LBDR_" + direction, attr=Attr(IFPP=0.11, LFPP=0.14))
        relaph.add_node("XBAR_" + direction, attr=Attr(IFPP=0.13, LFPP=0.3))
        pos["FIFOC_" + direction] = (0, row_counter)
        pos["FIFOD_" + direction] = (0, row_counter + 1)
        pos["LBDR_" + direction] = (1, row_counter + 0.5)
        pos["XBAR_" + direction] = (3, row_counter)
        row_counter += 2

    relaph.add_node("ALLOC", attr=Attr(IFPP=0.06, LFPP=0.15))
    relaph.add_node("OUT")
    pos["ALLOC"] = (2.5, 6)
    pos["OUT"] = (4, 2.5)

    for direction in ["N", "E", "W", "S", "L"]:
        # Weight of an edge shows the percentage of the source's output signals that goes to the destination
        relaph.add_edge("FIFOD_" + direction, "LBDR_" + direction, weight=17.0/32.0)
        relaph.add_edge("FIFOD_" + direction, "XBAR_" + direction, weight=1.0)

        relaph.add_edge("FIFOC_" + direction, "LBDR_" + direction, weight=1.0/9.0)
        relaph.add_edge("FIFOC_" + direction, "ALLOC", weight=1.0/9.0)
        relaph.add_edge("FIFOC_" + direction, "FIFOD_" + direction, weight=7.0/9.0)
        relaph.add_edge("FIFOC_" + direction, "OUT", weight=1.0/9.0)
        relaph.add_edge("LBDR_" + direction, "ALLOC", weight=1.0)
        relaph.add_edge("ALLOC", "LBDR_" + direction, weight=4.0/55.0)
        relaph.add_edge("ALLOC", "FIFOC_" + direction, weight=4.0/55.0)
        relaph.add_edge("ALLOC", "XBAR_" + direction, weight=5.0/55.0)
        relaph.add_edge("XBAR_" + direction, "OUT", weight=1)

        # relaph.add_edge("FIFOD_" + direction, "LBDR_" + direction, weight=1.0)
        # relaph.add_edge("FIFOD_" + direction, "XBAR_" + direction, weight=1.0)

        # relaph.add_edge("FIFOC_" + direction, "LBDR_" + direction, weight=1.0)
        # relaph.add_edge("FIFOC_" + direction, "ALLOC", weight=1.0)
        # relaph.add_edge("FIFOC_" + direction, "FIFOD_", weight=1.0)
        # relaph.add_edge("FIFOC_" + direction, "OUT", weight=1.0)
        # relaph.add_edge("LBDR_" + direction, "ALLOC", weight=1.0)
        # relaph.add_edge("ALLOC", "LBDR_" + direction, weight=1.0)
        # relaph.add_edge("ALLOC", "FIFOC_" + direction, weight=1.0)
        # relaph.add_edge("ALLOC", "XBAR_" + direction, weight=1.0)
        # relaph.add_edge("XBAR_" + direction, "OUT", weight=1)

    # relaph.add_edge("ALLOC", "OUT", weight=1.0)
    relaph.add_edge("ALLOC", "OUT", weight=5.0/55.0)

    return relaph, pos

def simpleAggregation(relaph):
    total_probability = 0

    from_module = "FIFOC_N"
    to_module = "OUT"

    print("All simple paths from", from_module, "to", to_module + ":")

    for path in list(nx.all_simple_paths(relaph, from_module, to_module)):
        print("\t \033[1m\033[93mPATH\033[0m:", path)
        
        probability = relaph.node[path[0]]['attr'].LFPP
        print("\t\tProb of fault in", '%8s' % path[0], " Module:", probability)

        for i in range(0, len(path) - 1):
            probability = probability * relaph.adj[path[i]][path[i + 1]]["weight"]
            if path[i + 1] != to_module:
                print("\t\tProb at the IN  of", '%8s' % path[i + 1], ":", probability)

                probability = probability * relaph.node[path[i + 1]]['attr'].IFPP
                print("\t\tProb at the OUT of", '%8s' % path[i + 1], ":", probability)

        total_probability += probability
        print("\tProb at the path: \033[92m", probability, "\033[0m")
        print("\t" + "-" * 10)

    print("Total propagation probability: \033[91m\033[1m\033[4m" + str(total_probability) + "\033[0m")

def main(args):

    # Generate reliability graph
    relaph, pos = createRelaph()

    # Print connection data
    print("-" * 30)
    print("Reporting the nodes in the graph:")

    for node in sorted(list(relaph.nodes())):
        if node != "OUT":
            print("\t", node, "\tIFPP:", relaph.node[node]['attr'].IFPP, "\tLFPP:", relaph.node[node]['attr'].LFPP)

    print("-" * 30)

    print("All edges in the graph along with percentage of the source's output signals in this path:")
    for edge in sorted(list(relaph.edges())):
        print("\t", edge, relaph.adj[edge[0]][edge[1]]["weight"])

    print("-" * 30)
    
    # Do simple aggregation
    simpleAggregation(relaph)

    # Draw the graph
    if not args.no_drawing:
        print(30 * '-')
        print('Generating graph figure...')

        plt.figure()
        nx.draw_networkx_nodes(relaph, pos, with_labels=True, node_size=200)
        nx.draw_networkx_edges(relaph, pos, width=1)

        weights = nx.get_edge_attributes(relaph,'weight')
        edge_labels = dict((k, str(round(float(v), 3))) for k, v in weights.items())
        nx.draw_networkx_edge_labels(relaph, pos, font_size=4, label_pos=0.7, edge_labels=edge_labels)
        nx.draw_networkx_labels(relaph, pos, font_size=4)

        plt.savefig("relaph.png", dpi=1000, bbox_inches='tight')

        if args.gui:
            plt.show()
        plt.clf()

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
    
    args = parser.parse_args()
    
    # If switch matplotlib's backend to headless mode
    if not args.gui:
        matplotlib.use("Agg")
    
    main(args)