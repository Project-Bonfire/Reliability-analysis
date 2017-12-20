import ast
import copy
import gzip
import re
import sys
from enum import Enum, auto

import io
from socdep2.ArchGraphUtilities.AG_Functions import *
from socdep2.ConfigAndPackages import Config, PackageFile
from socdep2.RoutingAlgorithms import Routing
from socdep2.RoutingAlgorithms.Calculate_Reachability import is_destination_reachable_via_port, \
    is_destination_reachable_from_source
from socdep2.SystemHealthMonitoring import SystemHealthMonitoringUnit
from socdep2.Utilities import misc

from typing import List, Dict


def init():
    misc.generate_file_directories()
    turns_health_2d_network = {"N2W": True, "N2E": True, "S2W": True, "S2E": True,
                               "W2N": True, "W2S": True, "E2N": True, "E2S": True}
    Config.ag.topology = '2DMesh'
    Config.ag.x_size = 4
    Config.ag.y_size = 4
    Config.ag.z_size = 1
    Config.RoutingType = 'MinimalPath'
    ag = copy.deepcopy(generate_ag(logging=None, report=False))
    shmu = SystemHealthMonitoringUnit.SystemHealthMonitoringUnit()
    shmu.setup_noc_shm(ag, copy.deepcopy(turns_health_2d_network), False)
    noc_rg = copy.deepcopy(Routing.generate_noc_route_graph(ag, shmu, PackageFile.XY_TurnModel, False, False))
    return noc_rg


class Module(Enum):
    lbdr = auto()
    fifo = auto()
    xbar = auto()
    arbiter = auto()


class Result:
    """

    """

    def __init__(self):
        pass

    name = ""
    # If the run failed somehow, means there are now files present
    # These are errors of the simulation program
    errornous = False

    # flags
    # if the number of packets which where sent to router 5 is unexpected
    unexpected_len_sent:bool = False
    # if the number of packets which where sent from router 5 is unexpected
    unexpected_len_recv:bool = False
    # number of actual packets
    len_sent = -1

    len_recv = -1

    # When the number of flits send from one node to another differs from the number of flits received there
    connection_counter_invalid = False

    # missing or errornous flits
    sents_invalid = 0
    recv_invalid = 0

    # due misrouting
    misrouted_recv = 0
    misrouted_sent = 0

    # the parameters of the simulation
    params = ""

    # if the modules vcd's differed from the expected.
    vcd_of_module_equal: Dict[str, bool] = None

    def getFaultModuleFromParam(self):
        """
        returns the faultmodule based on the param string.
        :return:
        """

        typemap = {
            r'^valid_': Module.fifo,
            r'^[\\]*CONTROL_PART/allocator_unit': Module.arbiter,
            r'^[\\]*CONTROL_PART/LBDR': Module.lbdr,
            r'^[\\]*FIFO_[NESLW]/FIFO_comb': Module.fifo,
            r'^[\\]*FIFO_[NESLW]/FIFO_seq': Module.fifo,
            r'^[\\]*XBAR': Module.xbar
        }
        comp = self.guessComponent()
        if comp == 'nofault':
            return None
        for k, v in typemap.items():
            if re.match(k, comp):
                return v
        return None


        # r'^U',

    def get_Names(self):
        splitted = self.params.split(' ')
        return str(splitted[4:6]) + str([ast.literal_eval(' '.join(splitted[7:]))])

    def guessComponent(self):
        splitted = self.params.split(' ')
        if splitted[4] == 'nofault':
            return 'nofault'
        if splitted[4].startswith('\\'):
            return splitted[4]
        else:
            try:
                return str(ast.literal_eval(' '.join(splitted[7:]))[0][0])
            except ValueError as ve:
                print("Failed to guess component! %s"%self.params, file=sys.stderr)
                return "nofault"

    def is_valid(self):
        return not (
            self.unexpected_len_recv or self.unexpected_len_sent or self.sents_invalid > 0 or self.recv_invalid > 0 or self.misrouted_sent > 0 or self.misrouted_recv > 0 or self.errornous or self.connection_counter_invalid)

    def __str__(self):
        return "[Name %s, Error: %r, unexpected_len_sent %r, unexpected_len_recv %r, len_sent %d, len_recv %d, sents_invalid %d, recv_invalid %d, Params: %s]" % \
               (self.name, self.errornous, self.unexpected_len_sent, self.unexpected_len_recv, self.len_sent,
                self.len_recv, self.sents_invalid, self.recv_invalid, self.params)


