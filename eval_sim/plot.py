import argparse
import ast
from typing import List

import math
import numpy
import requests
import numpy as np
import matplotlib as plt
import matplotlib.pyplot as plt2
import itertools
import os

# This file lets us create plots of the most current module data

parser = argparse.ArgumentParser(description='Evaluate the result of a Reliability-analysis simulation.')
parser.add_argument('imagefolder', type=str, help='The folder where the plots should be saved`.')
parser.add_argument('routername', type=str, help='The name of the router to be evaluated`.')
args = parser.parse_args()

packetlengths = [3, 5, 10, 20, 30]


def createdataset_modules(buffers: List[List[str]], attribute, flattensecondlayer=False, relativeto=None,
                          layerselforrel=lambda arr: arr[0]):
    """

    :param buffers:
    :param attribute:
    :param flattensecondlayer: if there is a second layer of dicts, that shoule be flattened.
    Example: {'MISROUTED': {'lbdr': 54, 'fifo': 0, 'xbar': 87, 'arbiter': 9, 'fifod': 1, 'fifoc': 47}}
    This will be transformed to 'MISROUTED lbdr' 'MISROUTED xbar' ...
    :param relativeto: if the values of the dataset should be divided by something, None if not
    It must be a dict, that contains one value to divide by for each module or a string, which references a  dict in the dataset
    if flattensecondlayer is set, the second layer is assumed as keys for the relativeto dict
    :param layerselforrel: a function which selects the correct key for the relativeto function. the input is a list with the keys from the layers
    :return:
    """
    res = {}
    for values in buffers:
        pl = int(values['packetlength'].split(',')[0])
        fl = float(values['framelength'])
        val = ast.literal_eval(values[attribute])
        rel = relativeto
        # if it is a str, get it from the data
        if type(relativeto) is str:
            rel = ast.literal_eval(values[relativeto])

        if flattensecondlayer:
            tmp = val
            val = {}
            for k1, v1 in tmp.items():
                for k2, v2 in v1.items():
                    if rel:
                        val[k1 + " " + k2] = v2 / rel[layerselforrel([k1, k2])]
                    else:
                        val[k1 + " " + k2] = v2
        if not flattensecondlayer and rel:
            for k1, v1 in val.items():
                val[k1] = v1 / rel[k1]
        for m in val.keys():
            prob = val[m]
            if m not in res:
                res[m] = []
            res[m].append((pl, fl, prob))
    return res


def createdataset_simple(buffers: List[List[str]], attribute):
    res = []
    for values in buffers:
        pl = int(values['packetlength'].split(',')[0])
        fl = float(values['framelength'])
        prob = float(values[attribute])
        res.append((pl, fl, prob))
    return res

def set_shared_ylabel(a, ylabel, labelpad = 0.01):
    """
    From: https://stackoverflow.com/a/37150446/3782904
    Set a y label shared by multiple axes
    Parameters
    ----------
    a: list of axes
    ylabel: string
    labelpad: float
        Sets the padding between ticklabels and axis label
    """

    f = a[0].get_figure()
    f.canvas.draw() #sets f.canvas.renderer needed below

    # get the center position for all plots
    top = a[0].get_position().y1
    bottom = a[-1].get_position().y0

    # get the coordinates of the left side of the tick labels
    x0 = 1
    for at in a:
        at.set_ylabel('') # just to make sure we don't and up with multiple labels
        bboxes, _ = at.yaxis.get_ticklabel_extents(f.canvas.renderer)
        bboxes = bboxes.inverse_transformed(f.transFigure)
        xt = bboxes.x0
        if xt < x0:
            x0 = xt
    tick_label_left = x0

    # set position of label
    a[-1].set_ylabel(ylabel)
    a[-1].yaxis.set_label_coords(tick_label_left - labelpad,(bottom + top)/2, transform=f.transFigure)



