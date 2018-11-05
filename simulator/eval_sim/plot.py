import argparse
import ast
from operator import itemgetter
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
parser.add_argument('routerdisplayname', type=str, help='The name of the router that should be used in the plots`.')
args = parser.parse_args()

packetlengths = [3, 5, 10, 20, 30]


def createdataset_modules(buffers: List[List[str]], attribute, flattensecondlayer=False,flattenthirdlayer=False, relativeto=None,
                          layerselforrel=lambda arr: arr[0],connectingword=" "):
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
                        val[k1 + connectingword + k2] = v2 / rel[layerselforrel([k1, k2])]
                    else:
                        val[k1 + connectingword + k2] = v2
        elif flattenthirdlayer:
            tmp = val
            val = {}
            for k1, v1 in tmp.items():
                for k2, v2 in v1.items():
                    for k3, v3 in v2.items():
                        if rel:
                            val[k1 + connectingword + k2+connectingword+k3] = v3 / rel[layerselforrel([k1, k2, k3])]
                        else:
                            val[k1 + connectingword + k2+connectingword+k3] = v3
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



def plotmodules(dataset, reference, xlabel, ylabel, title="",titlefontsize=12, logscale=False, packetlengths: List[int] = [3, 5, 10, 20],
                ylim=None,shapehint=None,sizehint=(3,2),labelsonce:bool=False,refissimple=False,refhasmodules=False,onlylowerxlabels=False):
    """
    plots the given dataset in 4 subplots, one for each module
    :param dataset: the dataset to show in the format [(packetlength,framrate, valuetoshow)]
    :param reference: a reference set or None. Same format as the dataset
    :param title: a title to add to the figure *ignored currently
    :param logscale: if True, setting the yaxis to logscale
    :return:
    """
    if not dataset:
        raise AttributeError("No dataset given!")
    res = dataset
    type = sorted(list(res.keys()))
    height = math.ceil(len(type) / 6) if not shapehint else shapehint[0]
    width = min(len(type), 6) if not shapehint else shapehint[1]
    f, ax = plt2.subplots(height, width, figsize=(width * sizehint[0], height * sizehint[1] +(1 if xlabel else 0)), sharey=True, gridspec_kw={'wspace':0})
    #st = f.suptitle(title, fontsize=11)
    ax = ax.flatten()


    handles, labels = None, None

    def preparelist(list, pl):
        list = filter(lambda x: x[0] == pl, list)
        list = sorted(list, key=lambda x: x[1])
        return [v[1] for v in list], [v[2] for v in list]


    for i in range(len(type)):
        ref = None if not reference else lambda pl: preparelist(reference if not refhasmodules else reference[type[i]],
                                                                pl if not refissimple else 0)
        handles, labels = create_singleplot(ax[i], packetlengths, "" if labelsonce else xlabel, "" if labelsonce else ylabel ,
                                            lambda pl: preparelist(res[type[i]], pl),
                                            reference=ref, ylim=ylim, title=type[i], logscale=logscale,titlefontsize=titlefontsize,showxlabels=(i/width >= height-1)if onlylowerxlabels else True)
        loc = plt.ticker.LinearLocator(numticks=sizehint[1] * 4)  # this locator puts ticks at regular intervals
        ax[i].yaxis.set_major_locator(loc)



    f.legend(handles, labels)

    plt2.tight_layout()
   # if False and title:
    #    st.set_y(1)
     #   f.subplots_adjust(top=1-(0.15/height))
    if labelsonce:
        f.text(0, 0.5, ylabel, va='center', rotation='vertical')
        f.text(0.5,0.02,xlabel,va='center')
        #f.text(0.5, 0.04, xlabel, ha='center')
        #set_shared_ylabel(ax, ylabel)



