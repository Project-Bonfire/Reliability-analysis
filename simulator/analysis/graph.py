import sys

import matplotlib
matplotlib.use("Agg")

import matplotlib.pyplot as plt

# here im using networkx version 1.11
import networkx as nx

class Attr():
    def __init__(self, IFPP, LFPP):
        self.IFPP = IFPP    # IFPP: Input faults propagation probability
        self.LFPP = LFPP    # LFPP: Logic faults propagation probability


Relaph = nx. DiGraph()  # Reliability Graph
pos = {}
row_counter = 0

for dir in ["N", "E", "W", "S", "L"]:
    Relaph.add_node("FIFOC_" + dir, attr=Attr(IFPP=0.32, LFPP=0.46))
    Relaph.add_node("FIFOD_" + dir, attr=Attr(IFPP=0.24, LFPP=0.25))
    Relaph.add_node("LBDR_" + dir, attr=Attr(IFPP=0.11, LFPP=0.14))
    Relaph.add_node("XBAR_" + dir, attr=Attr(IFPP=0.13, LFPP=0.3))
    pos["FIFOC_" + dir] = (0, row_counter)
    pos["FIFOD_" + dir] = (1, row_counter)
    pos["LBDR_" + dir] = (2, row_counter + 0.5)
    pos["XBAR_" + dir] = (3, row_counter)
    row_counter += 1

Relaph.add_node("ALLOC", attr=Attr(IFPP=0.06, LFPP=0.15))
Relaph.add_node("OUT")
pos["ALLOC"] = (2.5, 6)
pos["OUT"] = (4, 2.5)

print("-" * 30)
print("Reporting the nodes in the graph:")

for node in sorted(Relaph.nodes()):
    if node != "OUT":
        print("\t", node, "\tIFPP:", Relaph.node[node]['attr'].IFPP, "\tLFPP:", Relaph.node[node]['attr'].LFPP)

print("-" * 30)

for dir in ["N", "E", "W", "S", "L"]:
    # Weight of an edge shows the percentage of the source's output signals that goes to the destination
    Relaph.add_edge("FIFOD_" + dir, "LBDR_" + dir, weight=17.0/32.0)
    Relaph.add_edge("FIFOD_" + dir, "XBAR_" + dir, weight=1.0)

    Relaph.add_edge("FIFOC_" + dir, "LBDR_" + dir, weight=1.0/9.0)
    Relaph.add_edge("FIFOC_" + dir, "ALLOC", weight=1.0/9.0)
    Relaph.add_edge("FIFOC_" + dir, "FIFOD_", weight=7.0/9.0)
    Relaph.add_edge("FIFOC_" + dir, "OUT", weight=1.0/9.0)
    Relaph.add_edge("LBDR_" + dir, "ALLOC", weight=1.0)
    Relaph.add_edge("ALLOC", "LBDR_" + dir, weight=4.0/55.0)
    Relaph.add_edge("ALLOC", "FIFOC_" + dir, weight=4.0/55.0)
    Relaph.add_edge("ALLOC", "XBAR_" + dir, weight=5.0/55.0)
    Relaph.add_edge("XBAR_" + dir, "OUT", weight=1)

    # Relaph.add_edge("FIFOD_" + dir, "LBDR_" + dir, weight=1.0)
    # Relaph.add_edge("FIFOD_" + dir, "XBAR_" + dir, weight=1.0)

    # Relaph.add_edge("FIFOC_" + dir, "LBDR_" + dir, weight=1.0)
    # Relaph.add_edge("FIFOC_" + dir, "ALLOC", weight=1.0)
    # Relaph.add_edge("FIFOC_" + dir, "FIFOD_", weight=1.0)
    # Relaph.add_edge("FIFOC_" + dir, "OUT", weight=1.0)
    # Relaph.add_edge("LBDR_" + dir, "ALLOC", weight=1.0)
    # Relaph.add_edge("ALLOC", "LBDR_" + dir, weight=1.0)
    # Relaph.add_edge("ALLOC", "FIFOC_" + dir, weight=1.0)
    # Relaph.add_edge("ALLOC", "XBAR_" + dir, weight=1.0)
    # Relaph.add_edge("XBAR_" + dir, "OUT", weight=1)

# Relaph.add_edge("ALLOC", "OUT", weight=1.0)
Relaph.add_edge("ALLOC", "OUT", weight=5.0/55.0)

print("All edges in the graph along with percentage of the source's output signals in this path:")
for edge in sorted(Relaph.edges()):
    print("\t", edge, Relaph.edge[edge[0]][edge[1]]["weight"])

print("-" * 30)
total_probability = 0

from_module = "FIFOC_N"
to_module = "OUT"

print("All simple paths from", from_module, "to", to_module + ":")

for path in list(nx.all_simple_paths(Relaph, from_module, to_module)):
    print("\t \033[1m\033[93mPATH\033[0m:", path)
    
    probability = Relaph.node[path[0]]['attr'].LFPP
    print("\t\tProb of fault in", '%8s' % path[0], " Module:", probability)

    for i in range(0, len(path)-1):
        probability = probability * Relaph.edge[path[i]][path[i + 1]]["weight"]
        if path[i + 1] != to_module:
            print("\t\tProb at the IN  of", '%8s' % path[i + 1], ":", probability)

            probability = probability * Relaph.node[path[i + 1]]['attr'].IFPP
            print("\t\tProb at the OUT of", '%8s' % path[i + 1], ":", probability)

    total_probability += probability
    print("\tProb at the path: \033[92m", probability, "\033[0m")
    print("\t" + "-" * 10)

print("Total propagation probability: \033[91m\033[1m\033[4m" + str(total_probability) + "\033[0m")

# plt.figure()
# nx.draw_networkx_nodes(Relaph, pos, with_labels=True, node_size=1000)
# nx.draw_networkx_edges(Relaph, pos, width=1)
# nx.draw_networkx_edge_labels(Relaph, pos, font_size=10, label_pos=0.7)
# nx.draw_networkx_labels(Relaph, pos, font_size=7)

# plt.savefig("Relaph.png", dpi=200, bbox_inches='tight')
# plt.show()
# plt.clf()