def plotmodules(dataset, reference, xlabel, ylabel, title="", logscale=False, packetlengths: List[int] = [3, 5, 10, 20],
                ylim=None,shapehint=None,labelsonce:bool=False):
    """
    plots the given dataset in 4 subplots, one for each module
    :param dataset: the dataset to show in the format [(packetlength,framrate, valuetoshow)]
    :param reference: a reference set or None. Same format as the dataset
    :param title: a title to add to the figure
    :param logscale: if True, setting the yaxis to logscale
    :return:
    """
    if not dataset:
        raise AttributeError("No dataset given!")
    res = dataset
    type = sorted(list(res.keys()))
    height = math.ceil(len(type) / 6) if not shapehint else shapehint[0]
    width = min(len(type), 6) if not shapehint else shapehint[1]
    f, ax = plt2.subplots(height, width, figsize=(width * 3, height * 2 + 1+(0.1 if title else 0)), sharey=True, gridspec_kw={'wspace':0})
    st = f.suptitle(title, fontsize="x-large")
    ax = ax.flatten()


    handles, labels = None, None

    def preparelist(list, pl):
        list = filter(lambda x: x[0] == pl, list)
        list = sorted(list, key=lambda x: x[1])
        return [v[1] for v in list], [v[2] for v in list]

    ref = None if not reference else lambda pl: preparelist(reference, pl)
    for i in range(len(type)):
        handles, labels = create_singleplot(ax[i], packetlengths, "" if labelsonce else xlabel, "" if labelsonce else ylabel ,
                                            lambda pl: preparelist(res[type[i]], pl),
                                            reference=ref, ylim=ylim, title=type[i], logscale=logscale)

    f.legend(handles, labels)

    plt2.tight_layout()
    if title:
        st.set_y(0.98)
        f.subplots_adjust(top=0.80)
    if labelsonce:

        f.text(0, 0.5, ylabel, va='center', rotation='vertical')
        #f.text(0.5, 0.04, xlabel, ha='center')
        #set_shared_ylabel(ax, ylabel)



def plotsimple(dataset, reference, xlabel, ylabel, title="", logscale=False, packetlengths: List[int] = [3, 5, 10, 20],
               ylim=None):
    """
    plots the given dataset in 4 subplots, one for each module
    :param dataset: the dataset to show in the format [(packetlength,framrate, valuetoshow)]
    :param reference: a reference set or None. Same format as the dataset
    :param title: a title to add to the figure
    :param logscale: if True, setting the yaxis to logscale
    :return:
    """
    f = plt2.figure()
    ax = f.add_subplot(111)
    st = f.suptitle(title, fontsize="x-large")

    handles, labels = None, None

    def preparelist(list, pl):
        list = filter(lambda x: x[0] == pl, list)
        list = sorted(list, key=lambda x: x[1])
        return [v[1] for v in list], [v[2] for v in list]

    ref = None if not reference else lambda pl: preparelist(reference, pl)
    handles, labels = create_singleplot(ax, packetlengths, xlabel, ylabel,
                                        lambda pl: preparelist(dataset, pl),
                                        reference=ref, ylim=ylim, title="", logscale=logscale)
    f.legend(handles, labels)
    if title:
        st.set_y(0.98)
        f.subplots_adjust(top=0.70)
    plt2.tight_layout()


def create_singleplot(ax, packetlengths, xlabel,
                      ylabel, data, reference=None, ylim=None, title="", logscale=False):
    """
    plots a single plot
    :param ax: the figure to plot on
    :param packetlengths: one packetlength for each line to plot into the figure
    :param xlabel: label for the xaxis
    :param ylabel: label for the yaxis
    :param data: function which gives back x,z for an item from packetlengths
    :param reference: reference data to draw dashed or None. Same as data.
    :param ylim: Set limits for the yaxis or None
    :param title: set the title of the plot
    :param logscale: if the yaxis should be logscaled
    :return: the handles and the labels to draw the legend.
    """
    plt2.locator_params(axis='x', nticks=10)
    ax.set_title(title)
    for pl in packetlengths:
        x, y = data(pl)
        # y = np.log([float(z) for z in y])
        # x = np.log([float(z) for z in x])
        line = ax.plot(x, y, "x" if len(x) == 1 else "-", label=pl)
        line = ax.plot(x, y, "x",color=line[0].get_color())
        # plot refline
        if reference:
            refx, refy = reference(pl)
            ax.plot(refx, refy, "x" if len(x) == 1 else "--", color=line[0].get_color(), alpha=0.5)
    handles, labels = ax.get_legend_handles_labels()
    if logscale:
        ax.set_yscale("log", nonposy='clip')
        ax.get_yaxis().set_major_formatter(
            plt.ticker.FuncFormatter(lambda x, p: "%.4f" % float(x)))
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    if ylim:
        ax.set_ylim(*ylim)
    return handles, labels


