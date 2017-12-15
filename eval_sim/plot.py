import ast
from typing import List

import requests
import numpy as np
import matplotlib as plt
import matplotlib.pyplot as plt2



packetlengths = [3, 5, 10, 20]




def createdataset_modules(buffers:List[List[str]],attribute):

    res = {'lbdr': [], 'fifo': [], 'xbar': [], 'arbiter': []}
    for values in buffers:
        pl = int(values['packetlength'].split(',')[0])
        fl = int(values['framelength'])
        for m in ['lbdr','fifo','xbar','arbiter']:

            prob = ast.literal_eval(values[attribute])[m]
            res[m].append((pl, fl, prob))
    return res

def createdataset_simple(buffers:List[List[str]],attribute):

    res = []
    for values in buffers:
        pl = int(values['packetlength'].split(',')[0])
        fl = int(values['framelength'])
        prob = values[attribute]
        res.append((pl, fl, prob))
    return res




def plotattribute(dataset,reference):
    res = dataset
    f, ax = plt2.subplots(2,2)
    ax=ax.flatten()
    type = ['lbdr','fifo','xbar','arbiter']
    handles,labels = None,None

    for i in range(len(type)):
        ax[i].set_title(type[i])
        for pl in packetlengths:
            list = res[type[i]]
            list = filter(lambda x: x[0] == pl,list)
            list = sorted(list,key=lambda x: x[1])


            x = [v[1] for v in list]
            y = [v[2] for v in list]
            line = ax[i].plot(x, y,"o" if len(x) == 1 else "-",label=pl)
            #plot refline
            if reference:
                reflist = reference
                reflist = filter(lambda x: x[0] == pl, reflist)
                reflist = sorted(reflist, key=lambda x: x[1])
                refx = [v[1] for v in reflist]
                refy = [v[2] for v in reflist]
                ax[i].plot(refx, refy, "x" if len(x) == 1 else "--", color=line[0].get_color(),alpha=0.5)
        handles, labels = ax[i].get_legend_handles_labels()
        ax[i].set_yscale("log", nonposy='clip')
    f.legend(handles,labels)
    plt2.tight_layout()

    plt2.show()

def enrich_values(values):
    values["param_module_changed_and_invalid_total_ratios"] = str(dict([(k,v / float(values["num_runs"])) for k,v in ast.literal_eval(values["param_module_changed_and_invalid_counts"]).items()]))
    return values


file='http://ati.ttu.ee/~thilo/evals.log'
r = requests.get(file, stream=True)
buffers=[]
buffer=[]
for line in r.iter_lines():
    """
    read the datasets seperated by newlines
    """
    if len(line.strip())>0:
        buffer.append(line.decode("utf-8"))
    else:
        if len(buffer) > 0:
            values = {line.split(':', 1)[0].strip(): line.split(':', 1)[1].strip() for line in buffer}
            values = enrich_values(values)
            buffers.append(values)
            buffer = []

reference = createdataset_simple(buffers,'ratio_violations')

plotattribute(createdataset_modules(buffers,'param_module_changed_and_invalid_total_ratios'),reference)