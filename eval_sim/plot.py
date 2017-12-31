import argparse
import ast
from typing import List

import numpy
import requests
import numpy as np
import matplotlib as plt
import matplotlib.pyplot as plt2
import itertools

# This file lets us create plots of the most current module data

parser = argparse.ArgumentParser(description='Evaluation the result of a Reliability-analysis simulation.')
parser.add_argument('imagefolder', type=str, help='The folder where the plots should be saved`.')
args = parser.parse_args()

packetlengths = [3, 5, 10, 20,30]


def createdataset_modules(buffers: List[List[str]], attribute):
    res = {'lbdr': [], 'fifo': [], 'xbar': [], 'arbiter': [], 'fifod': [],'fifoc':[]}
    for values in buffers:
        pl = int(values['packetlength'].split(',')[0])
        fl = int(values['framelength'])
        for m in ['lbdr', 'fifo', 'xbar', 'arbiter']:
            prob = ast.literal_eval(values[attribute])[m]
            res[m].append((pl, fl, prob))
    return res


def createdataset_simple(buffers: List[List[str]], attribute):
    res = []
    for values in buffers:
        pl = int(values['packetlength'].split(',')[0])
        fl = int(values['framelength'])
        prob = float(values[attribute])
        res.append((pl, fl, prob))
    return res


def plotmodules(dataset, reference, xlabel, ylabel, title="", logscale=False, packetlengths: List[int] = [3, 5, 10, 20],
                ylim=None):
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
    f, ax = plt2.subplots(3,2,figsize=(8, 10))
    ax = ax.flatten()
    type = ['lbdr', 'fifo', 'xbar', 'arbiter','fifod','fifoc']
    handles, labels = None, None

    def preparelist(list, pl):
        list = filter(lambda x: x[0] == pl, list)
        list = sorted(list, key=lambda x: x[1])
        return [v[1] for v in list], [v[2] for v in list]

    ref = None if not reference else lambda pl: preparelist(reference, pl)
    for i in range(len(type)):
        handles, labels = create_singleplot(ax[i], packetlengths, xlabel, ylabel,
                                            lambda pl: preparelist(res[type[i]], pl),
                                            reference=ref, ylim=ylim, title=type[i], logscale=logscale)
    f.legend(handles, labels)
    f.suptitle(title)
    plt2.tight_layout()


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
    res = dataset
    f = plt2.figure()
    ax = f.add_subplot(111)

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
    f.suptitle(title)
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
    ax.set_title(title)
    for pl in packetlengths:
        x, y = data(pl)
        # y = np.log([float(z) for z in y])
        # x = np.log([float(z) for z in x])
        line = ax.plot(x, y, "o" if len(x) == 1 else "-", label=pl)
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
    mod = ast.literal_eval(values["module_output_changed_when_system_failed_counts"])
    tmp = {k: v / int(values["num_violations"]) for k, v in mod.items()}
    values["module_output_changed_when_system_failed_ratio"] = str(tmp)
    tmp = {k: v / int(values["num_runs"]) for k, v in mod.items()}
    values["module_output_changed_when_system_failed_ratio_total"] = str(tmp)
    return values


# Download dataset and prepare it
def getdataset():
    file = 'http://ati.ttu.ee/~thilo/evalsnew.log'
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
                if values["ratio_violations"] == "1.0":
                    buffer = []
                    continue
                values = enrich_values(values)
                buffers.append(values)
                buffer = []
    if len(buffer) > 0:
        values = {line.split(':', 1)[0].strip(): line.split(':', 1)[1].strip() for line in buffer}
        if values["ratio_violations"] != "1.0":
            values = enrich_values(values)
            buffers.append(values)
    return buffers


buffers = getdataset()

# get packetlengths from data
packetlengths = sorted(list(set([int(v['packetlength'].split(',')[0]) for v in buffers])))

reference = createdataset_simple(buffers, 'ratio_violations')
referencecorrected = createdataset_simple(buffers, 'corrected_ratio')
path = args.imagefolder + '/'


def fitcurve_simple(referencecorrected):

    x, y, z = np.asarray(referencecorrected).T
    # We're solving Ax = B
    A = np.column_stack([np.ones(len(x)), x, y, np.log(x), np.log(y)])
    result, _, _, _ = np.linalg.lstsq(A, np.log(z))
    print(result)
    xax = numpy.arange(3, 30)
    yax = numpy.arange(70, 800)
    fitted = list(
        (x, y, np.exp(result[0] + (result[1] * x) + (result[2] * y) + result[3] * np.log(x) + result[4] * np.log(y)))
        for x, y in
        itertools.product(xax, yax))
    return result,fitted


result,fitted = fitcurve_simple(referencecorrected)

plotsimple([(x, y, z) for x, y, z in referencecorrected], fitted,
           'cyclelength (ns)', 'ratio', title="", packetlengths=packetlengths, ylim=None)
plt2.savefig(path + 'corrected_system_failure_probability.png')
with open(path + 'corrected_system_failure_probability.txt', 'w') as the_file:
    the_file.write(
        'Dashed line is the lstsq regression with the result: %.4f+%.4f*pl+%.4f*cl+%.4f*log(cl)+%.4f*log(pl)\n' % tuple(result))

# when the system failed, how high is the probability, that also the module output changed
plotmodules(createdataset_modules(buffers, 'module_output_changed_when_system_failed_ratio'), None, 'cyclelength (ns)',
            'ratio', title="", logscale=False, packetlengths=packetlengths, ylim=(0, 1))
plt2.savefig(path + 'module_output_changed_when_system_failed_ratio.png')
with open(path + 'module_output_changed_when_system_failed_ratio.txt', 'w') as the_file:
    the_file.write(
        'module_output_changed_when_system_failed_ratio: the probability that the module output changes when the system fails.')

# fault in module caused system failure probability
plotmodules(createdataset_modules(buffers, 'param_module_changed_and_invalid_ratios'), None, 'cyclelength (ns)',
            'ratio',
            title="", packetlengths=packetlengths, ylim=(0, 0.6))
plt2.savefig(path + 'param_module_changed_and_invalid_ratios.png')
with open(path + 'param_module_changed_and_invalid_ratios.txt', 'w') as the_file:
    the_file.write(
        'param_module_changed_and_invalid_ratios: the probability that a fault introduced into the module causes a '
        'changed output of the module and system failure.')

# like 1 but relative to the total number of runs.
plotmodules(createdataset_modules(buffers, 'module_output_changed_when_system_failed_ratio_total'), referencecorrected,
            'cyclelength (ns)', 'ratio', title="", packetlengths=packetlengths, ylim=(0, 0.2))
plt2.savefig(path + 'module_output_changed_when_system_failed_ratio_total.png')
with open(path + 'module_output_changed_when_system_failed_ratio_total.txt', 'w') as the_file:
    the_file.write(
        'module_output_changed_when_system_failed_ratio_total: the probability that a fault introduced into the module'
        ' causes a changed output of the module and system failure relative to the total number of runs.')