def enrich_values(values):
    """
    adds addidional enriched properties to the dataset
    :param values:
    :return: the values with addidional properties
    """
    values["framelength"] = str(int(values["packetlength"])/(int(values["framelength"])/10))
    mod = ast.literal_eval(values["module_output_changed_when_system_failed_counts"])
    tmp = {k: v / int(values["num_violations"]) for k, v in mod.items()}
    values["module_output_changed_when_system_failed_ratio"] = str(tmp)
    tmp = {k: v / int(values["num_runs"]) for k, v in mod.items()}
    values["module_output_changed_when_system_failed_ratio_total"] = str(tmp)
    return values

currentname =args.routername
# Download dataset and prepare it
def getdataset():
    invalids = []

    file = 'http://ati.ttu.ee/~thilo/evals'+currentname+'.log'
    print(file)

    r = requests.get(file, stream=True)
    buffers = []
    buffer = []
    for line in r.iter_lines():
        """
        read the datasets seperated by newlines
        """
        if len(line.strip()) > 0:
            buffer.append(line.decode("utf-8"))
        else:
            if len(buffer) > 0:
                values = {line.split(':', 1)[0].strip(): line.split(':', 1)[1].strip() for line in buffer}
                if "ratio_violations" not in values or values["ratio_violations"] == "1.0":
                    invalids.append((int(values["packetlength"]), int(values["framelength"]), 1.0))
                    buffer = []
                    continue
                values = enrich_values(values)
                buffers.append(values)
                buffer = []
    if len(buffer) > 0:
        values = {line.split(':', 1)[0].strip(): line.split(':', 1)[1].strip() for line in buffer}
        if values["ratio_violations"] != "1.0" :
            values = enrich_values(values)
            buffers.append(values)
        else:
            invalids.append((int(values["packetlength"]),int(values["framelength"]),1.0))
    return buffers,invalids


buffers,failedsimulations = getdataset()
failedsimulations += [(10,220,1.0),(20,320,1.0),(30,520,1.0),(30,250,1.0),(30,510,1.0)]

# get packetlengths from data
packetlengths = sorted(list(set([int(v['packetlength'].split(',')[0]) for v in buffers])))

reference = createdataset_simple(buffers, 'ratio_violations')
referencecorrected = createdataset_simple(buffers, 'corrected_ratio')
path = args.imagefolder + '/'+currentname+'/'
if not os.path.exists(path):
    os.makedirs(path)

def fitcurve_simple(referencecorrected):
    x, y, z = np.asarray(referencecorrected).T
    # We're solving Ax = B
    A = np.column_stack([np.ones(len(x)), x, y, x/y, np.log(y)])
    result, _, _, _ = np.linalg.lstsq(A, np.log(z))
    print(result)
    xax = numpy.arange(3, 31)
    yax = numpy.arange(min(y), max(y))
    fitted = list(
        (x, y, np.exp(result[0] + (result[1] * x) + (result[2] * y) + result[3] * x/y + result[4] * np.log(y)))
        for x, y in
        itertools.product(xax, yax))
    return result, fitted


explanation = '<ul><li>INVALIDFLITS: a flittype violated the fsm (HEAD BODY+ TAIL)* for a port</li>' \
              '<li>MISROUTED: a flit was routed into an invalid direction</li>' \
              '<li>FAILEDDELIVERY: the amount of flits on a connection between two routers was unexpected.</li></ul>'


#result, fitted = fitcurve_simple(referencecorrected)#+failedsimulations)

plotsimple([(x, y, z) for x, y, z in referencecorrected], None,
           'Port Load Density', 'ratio', title=currentname, packetlengths=packetlengths, ylim=(0,1))
