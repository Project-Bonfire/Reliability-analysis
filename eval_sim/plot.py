import ast
from typing import List

import requests
import numpy as np
import matplotlib as plt
import matplotlib.pyplot as plt2

# This file lets us create plots of the most current module data


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




def plot(dataset,reference,title="", logscale = False, packetlengths:List[int] = [3, 5, 10, 20]):
    """
    plots the given dataset in 4 subplots, one for each module
    :param dataset: the dataset to show in the format [(packetlength,framrate, valuetoshow)]
    :param reference: a reference set or None. Same format as the dataset
    :param title: a title to add to the figure
    :param logscale: if True, setting the yaxis to logscale
    :return:
    """
    res = dataset
    f, ax = plt2.subplots(2,2)
    ax=ax.flatten()
    type = ['lbdr','fifo','xbar','arbiter']
    handles,labels = None,None
    def preparelist(list,pl):
        list = filter(lambda x: x[0] == pl, list)
        list = sorted(list, key=lambda x: x[1])
        return [v[1] for v in list],[v[2] for v in list]
    for i in range(len(type)):
        ax[i].set_title(type[i])
        for pl in packetlengths:
            x,y = preparelist(res[type[i]],pl)
            line = ax[i].plot(x, y,"o" if len(x) == 1 else "-",label=pl)
            #plot refline
            if reference:
                refx, refy = preparelist(reference,pl)
                ax[i].plot(refx, refy, "x" if len(x) == 1 else "--", color=line[0].get_color(),alpha=0.5)
        handles, labels = ax[i].get_legend_handles_labels()
        if logscale:
            ax[i].set_yscale("log", nonposy='clip')
            ax[i].get_yaxis().set_major_formatter(
                plt.ticker.FuncFormatter(lambda x, p: "%.4f"%float(x)))
    f.legend(handles,labels)
    f.suptitle(title)
    plt2.tight_layout()

    plt2.show()

def enrich_values(values):
    """
    adds addidional enriched properties to the dataset
    :param values:
    :return: the values with addidional properties
    """
    values["param_module_changed_and_invalid_total_ratios"] = str(dict([(k,v / float(values["num_runs"])) for k,v in ast.literal_eval(values["param_module_changed_and_invalid_counts"]).items()]))
    values["param_module_changed_total_ratios"] = str(dict([(k, v / float(values["num_runs"])) for k, v in
                                                                        ast.literal_eval(values[
                                                                                             "param_module_changed_counts"]).items()]))
    return values

# Download dataset and prepare it
def getdataset ():
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
                if values["ratio_violations"] =="1.0":
                    buffer=[]
                    continue
                values = enrich_values(values)
                buffers.append(values)
                buffer = []
    if len(buffer) > 0:
        values = {line.split(':', 1)[0].strip(): line.split(':', 1)[1].strip() for line in buffer}
        if values["ratio_violations"] !="1.0":
            values = enrich_values(values)
            buffers.append(values)
    return buffers

buffers = getdataset()
# get packetlengths from data
packetlengths = sorted(list(set([int(v['packetlength'].split(',')[0]) for v in buffers])))

reference = createdataset_simple(buffers,'ratio_violations')

# module caused system failure probability
plot(createdataset_modules(buffers,'param_module_changed_and_invalid_total_ratios'),reference,title="",logscale=True,packetlengths=packetlengths)
# absolute module failure probability vs system failure probability
plot(createdataset_modules(buffers,'param_module_changed_total_ratios'),reference,title="",packetlengths=packetlengths)