class FlitEvent:
    def __init__(self):
        pass

    class Type(Enum):
        HEAD = auto()
        BODY = auto()
        BODY1 = auto()
        TAIL = auto()

    flit = None
    # According to router 5
    on_in_port = False
    on_out_port = False
    # 0,1,2,3 for head body_1 body tail
    type = -1

    time = 0
    from_node = -1
    to_node = -1
    length = -1
    currentrouter = -1
    actual_length = -1
    id = -1

    def __str__(self):
        return "[Time=%d,From=%d,To=%d,Length=%d,Event_Location=%d,Actual_Length=%d,ID=%d]" % (
            self.time, self.from_node, self.to_node, self.length, self.currentrouter, self.actual_length, self.id)

    def switch_dir(self, dir):
        return {"S": "N",
                "N": "S",
                "W": "E",
                "E": "W",
                "L": "L"}[dir]

    def was_going_out_via(self):
        """
        This for incoming packets to determine the right out port of the sending router.
        returns from which side of the adjacent router of router 5 the packet went out
        so a packet from router 4 should return "W"
        :rtype: S|W|E|N as string

        """
        if not self.on_in_port:
            raise AssertionError("this is not an incoming packet event!")
        return self.switch_dir(self.pos_is_in_dir(self.from_node))

    def going_out_via(self):
        """
        returns to which side of the router 5 the packet traveled
        :rtype: S|W|E|N|L as string

        """
        if not self.on_out_port:
            raise AssertionError("this is not an outgoing packet event!")
        return self.pos_is_in_dir(self.currentrouter)

    def pos_is_in_dir(self, router_id):
        # type: (int) -> str
        """
        returns in which direction according to router 5 the given router id is
        :param router_id:
        :return: W|E|N|S|L as str
        """
        if router_id == 5:
            return "L"
        x = router_id % Config.ag.x_size
        y = router_id / Config.ag.y_size
        if x < 1:
            return "W"
        if x > 1:
            return "E"
        if y < 1:
            return "S"
        if y > 1:
            return "N"


class RecvFlit(FlitEvent):
    """
    A flit received from the router
    """
    parity_valid = True
    body_src = -1,
    body_dest = -1,
    body_packet_length = -1,
    body_id = -1,
    body_checksum = -1


def parse_sent_line(data):
    # type: (dict) -> FlitEvent
    """
    Parser for a dict of a line of the sent file.

    :param data: the data to parse
    :return: a Flit event
    """
    pe = dict_to_flit(data, FlitEvent)
    pe.on_in_port = True
    return pe


def parse_recv_line(data):
    # type: (dict) -> FlitEvent
    """
    Parser for a dict of a line of the received file.
    :param data: the data to parse
    :return: a Flit event
    """
    pe = dict_to_flit(data, RecvFlit)
    pe.on_out_port = True
    # Caution: inverted here!
    pe.parity_valid = True if data["parity_failed"] == "false" else False
    if pe.type == FlitEvent.Type.TAIL or pe.type == FlitEvent.Type.BODY:
        pe.body_src = int(data['body_src'])
        pe.body_dest = int(data['body_dest'])
        pe.body_packet_length = int(data['body_packet_length'])
        pe.body_id = int(data['body_packetid'])
        pe.body_checksum = int(data['body_checksum'])
    return pe


def dict_to_flit(data, type):
    pe = type()
    pe.time = int(data['time'].split(' ')[0])
    pe.currentrouter = int(data['currentrouter'])
    pe.from_node = int(data['from_node'])
    pe.to_node = int(data['to_node'])
    pe.length = int(data['length'])
    pe.id = int(data['id'])
    pe.flitno = int(data['flitno'])
    pe.type = [FlitEvent.Type.HEAD, FlitEvent.Type.BODY1, FlitEvent.Type.BODY, FlitEvent.Type.TAIL][
        ["header", "body1", "body", "tail"].index(data['type'])]
    return pe


def line_to_dict(line, splitchar=';', kvchar=':'):
    return {e[0]: e[1] for e in [x.split(kvchar) for x in line.strip().split(splitchar)]}