plt2.savefig(path + 'corrected_system_failure_probability.png')
with open(path + 'corrected_system_failure_probability.txt', 'w') as the_file:
    the_file.write('P(system failed)<br>\n'
    '100%% are all the experiments.<br>\n'
    'The ratio are all the experiments that failed from that.<br>\n'
        #'Dashed line is the lstsq regression with the result: %.4f+%.4f*pl+%.4f*cl+%.4f*pl/cl+%.4f*log(pl)\n' % tuple(result)
                   )


dat = createdataset_modules(buffers, 'param_module_failed_corrected_ratio')
plotmodules(dat, referencecorrected,
            'Port Load Density $\\frac{\mathit{packet\ length}}{\mathit{injection\ cycle\ length}}$', 'ratio', title="", packetlengths=packetlengths, ylim=(0, 0.3))
plt2.savefig(path + 'param_module_failed_corrected_ratio.png')
with open(path + 'param_module_failed_corrected_ratio.txt', 'w') as the_file:
    the_file.write('P(faultinejected into module and system failed)<br>\n'
    '100% are all the experiments.<br>\n'
    'The ratio are all where the system failed and the fault was injected into the module .<br>\n'
        '')

# when the system failed, how high is the probability, that also the module output changed
plotmodules(createdataset_modules(buffers, 'module_output_changed_when_system_failed_ratio'), None,
            'Port Load Density $\\frac{\mathit{packet\ length}}{\mathit{injection\ cycle\ length}}$',
            'ratio', title="", logscale=False, packetlengths=packetlengths, ylim=(0, 1))
plt2.savefig(path + 'module_output_changed_when_system_failed_ratio.png')
with open(path + 'module_output_changed_when_system_failed_ratio.txt', 'w') as the_file:
    the_file.write('P(module output changed | system failed)<br>\n'
    '100% are all the experiments where the system violated an invariant.<br>\n'
    'The ratio are all the experiments where the module output changed.<br>\n'
        'module_output_changed_when_system_failed_ratio: the probability that the module output is changed when the system fails.')

# fault in module caused system failure probability
plotmodules(createdataset_modules(buffers, 'param_module_changed_and_invalid_ratios'), None,
            'Port Load Density $\\frac{\mathit{packet\ length}}{\mathit{injection\ cycle\ length}}$',
            'ratio',
            title="", packetlengths=packetlengths, ylim=(0, 1))
plt2.savefig(path + 'param_module_changed_and_invalid_ratios.png')
with open(path + 'param_module_changed_and_invalid_ratios.txt', 'w') as the_file:
    the_file.write('P(system failed| fault injected into module and module output changed)<br>\n'
    '100% are all the experiments where a fault was injected into this module and the module output changed (so the fault had already a minimal impact).<br>\n'
    'The ratio are the experiments where the system violated an invariant.<br>\n'
        'param_module_changed_and_invalid_ratios: the probability that a fault introduced into the module which changed the output of the module causes system failure.')

plotmodules(createdataset_modules(buffers, 'param_module_changed_ratios'), None,
            '',
            'ratio',labelsonce=True,
            title=currentname, packetlengths=packetlengths, ylim=(0, 1))
plt2.savefig(path + 'param_module_changed_ratios.png')
with open(path + 'param_module_changed_ratios.txt', 'w') as the_file:
    the_file.write('P(module output changed| fault injected into module )<br>\n'
    '100% are all the experiments where a fault was injected into this module.<br>\n'
    'The ratio are all the experiments where the module output changed.<br>\n'
                   'param_module_changed_ratios: the probability that a fault introduced into the module causes the module`s output to change.')

plotmodules(createdataset_modules(buffers, 'faulttype_caused_by_module_ratio_corrected', flattensecondlayer=True), None,
            'Port Load Density $\\frac{\mathit{packet\ length}}{\mathit{injection\ cycle\ length}}$', 'ratio', title="", packetlengths=packetlengths, ylim=(0, 1))