def plotsimple(dataset, reference, xlabel, ylabel, title="", logscale=False, packetlengths: List[int] = [3, 5, 10, 20],
               ylim=None,refissimple=False,sizehint=(6.4,4.8),ref2=None):
    """
    plots the given dataset in 4 subplots, one for each module
    :param dataset: the dataset to show in the format [(packetlength,framrate, valuetoshow)]
    :param reference: a reference set or None. Same format as the dataset
    :param title: a title to add to the figure
    :param logscale: if True, setting the yaxis to logscale
    :param ref2: a third plot for the fig
    :return:
    """
    f = plt2.figure(figsize=sizehint)
    ax = f.add_subplot(111)
    st = f.suptitle(title, fontsize=11)

    handles, labels = None, None

    def preparelist(list, pl):
        list = filter(lambda x: x[0] == pl, list)
        list = sorted(list, key=lambda x: x[1])
        return [v[1] for v in list], [v[2] for v in list]

    ref = None if not reference else lambda pl: preparelist(reference, pl if not refissimple else 0)
    r2 = None if not ref2 else lambda pl: preparelist(ref2, pl if not refissimple else 0)
    handles, labels = create_singleplot(ax, packetlengths, xlabel, ylabel,
                                        lambda pl: preparelist(dataset, pl),
                                        reference=ref, ylim=ylim, title="", logscale=logscale,ref2=r2)
    f.legend(handles, labels)

    loc = plt.ticker.LinearLocator(numticks=sizehint[1]*4)  # this locator puts ticks at regular intervals
    ax.yaxis.set_major_locator(loc)

    plt2.tight_layout()
    if title:
        st.set_y(0.98)
        f.subplots_adjust(top=0.90)


def create_singleplot(ax, packetlengths, xlabel,
                      ylabel, data, reference=None, ylim=None, title="", logscale=False,titlefontsize="x-large",showxlabels =True,xlim=(.1,.7),ref2=None):
    """
    plots a single plot
    :param ax: the figure to plot on
    :param packetlengths: one packetlength for each line to plot into the figure
    :param xlabel: label for the xaxis
    :param ylabel: label for the yaxis
    :param data: function which gives back x,z for an item from packetlengths
    :param reference: reference data to draw dashed or None. Same as data.
    :param ylim: Set limits for the yaxis or None
    :param xlim: Set limits for the xaxis or None, defaults to .1,.7
    :param title: set the title of the plot
    :param logscale: if the yaxis should be logscaled
    :return: the handles and the labels to draw the legend.
    """
    plt2.locator_params(axis='x', nticks=10)
    ax.set_title(title,fontsize=titlefontsize)
    for pl in packetlengths:
        x, y = data(pl)
        # y = np.log([float(z) for z in y])
        # x = np.log([float(z) for z in x])
        line = ax.plot(x, y, "x" if len(x) == 1 else "-", label=pl)
        line = ax.plot(x, y, "x",color=line[0].get_color())
        e=[0.01 for x in range(len(x))]
        #ax.errorbar(x, y, e, linestyle='None', marker='x',color=line[0].get_color())
        # plot refline
        if reference:
            refx, refy = reference(pl)
            ax.plot(refx, refy, "x" if len(x) == 1 else "--", color=line[0].get_color(), alpha=0.7)
        if ref2:
            refx, refy = ref2(pl)
            ax.plot(refx, refy, "x" if len(x) == 1 else "-.", color=line[0].get_color(), alpha=0.7)

    handles, labels = ax.get_legend_handles_labels()
    if logscale:
        ax.set_yscale("log", nonposy='clip')
        ax.get_yaxis().set_major_formatter(
            plt.ticker.FuncFormatter(lambda x, p: "%.2f" % float(x)))

    if not showxlabels:
        ax.get_xaxis().set_ticklabels([])
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.grid(linestyle='dashed')
    if ylim:
        ax.set_ylim(*ylim)
    if xlim:
        ax.set_xlim(*xlim)
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
    ratio = float(values['corrected_ratio'])
    mod = ast.literal_eval(values["param_module_failed_corrected_ratio"])
    values["module_fail_sens_contribution"] = str({k: v/ratio for k,v in mod.items()})
    return values

currentname =args.routername
routerdisplayname=args.routerdisplayname
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
packetlengths = [3,5,10,20]#sorted(list(set([int(v['packetlength'].split(',')[0]) for v in buffers])))

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

#The fault injection locations per module
ref_locs_per_module ={k: v[0][2] for k,v in createdataset_modules(buffers, 'ref_locs_per_module').items()}
total_modulesize = sum(ref_locs_per_module.values())


#result, fitted = fitcurve_simple(referencecorrected)#+failedsimulations)

plotsimple([(x, y, z) for x, y, z in referencecorrected], None,
           'Port Load Density', 'Fault Sensitivity', title=routerdisplayname, packetlengths=packetlengths, ylim=(0,.21))
