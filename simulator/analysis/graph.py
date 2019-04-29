import sys

import matplotlib.pyplot as plt

# here im using networkx version 1.11
import networkx as nx




class Attr():
    def __init__(self, IFPP, LFPP):
        self.IFPP = IFPP    # IFPP: Input faults propagation probability
        self.LFPP = LFPP    # LFPP: Logic faults propagation probability


Relaph = nx. DiGraph()  # Reliability Graph

for dir in ["N", "E", "W", "S", "L"]:
    Relaph.add_node("FIFO_"+dir, attr=Attr(IFPP=0.1, LFPP=0.2))
    Relaph.add_node("LBDR_"+dir, attr=Attr(IFPP=0.2, LFPP=0.1))
    Relaph.add_node("XBAR_"+dir, attr=Attr(IFPP=0.3, LFPP=0.3))
Relaph.add_node("ALLOC", attr=Attr(IFPP=0.5, LFPP=0.7))

Relaph.add_node("OUT")

print "-"*30
print "Reporting the nodes in the graph:"
for node in sorted(Relaph.nodes()):
    if node != "OUT":
        print "\t", node, "\tIFPP:", Relaph.node[node]['attr'].IFPP, "\tLFPP:", Relaph.node[node]['attr'].LFPP
print "-"*30

for dir in ["N", "E", "W", "S", "L"]:
    # wieght of an edge shows the percentage of the source's output signals that goes to the destination
    Relaph.add_edge("FIFO_"+dir, "LBDR_"+dir, weight=0.1)
    Relaph.add_edge("FIFO_"+dir, "XBAR_"+dir, weight=0.8)
    Relaph.add_edge("FIFO_"+dir, "ALLOC", weight=0.05)
    Relaph.add_edge("LBDR_"+dir, "ALLOC", weight=0.9)
    Relaph.add_edge("ALLOC", "LBDR_"+dir, weight=0.01)
    Relaph.add_edge("ALLOC", "FIFO_"+dir, weight=0.01)
    Relaph.add_edge("ALLOC", "XBAR_"+dir, weight=0.005)
    Relaph.add_edge("XBAR_"+dir, "OUT", weight=1)

Relaph.add_edge("ALLOC", "OUT", weight=0.8)

print "all edges in the graph along with percentage of the source's output signals in this path:"
for edge in sorted(Relaph.edges()):
    print "\t", edge, Relaph.edge[edge[0]][edge[1]]["weight"]

print "-"*30
total_probability = 0
print "all simple paths from FIFO_N to OUT:"
for path in list(nx.all_simple_paths(Relaph, "FIFO_N", "OUT")):
    print "\t PATH:", path
    probability = Relaph.node[path[0]]['attr'].LFPP
    print "\t\tprobability of fault in", path[0], ":", probability
    for i in range(0, len(path)-1):
        probability = probability*Relaph.edge[path[i]][path[i+1]]["weight"]
        print "\t\tprobability at the input of", path[i+1], ":", probability
        if path[i+1] != "OUT":
            probability = probability*Relaph.node[path[i+1]]['attr'].IFPP
            print "\t\tprobability at the output of", path[i+1], ":", probability
    total_probability += probability
    print "\t\tprobability at the output", probability
    print"\t\t"+"-"*10
print "total propagation probability:", total_probability