plt2.savefig(path + 'faulttype_caused_by_module_ratio_corrected.png')
with open(path + 'faulttype_caused_by_module_ratio_corrected.txt', 'w') as the_file:
    the_file.write('P(failureclass present| fault injected into module)<br>\n'
    '100% are all the experiments where a fault was injected into this module.<br>\n'
    'The ratio are all the experiments where the specific failure class is present.<br>\n'
        'faulttype_caused_by_module_ratio_corrected: the probability that a certain failure type was caused by a fault injection into a certain module.'
         + explanation)

plotmodules(createdataset_modules(buffers, 'faulttype_ratios_total'), None,
            'Port Load Density $\\frac{\mathit{packet\ length}}{\mathit{injection\ cycle\ length}}$', 'ratio', title="", packetlengths=packetlengths, ylim=(0, 0.2))
plt2.savefig(path + 'faulttype_ratios_total.png')
with open(path + 'faulttype_ratios_total.txt', 'w') as the_file:
    the_file.write('P(failureclass present)<br>\n'
    '100% are all the experiments .<br>\n'
    'The ratio are all the experiments where the specific failure class is present.<br>\n'
        'faulttype_ratios_total: the probability that a certain fault occurs. 100% are all faults. ' + explanation
    )

plotmodules(createdataset_modules(buffers, 'faulttype_ratios_given_invalid'), None,
            'Port Load Density $\\frac{\mathit{packet\ length}}{\mathit{injection\ cycle\ length}}$', 'ratio', title="", packetlengths=packetlengths, ylim=(0, 1))
plt2.savefig(path + 'faulttype_ratios_given_invalid.png')
with open(path + 'faulttype_ratios_given_invalid.txt', 'w') as the_file:
    the_file.write('P(failureclass present)<br>\n'
    '100% are all the experiments where the system violated an invariant.<br>\n'
    'The ratio are all the experiments where the specific failure class is present.<br>\n'
        'faulttype_ratios_given_invalid: the probability that a certain fault occurs. 100% are all faults. ' + explanation
    )

dat = createdataset_modules(buffers, 'faulttype_and_module_output_changed', flattensecondlayer=True,
                            relativeto='faulttype_counts', layerselforrel=lambda arr: arr[0])
plotmodules(dat, None,
            'Port Load Density $\\frac{\mathit{packet\ length}}{\mathit{injection\ cycle\ length}}$', 'ratio', title="", packetlengths=packetlengths, ylim=(0, 1))
plt2.savefig(path + 'faulttype_and_module_output_changed.png')
with open(path + 'faulttype_and_module_output_changed.txt', 'w') as the_file:
    the_file.write('P(moduleoutput changed |failureclass present)<br>\n'
        'faulttype_and_module_output_changed: the probability that when a certain fault occurs the modules output changed too.' + explanation)

dat = createdataset_modules(buffers, 'faulttype_correlation', flattensecondlayer=True)
plotmodules(dat, None,
            'Port Load Density $\\frac{\mathit{packet\ length}}{\mathit{injection\ cycle\ length}}$', 'ratio', title="", packetlengths=packetlengths, ylim=(0, 1.01),shapehint=(3,3))
plt2.savefig(path + 'faulttype_correlation.png')
with open(path + 'faulttype_correlation.txt', 'w') as the_file:
    the_file.write('P(failuretype1 | failuretype2)<br>\n'
    '100% are all the experiments where the system satisfied (violated) failuretype 2.<br>\n'
    'The ratio are all where the system satisfied (violated) failuretype 1 .<br>\n'
        'faulttype_correlation: the probability that 2 failure types happened in the same run.' + explanation)
#

dat = createdataset_modules(buffers, 'ratio_violations_per_module')
plotmodules(dat, referencecorrected,
            'Port Load Density $\\frac{\mathit{packet\ length}}{\mathit{injection\ cycle\ length}}$', 'ratio', title="", packetlengths=packetlengths, ylim=(0, 0.35))
plt2.savefig(path + 'ratio_violations_per_module.png')
with open(path + 'ratio_violations_per_module.txt', 'w') as the_file:
    the_file.write('P(system failure | fault injected into module)<br>\n'
    '100% are all the experiments where the fault was injected into the module.<br>\n'
    'The ratio are all where the system failed .<br>\n'
        'ratio_violations_per_module: the probability that a fault injection into a module causes system failure.')