def evaluate_file(noc_rg, filename:str, print_verbose:bool=False, ralgo_check_sent_flits:bool=False,
                  module_reference: Dict[str, str] = None,expected_len_sent: int = -1, expected_len_recv: int  = -1) -> (List[Result], List[Result]):
    """
    Evaluates an simulation result file
    :param noc_rg: the graph model of the routing algorithm.
    :param filename: the path of the file to evaluate
    :param module_reference: a dict containing the hashes for each module vcd file.
    :param print_verbose: if additional information should be printed
    :ralgo_check_sent_flits: If the sent flits should be checked by the routing algorithm
    """
    assumed_sent = -1
    errornous = []
    results = []
    counter = 0
    def gzip_opener(*args,**kwargs):
        return io.BufferedReader(gzip.open(*args))
    opener = gzip_opener if filename.endswith(".gz") else open
    with opener(filename, 'r') as f:
        def experiment_to_buffer(f):
            """
            Creates an experiment object from the file
            :param f: file to read from
            :return: a dict containing the experiment.
            return {
                "name" : name, #the experiment id
                "params" : params, # the param string
                "sent" : sent, # list containing the sent lines
                        These are the lines which where sent to router 5
                "recv" : recv # list containing the recv lines
                        These are the lines which where sent by router 5
            }

            OR None if there is no other experiment
            """
            i = 0
            buffer = []
            for line in f:
                line = line if isinstance(line, str) else line.decode("utf-8")
                if line.startswith("#####"):
                    i = i + 1
                    if len(buffer) == 0:
                        if print_verbose:
                            print("reached end of file after %d experiments." % i)
                        return
                    name = buffer[0]
                    params = buffer[1]
                    indmodules = buffer.index("!modules:\n")
                    indsent = buffer.index("!sent:\n")
                    indrecv = buffer.index("!recv:\n")
                    modules = buffer[indmodules + 1:indsent]
                    sent = buffer[indsent + 1:indrecv]
                    recv = buffer[indrecv + 1:]
                    yield {
                        "name": name,
                        "params": params,
                        "sent": sent,
                        "recv": recv,
                        "modules": modules
                    }
                elif "-----\n" == line:
                    buffer = []
                else:
                    buffer.append(line)

        for experiment in experiment_to_buffer(f):
            counter = counter + 1
            if counter % 100 == 0 and print_verbose:
                print("Evaluated %d experiments!" % counter)
            res: Result = Result()
            res.name = experiment["name"].strip()
            try:
                recv = [parse_recv_line(line_to_dict(line)) for line in experiment["recv"]
                        if
                        line.strip()]
                sent = [parse_sent_line(line_to_dict(line)) for line in experiment["sent"] if
                        line.strip()]
                modules = dict(item.split(":") for item in experiment["modules"])
                if print_verbose and (len(modules) != 4 or 'lbdr' not in modules):
                    print("Strange module count found")
                    print(experiment["name"])
                    print(experiment["params"])
                    print(experiment["modules"])
                if print_verbose and counter == 1:
                    print(experiment)
                    print("first module params: " + experiment["params"])
                # auto detecting module reference, if first run is nofault
                if counter == 1 and module_reference == None and "nofault" in experiment["params"]:
                    if print_verbose:
                        print("Setting reference module")
                    module_reference = {}
                    for k, v in modules.items():
                        module_reference[k.strip()] = v.strip()

                if expected_len_recv == -1 or expected_len_sent == -1:
                    expected_len_sent = len(recv)
                    expected_len_recv = len(recv)



                def checkmodulehashes(modules: Dict[str, str], module_reference: Dict[str, str], result: Result,verbose=False):
                    """
                    compares the expected module hashes to the actual.
                    :param modules:
                    :param module_references:
                    :param result:
                    :return:
                    """
                    result.vcd_of_module_equal = {}
                    if module_reference == None:
                        return
                    for k, v in module_reference.items():
                        result.vcd_of_module_equal[k] = modules[k].strip() == v

                checkmodulehashes(modules, module_reference, res,verbose=print_verbose)

                res.params = experiment["params"].strip()
                res.len_recv = len(recv)
                res.len_sent = len(sent)
                if expected_len_recv != -1 or expected_len_sent != -1:
                    res.unexpected_len_recv = res.len_recv != expected_len_recv
                    res.unexpected_len_recv = res.len_recv != expected_len_recv
                if assumed_sent == -1:
                    assumed_sent = len(sent)
                    # res.unexpected_len_sent = len(sent) != assumed_sent
                    # If the first one is faulty, we run into problems here.
                    # But that might not happen anyways
                    # if False and len(sent) != assumed_sent:
                    # print("WARNING: The sent file of '%s' has an unexpected length of %d, expected %d." % (
                    #    res.name, len(sent), assumed_sent))
                # res.unexpected_len_recv = len(recv) != len(sent)
                fromtocounter = {}
                # A statemachine for the nodes. checks that the order is always (HeadBody+Tail)*
                node_states = {i: FlitEvent.Type.TAIL for i in [1, 4, 5, 6, 9]}
                for p in sent:
                    def tmpfunc(nodestates, p):
                        res.sents_invalid += 1

                    node_states = evaluate_flit_fsm(node_states, p, res, tmpfunc)

                    flitkey = str(p.from_node) + 'to' + str(p.to_node)
                    if flitkey in fromtocounter:
                        fromtocounter[flitkey] += 1
                    else:
                        fromtocounter[flitkey] = 1
                    if ralgo_check_sent_flits:
                        result = False
                        if p.from_node is not 5:
                            result = is_destination_reachable_via_port(noc_rg, p.from_node, p.was_going_out_via(),
                                                                       p.to_node, False)
                        else:
                            result = is_destination_reachable_from_source(noc_rg, 5, p.to_node)
                        if not result:
                            if print_verbose:
                                print(
                                    "WARNING: Generated Packet was not valid according to routing algorithm. Packet was sent from %d %s to %d via router 5. %s" % (
                                        p.from_node, p.was_going_out_via(), p.to_node, str(p)))
                            res.misrouted_sent += 1
                for k, v in node_states.items():
                    if v != FlitEvent.Type.TAIL:
                        res.sents_invalid += 1
                # A statemachine for the nodes. checks that the order is always (HeadBody+Tail)*
                node_states = {i: FlitEvent.Type.TAIL for i in [1, 4, 5, 6, 9]}

                for p in recv:
                    def tmpfunc(nodestates, p):
                        res.recv_invalid += 1

                    node_states = evaluate_flit_fsm(node_states, p, res, tmpfunc)
                    flitkey = str(p.from_node) + 'to' + str(p.to_node)
                    if flitkey in fromtocounter:
                        fromtocounter[flitkey] -= 1
                    else:
                        fromtocounter[flitkey] = -1

                    # check if reflected data in the body matches the packet header
                    if p.type in [FlitEvent.Type.BODY, FlitEvent.Type.TAIL]:
                        if p.id != p.body_id or p.from_node != p.body_src or p.to_node != p.body_dest \
                                or p.length != p.body_packet_length or not p.parity_valid:
                            res.recv_invalid += 1
                    if p.to_node > 15:  # will not be valid anyways
                        res.misrouted_recv += 1
                        continue
                    result = is_destination_reachable_via_port(noc_rg, 5, p.going_out_via(), p.to_node, False)
                    if not result:
                        # print(
                        #   "WARNING: Received Packet was not valid according to routing algorithm. Packet was sent from %d to %d via router 5. But it was received at: %d (dir:%s) %s" % (
                        #      p.from_node, p.to_node, p.currentrouter, p.going_out_via(), str(p)))
                        res.misrouted_recv += 1
                for k, v in fromtocounter.items():
                    if v != 0:
                        res.connection_counter_invalid = True
                for k, v in node_states.items():
                    if v != FlitEvent.Type.TAIL:
                        res.recv_invalid += 1
            except:
                res.errornous = True
                errornous.append(res)
                if print_verbose:
                    print("Unexpected error in %s: " % res.name, sys.exc_info()[0], sys.exc_info()[1])
                    print(res)

                continue
            results.append(res)
    return errornous, results


def evaluate_flit_fsm(node_states, p, res, callback):
    # statemachine for flittype
    new_state = p.type
    if node_states[p.currentrouter] == FlitEvent.Type.HEAD:
        if new_state != FlitEvent.Type.BODY1:
            callback(node_states, p)
    if node_states[p.currentrouter] == FlitEvent.Type.BODY1:
        if new_state == FlitEvent.Type.HEAD or new_state == FlitEvent.Type.BODY1:
            callback(node_states, p)
    if node_states[p.currentrouter] == FlitEvent.Type.BODY:
        if new_state == FlitEvent.Type.HEAD or new_state == FlitEvent.Type.BODY1:
            callback(node_states, p)
    if node_states[p.currentrouter] == FlitEvent.Type.TAIL:
        if new_state != FlitEvent.Type.HEAD:
            callback(node_states, p)
    node_states[p.currentrouter] = new_state
    return node_states


def count_fails(results):
    faillist = []
    for res in results:
        if not res.is_valid():
            # print(res)

            faillist.append(res)
    return faillist