plt2.savefig(path + 'corrected_system_failure_probability.png')
with open(path + 'corrected_system_failure_probability.txt', 'w') as the_file:
    the_file.write('P(system failed)<br>\n'
    '100%% are all the experiments.<br>\n'
    'The ratio are all the experiments that failed from that.<br>\n'
        #'Dashed line is the lstsq regression with the result: %.4f+%.4f*pl+%.4f*cl+%.4f*pl/cl+%.4f*log(pl)\n' % tuple(result)
                   )

plotsimple([(x, y, z* total_modulesize) for x, y, z in referencecorrected], None,
           'Port Load Density', 'Reliability Measure', title=routerdisplayname, packetlengths=packetlengths, ylim=(0,4200))
plt2.savefig(path + 'faultsens_times_locs.png')
with open(path + 'faultsens_times_locs.txt', 'w') as the_file:
    the_file.write('P(system failed)<br>\n'
    '100%% are all the experiments.<br>\n'
    'The ratio are all the experiments that failed from that.<br>\n'
        #'Dashed line is the lstsq regression with the result: %.4f+%.4f*pl+%.4f*cl+%.4f*pl/cl+%.4f*log(pl)\n' % tuple(result)
                   )

dat = createdataset_modules(buffers, 'param_module_failed_corrected_ratio')
plotmodules(dat, referencecorrected,
            'Port Load Density ', 'ratio', title="", packetlengths=packetlengths, ylim=(0, 0.25),sizehint=(3,1),labelsonce=True)
plt2.savefig(path + 'param_module_failed_corrected_ratio.png')
with open(path + 'param_module_failed_corrected_ratio.txt', 'w') as the_file:
    the_file.write('P(faultinejected into module and system failed)<br>\n'
    '100% are all the experiments.<br>\n'
    'The ratio are all where the system failed and the fault was injected into the module .<br>\n'
        '')


dat = createdataset_modules(buffers, 'module_fail_sens_contribution')
flarr = {k: [fl for pl,fl,val in v] for k, v in dat.items()}
plarr = {k: [pl for pl,fl,val in v] for k, v in dat.items()}
valarr = {k: [val for pl,fl,val in v] for k, v in dat.items()}
contribution_pars = {k:np.linalg.lstsq(np.vstack([flarr[k], np.ones(len(flarr[k])),plarr[k]]).T, valarr[k])[0] for k in valarr.keys()}
regdat = {k:[(pl, fl, contribution_pars[k][0] * fl + contribution_pars[k][1]+contribution_pars[k][2]*pl) for pl, fl, val in v] for k, v in dat.items()}
plotmodules(dat, regdat,
            'Port Load Density ', 'ratio', title="module_fail_sens_contribution", packetlengths=packetlengths, ylim=(0, .8),sizehint=(3,1),refhasmodules=True)
plt2.savefig(path + 'module_fail_sens_contribution.png')
with open(path + 'module_fail_sens_contribution.txt', 'w') as the_file:
    the_file.write('The contribution per module to the failure sensitivity.<br>\n'
                   'Calculated for each module from the fraction the param_module_failed_corrected_ratio has from the corrected_system_failure_probability.')

dat=createdataset_modules(buffers, 'param_module_changed_ratios')
flarr = {k: [fl for pl,fl,val in v] for k, v in dat.items()}
plarr = {k: [pl for pl,fl,val in v] for k, v in dat.items()}
valarr = {k: [val for pl,fl,val in v] for k, v in dat.items()}
pmc_pars = {k:np.linalg.lstsq(np.vstack([flarr[k], np.ones(len(flarr[k])),plarr[k]]).T, valarr[k])[0] for k in valarr.keys()}
regdat = {k:[(pl, fl, pmc_pars[k][0] * fl + pmc_pars[k][1]+pmc_pars[k][2]*pl) for pl, fl, val in v] for k, v in dat.items()}
plotmodules(dat, regdat,
            'Port Load Density',
            'ratio',labelsonce=True,
            title=routerdisplayname, packetlengths=packetlengths, ylim=(0, 0.7),sizehint=(3,1),titlefontsize=10,refhasmodules=True)
plt2.savefig(path + 'param_module_changed_ratios.png')
with open(path + 'param_module_changed_ratios.txt', 'w') as the_file:
    the_file.write('P(module output changed| fault injected into module )<br>\n'
    '100% are all the experiments where a fault was injected into this module.<br>\n'
    'The ratio are all the experiments where the module output changed.<br>\n'
                   'param_module_changed_ratios: the probability that a fault introduced into the module causes the module`s output to change.')


