import ast
from typing import List
import requests

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
    :return: [m:[pl,fl,val]]
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


# Download dataset and prepare it
def getdataset(currentname):
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

routernames = ['lbdr_4flit_allocator','lbdr_4flit_arbiter','lbdr_8flit_arbiter','tablebased_4flit_fifo_arbiter','tablebased_8flit_fifo_arbiter']
datasets={r : getdataset(r)[0] for r in routernames}

router_failure_sens = {k:createdataset_simple(v,'corrected_ratio') for k,v in datasets.items()}
module_failure_sens_rel = {k:createdataset_modules(v,'param_module_failed_corrected_ratio') for k,v in datasets.items()}
for router in routernames:
    sensmap = {} #collect all sensitivities
    for pl,fl,val in router_failure_sens[router]:
        sensmap[(pl,fl)] = val
    rels = {}
    for module,vals in module_failure_sens_rel[router].items():#fill akku
        for pl, fl, val in vals:
            rels.setdefault(module,[]).append(val/sensmap[(pl,fl)])
    #ratiomap = {k:sensakku[k]/sensmap[k] for k in sensakku.keys()}
    avgdiff = {k:sum(v) for k,v in rels.items()}
    print(avgdiff,min(rels.values()),max(rels.values()))
    print()
