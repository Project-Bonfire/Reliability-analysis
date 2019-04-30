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
    Relaph.add_node("FIFO_" + dir, attr=Attr(IFPP=0.1, LFPP=0.2))
    Relaph.add_node("LBDR_" + dir, attr=Attr(IFPP=0.2, LFPP=0.1))
    Relaph.add_node("XBAR_" + dir, attr=Attr(IFPP=0.3, LFPP=0.3))
    pos["FIFO_" + dir] = (0, row_counter)
    pos["LBDR_" + dir] = (2, row_counter + 0.5)
    pos["XBAR_" + dir] = (3, row_counter)
    row_counter += 1

Relaph.add_node("ALLOC", attr=Attr(IFPP=0.5, LFPP=0.7))
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
    Relaph.add_edge("FIFO_" + dir, "LBDR_" + dir, weight=0.1)
    Relaph.add_edge("FIFO_" + dir, "XBAR_" + dir, weight=0.8)
    Relaph.add_edge("FIFO_" + dir, "ALLOC", weight=0.05)
    Relaph.add_edge("LBDR_" + dir, "ALLOC", weight=0.9)
    Relaph.add_edge("ALLOC", "LBDR_" + dir, weight=0.01)
    Relaph.add_edge("ALLOC", "FIFO_" + dir, weight=0.01)
    Relaph.add_edge("ALLOC", "XBAR_" + dir, weight=0.005)
    Relaph.add_edge("XBAR_" + dir, "OUT", weight=1)

Relaph.add_edge("ALLOC", "OUT", weight=0.8)

print("All edges in the graph along with percentage of the source's output signals in this path:")
for edge in sorted(Relaph.edges()):
    print("\t", edge, Relaph.edge[edge[0]][edge[1]]["weight"])

print("-" * 30)
total_probability = 0

print("All simple paths from FIFO_N to OUT:")

for path in list(nx.all_simple_paths(Relaph, "FIFO_N", "OUT")):
    print("\t \033[1m\033[93mPATH\033[0m:", path)
    probability = Relaph.node[path[0]]['attr'].LFPP
    print("\t\tProb of fault in", '%8s' % path[0], " Module:", probability)

    for i in range(0, len(path)-1):
        probability = probability * Relaph.edge[path[i]][path[i + 1]]["weight"]
        if path[i + 1] != "OUT":
            print("\t\tProb at the IN  of", '%8s' % path[i + 1], ":", probability)

        if path[i + 1] != "OUT":
            probability = probability * Relaph.node[path[i + 1]]['attr'].IFPP
            print("\t\tProb at the OUT of", '%8s' % path[i + 1], ":", probability)

    total_probability += probability
    print("\tProb at the path: \033[92m", probability, "\033[0m")
    print("\t" + "-" * 10)

print("Total propagation probability: \033[91m\033[1m\033[4m" + str(total_probability) + "\033[0m")

plt.figure()
nx.draw_networkx_nodes(Relaph, pos, with_labels=True, node_size=1000)
nx.draw_networkx_edges(Relaph, pos, width=1)
nx.draw_networkx_edge_labels(Relaph, pos, font_size=10, label_pos=0.7)
nx.draw_networkx_labels(Relaph, pos, font_size=7)

plt.savefig("Relaph.png", dpi=200, bbox_inches='tight')
# plt.show()
plt.clf()