# fault in module caused system failure probability
dat=createdataset_modules(buffers, 'param_module_changed_and_invalid_ratios')
flarr = {k: [fl for pl,fl,val in v] for k, v in dat.items()}
plarr = {k: [pl for pl,fl,val in v] for k, v in dat.items()}
valarr = {k: [val for pl,fl,val in v] for k, v in dat.items()}
pmcai_pars = {k:np.linalg.lstsq(np.vstack([flarr[k], np.ones(len(flarr[k])),plarr[k]]).T, valarr[k])[0] for k in valarr.keys()}
regdat = {k:[(pl, fl, pmcai_pars[k][0] * fl + pmcai_pars[k][1]+pmcai_pars[k][2]*pl) for pl, fl, val in v] for k, v in dat.items()}
plotmodules(dat, regdat,
            'Port Load Density ',
            'ratio',
            title="", packetlengths=packetlengths, ylim=(0, 1),refhasmodules=True)
plt2.savefig(path + 'param_module_changed_and_invalid_ratios.png')
with open(path + 'param_module_changed_and_invalid_ratios.txt', 'w') as the_file:
    the_file.write('P(system failed| fault injected into module and module output changed)<br>\n'
    '100% are all the experiments where a fault was injected into this module and the module output changed (so the fault had already a minimal impact).<br>\n'
    'The ratio are the experiments where the system violated an invariant.<br>\n'
        'param_module_changed_and_invalid_ratios: the probability that a fault introduced into the module which changed the output of the module causes system failure.')



dat = createdataset_modules(buffers, 'ratio_violations_per_module')
flarr = {k: [fl for pl,fl,val in v] for k, v in dat.items()}
valarr = {k: [val for pl,fl,val in v] for k, v in dat.items()}
plarr = {k: [pl for pl,fl,val in v] for k, v in dat.items()}
sens_p_mod_pars = {k:np.linalg.lstsq(np.vstack([flarr[k], np.ones(len(flarr[k])),plarr[k]]).T, valarr[k])[0] for k in valarr.keys()}
regdat = {k:[(pl, fl, sens_p_mod_pars[k][0] * fl + sens_p_mod_pars[k][1]+sens_p_mod_pars[k][2]*pl) for pl, fl, val in v] for k, v in dat.items()}
plotmodules(dat, regdat,
            'Port Load Density ', 'failure sensitivity per module', title="", packetlengths=packetlengths, ylim=(0, 0.35),refhasmodules=True,sizehint=(3,1),labelsonce=True)
plt2.savefig(path + 'ratio_violations_per_module.png')
with open(path + 'ratio_violations_per_module.txt', 'w') as the_file:
    the_file.write('P(system failure | fault injected into module)<br>\n'
    '100% are all the experiments where the fault was injected into the module.<br>\n'
    'The ratio are all where the system failed .<br>\n'
        'ratio_violations_per_module: the probability that a fault injection into a module causes system failure.')

#deviations = [abs(1-(z/(sum((sens_p_mod_pars[k][0]*y+sens_p_mod_pars[k][1]+sens_p_mod_pars[k][2]*x)*(v[0] * y + v[1]+x*v[2]) for k, v in contribution_pars.items())))) for x, y, z in referencecorrected]

#estimate the fail sens by using the estimated contribution from  above contribution_m * failsens_m



if True and currentname == "TableBased_Routing_8_flit_FIFO_Arbiter" :
    sens_p_mod_pars = {'xbar': [0.3891983146206851, 0.01408875973052787, -3.0648242363404826e-05],
                       'rtable': [0.0950474036803633, 0.0650442376115535, -0.0015491079522997608],
                       'fifoc': [0.10008682422756829, 0.26602664880644766, -0.0007186921386569955],
                       'arbiter': [0.05179026325984285, 0.03407490644488097, 2.9386925518334883e-05],
                       'fifod': [0.19832185483291845, 0.023966292566348524, -0.0013416651082691182]}
    contribution_pars = {'xbar': [0.13913846777669775, 0.10365007987133526, 0.0022377905934002212],
                         'rtable': [-0.2251659254543154, 0.3132043817246665, -0.0020394789499064703],
                         'fifoc': [-0.3875678907175833, 0.2823820198574456, 0.001229991277045872],
                         'arbiter': [-0.04573233852980088, 0.04056257485090333, 0.00034180378152288277],
                         'fifod': [0.3903781100846242, 0.512470904740984, -0.004530268520338332]}
    ref_locs_per_module = {'rtable': 5532, 'arbiter': 1132, 'xbar': 2793, 'fifoc': 1096, 'fifod': 17920}
    pmc_pars = {'xbar': [0.12927351717919, 0.6278364238631639, -0.0010454419557489603],
                'rtable': [0.053435014424986826, 0.520137756149326, -0.000780543278760204],
                'fifoc': [0.15384985126562048, 0.40433059180738584, -0.0006719039321574916],
                'arbiter': [0.08849469710986191, 0.5406283254074611, -0.0008108405508632233],
                'fifod': [0.29017076433925326, 0.24413674897536533, -0.004759352787617577]}
    pmcai_pars = {'xbar': [0.5606866374511834, 0.022146498874668828, 0.0003821737038993099],
                  'rtable': [0.16474967313699274, 0.1245330401423548, -0.0026717142135283395],
                  'fifoc': [-0.0004468170569529897, 0.6580773011845774, -0.0006596700790079124],
                  'arbiter': [0.07258422806091921, 0.06420445999038625, 0.00012358844287416182],
                  'fifod': [0.45711994558319025, 0.1081845554634241, -0.0008771179438182147]}

# calculate relative sizes from locs.
rel_sizes = {k:v/sum(ref_locs_per_module.values()) for k,v in ref_locs_per_module.items()}

# contribution based estimation
parstring="\\\\<br>\n".join(
                       ["&%s & (%.3f,%.4f,%.3f) & (%.3f,%.4f,%.3f)" % (k, v[0],v[2], v[1], contribution_pars[k][0],contribution_pars[k][2], contribution_pars[k][1])
                        for k, v in sorted(sens_p_mod_pars.items())])
deviations = [(x,y,abs((z-(sum((sens_p_mod_pars[k][0]*y+sens_p_mod_pars[k][1]+sens_p_mod_pars[k][2]*x)*(v[0] * y + v[1]+x*v[2]) for k, v in contribution_pars.items()))))) for x, y, z in referencecorrected]
#estimate the fail sens by using the estimated contribution from  above contribution_m * failsens_m
estimation = [(x, y, sum(
    (sens_p_mod_pars[k][0]*y+sens_p_mod_pars[k][1]+sens_p_mod_pars[k][2]*x)*(v[0] * y + v[1]+x*v[2])for k, v in contribution_pars.items())) for
                       x, y, z in referencecorrected]
plotsimple([(x,y,z) for x, y, z in referencecorrected], estimation,
           'Port Load Density', 'ratio (c-estimator)', ref2=deviations, title=routerdisplayname, packetlengths=packetlengths, ylim=(0,.21),sizehint=(6.4,3))
plt2.savefig(path + 'module_fail_sens_contribution_estimation.png')
with open(path + 'module_fail_sens_contribution_estimation.txt', 'w') as the_file:
    #sensstr = {k:"%.3f&%.3f"%(v[0],v[1]) for k, v in sens_p_mod_pars.items()}
    the_file.write('estimates the fail sens from module_fail_sens_contribution\n<br> sensitivity per module:<br>'
                   +'\n<br>max_dev:' + str(max(map(itemgetter(2),deviations)))
                   + '\n<br>sespars:' + str(sens_p_mod_pars)
                   + '\n<br>contrpars:' + str(contribution_pars) + '\n<br>Parameters: '+
                   parstring)

#pmc estimation>
def pmc_est(k,x,y):
    """
    the pmc estimator
    :param k: the module name
    :param x: packet length
    :param y: framelength
    :return: the pmc estimation of the routers fault sensitivity.
    """
    #relative router module size is drawn from the first experiment.
    return rel_sizes[k] * (pmcai_pars[k][0] * y + pmcai_pars[k][1] + pmcai_pars[k][2] * x) * (pmc_pars[k][0] * y + pmc_pars[k][1] + x * pmc_pars[k][2])


parstring_pmc="\\\\<br>\n".join(
                       ["&%s & %.4f &(%.3f,%.4f,%.3f) &(%.3f,%.4f,%.3f) " % (k, rel_sizes[k], pmcai_pars[k][0],pmcai_pars[k][2], pmcai_pars[k][1],pmc_pars[k][0],pmc_pars[k][2],pmc_pars[k][1])
                        for k, v in sorted(pmc_pars.items())])
estimation_pmc = [(x, y, sum(
    pmc_est(k,x,y) for k, v in pmc_pars.items())) for
                       x, y, z in referencecorrected]
deviations_pmc = [(x,y,abs(z-sum(
    pmc_est(k, x, y) for k, v in pmc_pars.items()))) for x, y, z in referencecorrected]
plotsimple([(x,y,z) for x, y, z in referencecorrected], estimation_pmc,
           'Port Load Density', 'ratio (o-estimator)', ref2=deviations_pmc,title=routerdisplayname, packetlengths=packetlengths, ylim=(0,.21),sizehint=(6.4,3))
plt2.savefig(path + 'module_fail_sens_contribution_estimation_pmc.png')
with open(path + 'module_fail_sens_contribution_estimation_pmc.txt', 'w') as the_file:
    the_file.write('Estimation based on the param module output change ratio. rel module size times module output change ratio times this ratio causing failure.<br>'
                   +'\n<br>max_dev:' + str(max(map(itemgetter(2),deviations_pmc)))+'<br> rel size,pmcai,senspmod<br>'+
                   parstring_pmc)


plotsimple(deviations,None,
           'Port Load Density', 'ratio', title=routerdisplayname, packetlengths=packetlengths, ylim=(0,.07),sizehint=(6.4,3))
plt2.savefig(path + 'estimation_deviation.png')
with open(path + 'estimation_deviation.txt', 'w') as the_file:
    #sensstr = {k:"%.3f&%.3f"%(v[0],v[1]) for k, v in sens_p_mod_pars.items()}
    the_file.write('estimation_deviation<br>\n'
                   '<samp style="white-space: nowrap;overflow: scroll;">'
                   #'sens_p_mod_pars = '+str({k : v.tolist()for k,v, in sens_p_mod_pars.items()})+'<br>\n'
                   #'contribution_pars = ' + str({k : v.tolist()for k,v, in contribution_pars.items()}) + '<br>\n'
                   #'ref_locs_per_module = ' + str(ref_locs_per_module) + '<br>\n'
                   #'pmc_pars = ' + str({k : v.tolist()for k,v, in pmc_pars.items()}) + '<br>\n'
                   #'pmcai_pars = ' + str({k : v.tolist()for k,v, in pmcai_pars.items()}) + '<br>'
                                                                                           '</samp>\n'
                   )

plotsimple(deviations_pmc,None,
           'Port Load Density', 'ratio', title=routerdisplayname, packetlengths=packetlengths, ylim=(0,.07),sizehint=(6.4,3))
plt2.savefig(path + 'estimation_deviation_pmc.png')
with open(path + 'estimation_deviation_pmc.txt', 'w') as the_file:
    #sensstr = {k:"%.3f&%.3f"%(v[0],v[1]) for k, v in sens_p_mod_pars.items()}
    the_file.write('estimation_deviation (pmc)'
                   )

# when the system failed, how high is the probability, that also the module output changed
plotmodules(createdataset_modules(buffers, 'module_output_changed_when_system_failed_ratio'), None,
            'Port Load Density ',
            'ratio', title="", logscale=False, packetlengths=packetlengths, ylim=(0, 1))
plt2.savefig(path + 'module_output_changed_when_system_failed_ratio.png')
with open(path + 'module_output_changed_when_system_failed_ratio.txt', 'w') as the_file:
    the_file.write('P(module output changed | system failed)<br>\n'
    '100% are all the experiments where the system violated an invariant.<br>\n'
    'The ratio are all the experiments where the module output changed.<br>\n'
        'module_output_changed_when_system_failed_ratio: the probability that the module output is changed when the system fails.')




plotmodules(createdataset_modules(buffers, 'faulttype_caused_by_module_ratio_corrected', flattensecondlayer=True), None,
            'Port Load Density ', 'ratio', title="", packetlengths=packetlengths, ylim=(0, 1),shapehint=(3,5),sizehint=(3,1),labelsonce=True,titlefontsize=10,onlylowerxlabels=True)
plt2.savefig(path + 'faulttype_caused_by_module_ratio_corrected.png')
with open(path + 'faulttype_caused_by_module_ratio_corrected.txt', 'w') as the_file:
    the_file.write('P(failureclass present| fault injected into module)<br>\n'
    '100% are all the experiments where a fault was injected into this module.<br>\n'
    'The ratio are all the experiments where the specific failure class is present.<br>\n'
        'faulttype_caused_by_module_ratio_corrected: the probability that a certain failure type was caused by a fault injection into a certain module.'
         + explanation)

plotmodules(createdataset_modules(buffers, 'faulttype_ratios_total'), None,
            'Port Load Density ', 'ratio', title="", packetlengths=packetlengths, ylim=(0, 0.2))
plt2.savefig(path + 'faulttype_ratios_total.png')
with open(path + 'faulttype_ratios_total.txt', 'w') as the_file:
    the_file.write('P(failureclass present)<br>\n'
    '100% are all the experiments .<br>\n'
    'The ratio are all the experiments where the specific failure class is present.<br>\n'
        'faulttype_ratios_total: the probability that a certain fault occurs. 100% are all faults. ' + explanation
    )

plotmodules(createdataset_modules(buffers, 'faulttype_ratios_given_invalid'), None,
            'Port Load Density ', 'failure class ratio', title="", packetlengths=packetlengths, ylim=(0, 1),sizehint=(3,1),labelsonce=True,)
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
            'Port Load Density', 'ratio', title=routerdisplayname, packetlengths=packetlengths, ylim=(0.45, 1),shapehint=(3,5),sizehint=(3,1),labelsonce=True,titlefontsize=10,onlylowerxlabels=True)
plt2.savefig(path + 'faulttype_and_module_output_changed.png')
with open(path + 'faulttype_and_module_output_changed.txt', 'w') as the_file:
    the_file.write('P(moduleoutput changed |failureclass present)<br>\n'
        'faulttype_and_module_output_changed: the probability that when a certain fault occurs the modules output changed too.' + explanation)

dat = createdataset_modules(buffers, 'faulttype_correlation', flattensecondlayer=True,connectingword=" given ")
plotmodules(dat, None,
            'Port Load Density ', 'ratio of the correlation between failure classes ', title=routerdisplayname, sizehint=(3,.9), packetlengths=packetlengths, ylim=(0, 1.01),shapehint=(3,3),labelsonce=True,titlefontsize=9,onlylowerxlabels=True)
plt2.savefig(path + 'faulttype_correlation.png')
with open(path + 'faulttype_correlation.txt', 'w') as the_file:
    the_file.write('P(failuretype1 | failuretype2)<br>\n'
    '100% are all the experiments where the system satisfied (violated) failuretype 2.<br>\n'
    'The ratio are all where the system satisfied (violated) failuretype 1 .<br>\n'
        'faulttype_correlation: the probability that 2 failure types happened in the same run.' + explanation)
#

# dat = createdataset_modules(buffers, 'faulttype_correlation3',flattenthirdlayer=True,connectingword=" ")
# plotmodules(dat, None,
#             'Port Load Density ', 'ratio of the correlation between failure classes ', title=routerdisplayname, sizehint=(3,.9), packetlengths=packetlengths, ylim=(0, 1.01),labelsonce=True,titlefontsize=9,onlylowerxlabels=True)
# plt2.savefig(path + 'faulttype_correlation3.png')
# with open(path + 'faulttype_correlation3.txt', 'w') as the_file:
#     the_file.write('P(failuretype1 | failuretype2|failuretype3)<br>\n'
#     '100% are all the experiments where the system satisfied (violated) failuretype 2.<br>\n'
#     'The ratio are all where the system satisfied (violated) failuretype 1 .<br>\n'
#         'faulttype_correlation: the probability that 2 failure types happened in the same run.' + explanation)

dat = createdataset_modules(buffers, 'faulttype_combinations', flattensecondlayer=True,connectingword=" given ")
plotmodules(dat, None,
            'Port Load Density ', 'ratio ', title=routerdisplayname, sizehint=(3,.9), packetlengths=packetlengths, ylim=(0, 1.01),labelsonce=True,titlefontsize=9,onlylowerxlabels=True)
plt2.savefig(path + 'faulttype_combinations.png')
with open(path + 'faulttype_combinations.txt', 'w') as the_file:
    the_file.write('all combinations of faulttypes in i.hasError(Faulttype.FAILEDDELIVERY) == truths[0] and i.hasError(Faulttype.MISROUTED) == truths[1] and i.hasError(Faulttype.INVALIDFLITS) == truths[2]')



