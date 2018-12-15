import ast
import copy
import gzip
import io
import re
import sys
from enum import Enum, auto
from typing import Dict, List

from socdep2.ArchGraphUtilities.AG_Functions import *
from socdep2.ConfigAndPackages import Config, PackageFile
from socdep2.RoutingAlgorithms import Routing
from socdep2.RoutingAlgorithms.Calculate_Reachability import (is_destination_reachable_from_source,
                                                              is_destination_reachable_via_port)
from socdep2.SystemHealthMonitoring import SystemHealthMonitoringUnit
from socdep2.Utilities import misc


class FaultType(Enum):
    MISROUTED = auto()
    FAILEDDELIVERY = auto()
    INVALIDFLITS = auto()

class FlitType(Enum):
    HEAD = auto()
    BODY = auto()
    BODY1 = auto()
    TAIL = auto()

class Result:
    """

    """

    def __init__(self):
        # Metadata
        self.exp_id = ""
        self.params = ""

        # If the run failed somehow, menaing there are now files present (which files? - KJ)
        # These are errors of the simulation program
        self.errornous = False

        # Flag specifying if the number of packets which were sent_flits to router 5 is unexpected
        self.unexpected_len_sent: bool = False
        # Flag specifying if the number of packets which were sent_flits from router 5 is unexpected
        self.unexpected_len_recv: bool = False
        # Flag specifying if number of flits sent_flits from one node to another differs from the number of flits received there
        self.connection_counter_invalid = False

        # Number of sent_flits and recvd packets
        self.len_sent = -1
        self.len_recv = -1

        # Missing or errornous flits
        self.sents_invalid = 0
        self.recv_invalid = 0

        # Due to misrouting
        self.misrouted_recv = 0
        self.misrouted_sent = 0

        # A dictionary containing the information if the modules vcd's were 
        # different from what was expected.
        self.vcd_of_module_equal: Dict[str, bool] = None

        self.faultinfo = ""


    def has_routing_errors(self):
        """
        Checks if routing errors were detected

        Return:
            True, if mis-routed sent or received packets were detected, else False
        """
        return (self.misrouted_sent + self.misrouted_recv) != 0


    def has_invalid_flitcounts(self):
        """
        Checks if number of flits which were received is invalid

        Return:
            True, if connection_counter_invalid flag is set, else False
        """
        return self.connection_counter_invalid


    def has_invalid_flits(self):
        """
        Checks if any of the received or sent flits were faulty (faulty data)

        Return:
            Returns true if faulty flits were detected, else false
        """
        return (self.sents_invalid + self.recv_invalid) != 0


    def hasError(self, fault: FaultType):
        """
        Checks if any faults were detected during the injection run

        Parameters:
            fault:  Type of the fault to be queried, according to the FaultType enum class

        Return:
            Number of the faults referred by the 'fault' parameter. None of a 'fault' parameter
            does not have a valid value
        """

        ret_value = None

        if fault == FaultType.FAILEDDELIVERY:
            ret_value = self.has_invalid_flitcounts()
        
        elif fault == FaultType.MISROUTED:
            ret_value = self.has_routing_errors()

        elif fault == FaultType.INVALIDFLITS:
            ret_value = self.has_invalid_flits()


        return ret_value


    def getFaultModuleFromParam(self):
        """
        Returns the faultmodule based on the param string.
        :return: the module string
        """
        # new format:
        if len(self.params.split(' ')) >= 7:
            if self.params.split(' ')[6][0] == '!':
                return self.params.split(' ')[6][1:]

        print("Parsing error at: " + self.params, file=sys.stderr)
        sys.exit("Parseerror!")

        # r'^U',


    def get_Names(self):
        splitted = self.params.split(' ')
        return str(splitted[4:6]) + str([ast.literal_eval(' '.join(splitted[7:]))])


    def guess_component(self):
        splitted = self.params.split(' ')

        if splitted[4] == 'nofault':
            return 'nofault'

        if splitted[4].startswith('\\'):
            return splitted[4]
        else:
            try:
                return str(ast.literal_eval(' '.join(splitted[7:]))[0][0])
            except ValueError as ve:
                print("Failed to guess component! %s" %
                      self.params, file=sys.stderr)
                return "nofault"


    def is_valid(self):

        is_valid = not (
            self.unexpected_len_recv or \
            self.unexpected_len_sent or \
            self.sents_invalid > 0 or \
            self.recv_invalid > 0 or \
            self.misrouted_sent > 0 or \
            self.misrouted_recv > 0 or \
            self.errornous or \
            self.connection_counter_invalid)

        # print(self.unexpected_len_recv, \
        #     self.unexpected_len_sent, \
        #     self.sents_invalid > 0, \
        #     self.recv_invalid > 0, \
        #     self.misrouted_sent > 0, \
        #     self.misrouted_recv > 0, \
        #     self.errornous, \
        #     self.connection_counter_invalid, '->', is_valid)

        return is_valid


    def __str__(self):
        return "[exp_id: %s, Error: %r, unexpected_len_sent %r, unexpected_len_recv %r, len_sent %d, len_recv %d, " \
                "sents_invalid %d, recv_invalid %d, Params: %s]" % \
                (self.exp_id, self.errornous, self.unexpected_len_sent, self.unexpected_len_recv, self.len_sent,
                    self.len_recv, self.sents_invalid, self.recv_invalid, self.params)

# End Class Result


class FlitEvent:
    def __init__(self):
        self.flit = None
        # According to router 5
        self.on_in_port = False
        self.on_out_port = False
        # 0,1,2,3 for head body_1 body tail
        self.flit_type = -1

        self.time = 0
        self.src_node = -1
        self.dst_node = -1
        self.length = -1
        self.currentrouter = -1
        self.actual_length = -1
        self.packet_id = -1

    def __str__(self):
        return "[Time=%d,From=%d,To=%d,Length=%d,Event_Location=%d,Actual_Length=%d,ID=%d]" % (
            self.time, self.src_node, self.dst_node, self.length, self.currentrouter, self.actual_length, self.packet_id)

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

        return self.switch_dir(self.pos_is_in_dir(self.src_node))

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

# End class FlitEvent

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


###########################
# Beginning of Evaluation #
###########################
def init():
    """
    Uses SoCDep2 to generate a routing graph

    Returns:
        Routing graph
    """
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

    noc_rg = copy.deepcopy(Routing.generate_noc_route_graph(
        ag, shmu, PackageFile.XY_TurnModel, False, False))

    return noc_rg


def parseSentLine(data):
    """
    Parses a dictionary of a line for a sent flit into a flit event
    # type: (dict) -> FlitEvent

    Parameters:
        data: The dictionary to be parsed

    Return: a Flit event
    """

    flit = dictToFlit(data, FlitEvent)
    flit.on_in_port = True

    return flit


def parseRecvdLine(data):
    """
    Parses a dictionary of a line for a received flit into a flit event
    type: (dict) -> FlitEvent

    Parameters:
        data: The dictionary to be parsed

    Return: a Flit event
    """
    
    flit = dictToFlit(data, RecvFlit)
    flit.on_out_port = True
    # Caution: inverted here!
    flit.parity_valid = True if data["parity_failed"] == "false" else False

    if flit.type == FlitType.TAIL or flit.type == FlitType.BODY:
        flit.body_src = int(data['body_src'])
        flit.body_dest = int(data['body_dest'])
        flit.body_packet_length = int(data['body_packet_length'])
        flit.body_id = int(data['body_packetid'])
        flit.body_checksum = int(data['body_checksum'])

    return flit


def dictToFlit(data, data_type):
    """
    Parses a dictionary containing data of a received or sent flit into a format 
    used by the evaluation tool.

    Parameters:
        data:       Data to be parsed
        data_type:  Datatype to use for storing the info
    
    Return:
        Data processed into the format specified by type
    """

    flit = data_type()
    flit.time = int(data['time'].split(' ')[0])
    flit.currentrouter = int(data['currentrouter'])
    flit.src_node = int(data['from_node'])
    flit.dst_node = int(data['to_node'])
    flit.length = int(data['length'])
    flit.id = int(data['id'])
    flit.flitno = int(data['flitno'])
    flit.type = [FlitType.HEAD, FlitType.BODY1, FlitType.BODY, FlitType.TAIL][
        ["header", "body1", "body", "tail"].index(data['type'])]

    return flit


def lineToDict(line, splitchar=';', kvchar=':'):
    """
    Reads a line stored in the results format and builds a dictionary from the line
    for better processing.

    Parameters:
        line:   Line to be processed
        splitchar:  Character which separates keyword-values in the line
        kvchar: Character which is used to separate the keyword from a value 
                in a keyword-value pair int he line
    Return:
        Line processed into a python dictionary
    """
    return {e[0]: e[1] for e in [x.split(kvchar) for x in line.strip().split(splitchar)]}


def experimentToBuffer(result_file, print_verbose):
    """
    Generator function for creating experiment objects from the file

    Parameters:
        result_file: file to read from
        print_verbose: Set true for additional debug messages

    Yield:
        Yields an experiment for each experiment in the list of experiments
        yield {
                "exp_id" : exp_id,      # the experiment id
                "params" : params,  # the param string
                "sent_flits" : sent_flits,      # list containing the sent_flits lines
                                    # These are the lines which where sent_flits to router 5
                "recvd_flits" : recvd_flits       # list containing the recvd_flits lines
                                    # These are the lines which where sent_flits by router 5
                }
        Will not yield anything if file is empty

    Return:
        None when EOF is reached
    """

    i = 0
    buffer = []

    for line in result_file:
        line = line if isinstance(line, str) else line.decode("utf-8")

        # Beginning of a new experiment, clean the buffer
        if line == "-----\n":
            buffer = []

        # End of an experiment
        elif line.startswith("#####"):
            i += 1

            # EOF
            if len(buffer) == 0 and print_verbose:
                print("reached end of file after %d experiments." % i)
                return

            # Experiment metadata
            exp_id = buffer[0] # int
            params = buffer[1] # string explaining where a fault was injected and when

            # Find the different blocks in the experiment results
            modules_index = buffer.index("!modules:\n")
            input_index = buffer.index("!input:\n")
            output_index = buffer.index("!output:\n")

            # Read the different blocks from the buffer
            modules = buffer[modules_index + 1:input_index]
            sent_flits = buffer[input_index + 1:output_index]
            recvd_flits = buffer[output_index + 1:]

            # Yield a result with experiment data
            yield {
                "exp_id": exp_id,
                "params": params,
                "sent_flits": sent_flits,
                "recvd_flits": recvd_flits,
                "modules": modules
            }

        else:
            buffer.append(line)


def gzipOpener(*args, **kwargs):
    """
    Implements a wrapper around gzip.open to be used instead of normal 'open' command,
    thus making reading of gzip-ed text files transperant
    """

    return io.BufferedReader(gzip.open(*args))


def checkModuleHashes(modules: Dict[str, str], module_hashes: Dict[str, str], result: Result, verbose=False):
    """
    Compares the expected module hashes to the actual hashes.
    
    Parameters:
        modules:    Dictionary containing the modules and their hashes
        module_references:  Dictionary containing module names and the expected hashes
        result: Result data structure, where to strore the information
                    If a specific hash is equal to the expected one, True is stored into
                    result.vcd_of_module_equal[module], else false is stored

    Returns: None

    Raises: RuntimeError, if no hashes are found
    """

    result.vcd_of_module_equal = {}

    if module_hashes == None:
        raise RuntimeError("No hashes found!")

    for module, module_hash in module_hashes.items():
        result.vcd_of_module_equal[module] = (modules[module].strip() == module_hash)


def evaluateFile(noc_rg, filename: str, print_verbose: bool = False, ralgo_check_sent_flits: bool = False,
                  module_hashes: Dict[str, str] = None, expected_len_sent: int = -1, expected_len_recv: int = -1) -> (List[Result], List[Result]):
    """
    Evaluates an simulation result file
    Params:
        noc_rg: Graph model of the routing algorithm.
        filename: Path to the results file to evaluate
        module_hashes: A dict containing the hashes for each module vcd file.
        print_verbose: Bool specifying if additional information should be printed
        ralgo_check_sent_flits:  If the sent flits should be checked by the routing algorithm
    """

    print(file=sys.stderr)
    print('Analyzing NoC simulation results...', file=sys.stderr)
    print('-----------------------------------', file=sys.stderr)
    print('N O T E! This script assumes you ran your experiments on router 5 of a 4x4 NoC using the XY routing algorithm', file=sys.stderr)
    print('If this is not the case, please re-simulate with the correct parameters or update this code', file=sys.stderr)
    print(file=sys.stderr)

    results = []
    errornous = []
    exp_counter = 0
    assumed_sent = -1

    # Open .gz files with gzip opener, otherwise use normal opener
    opener = gzipOpener if filename.endswith(".gz") else open

    # Count the number of experiments in the results file
    print("Analyzing results file...", file=sys.stderr)
    total_exps = 0

    try:
        with opener(filename, 'r') as result_file:
            for line in result_file:
                line = line if isinstance(line, str) else line.decode("utf-8")
                if line == "-----\n":
                    total_exps += 1
    
    except (FileNotFoundError, PermissionError) as err:
        print("Cannot open results file", result_file, file=sys.stderr)
        print("Error was:", err, file=sys.stderr)
        sys.exit(1)

    print("Total number of experiments to process:", total_exps, file=sys.stderr)
    print()

    if total_exps == 0:
        print("No experiments found! Exiting!", file=sys.stderr)
        sys.exit(1)

    # Actually process the results
    print("Processing results...")
    with opener(filename, 'r') as result_file:

        # Process all experiments one-by-one
        for experiment in experimentToBuffer(result_file, print_verbose):
            # print(experiment['exp_id'], experiment['params'])
            res: Result = Result()
            exp_counter += 1

            # Print a status message after every 100 experiments
            if exp_counter % 100 == 0 and print_verbose:
                print("Progress: evaluated %d experiments out of %d. (%.2f%%)" % (exp_counter, total_exps, 
                                                                                exp_counter * 100 / total_exps), file=sys.stderr)

            # Store the experiment ID
            res.exp_id = experiment["exp_id"].strip()
            
            try:                
                # Save all lines belonging to blocks into separate variables
                recvd_flits = [parseRecvdLine(lineToDict(line)) for line in experiment["recvd_flits"] if line.strip()]
                sent_flits = [parseSentLine(lineToDict(line)) for line in experiment["sent_flits"] if line.strip()]
                modules = dict(item.strip().split(":") for item in experiment["modules"])
            
                if print_verbose and exp_counter == 1:
                    print("First module params: " + experiment["params"])

                # Auto-detecting module hashes to the ones in the first run, if first run is fault free
                if exp_counter == 1 and module_hashes == None and \
                    "nofault" in experiment["params"]:

                    if print_verbose:
                        print("Setting module hashes to be equal to the first (fault free) experiment", file=sys.stderr)

                    module_hashes = {}

                    for module_name, module_hash in modules.items():
                        module_hashes[module_name.strip()] = module_hash.strip()

                # Populate results dict
                if expected_len_sent == -1:
                    expected_len_sent = len(sent_flits)

                if expected_len_recv == -1:
                    expected_len_recv = len(recvd_flits)

                checkModuleHashes(modules, module_hashes,
                                    res, verbose=print_verbose)

                res.params = experiment["params"].strip()
                res.len_sent = len(sent_flits)
                res.len_recv = len(recvd_flits)

                if expected_len_sent != -1:
                    res.expected_len_sent = (res.len_sent != expected_len_sent)

                if expected_len_recv != -1:
                    res.unexpected_len_recv = (res.len_recv != expected_len_recv)

                if assumed_sent == -1:
                    assumed_sent = len(sent_flits)

                src_to_dst_counter = {}

                # A state machine for the neighboring nodes. Checks that the order is always (HeadBody+Tail)*
                # We are checking the inputs / outputs of router 5. 
                # The neighbors of router 5 in a 4x4 NoC are the nodes 1, 4, 6 and 9.
                node_states = {i: FlitType.TAIL for i in [1, 4, 5, 6, 9]}

                # Process all flits which were sent during the experiments
                for flit in sent_flits:
                    node_states = evaluateFlitFSM(node_states, flit, res.sents_invalid)

                    src_to_dst_string = str(flit.src_node) + 'to' + str(flit.dst_node)

                    # Increase the specific counter for the source-destination pair
                    if src_to_dst_string in src_to_dst_counter:
                        src_to_dst_counter[src_to_dst_string] += 1
                    else:
                        src_to_dst_counter[src_to_dst_string] = 1


                    if ralgo_check_sent_flits:
                        result = False
                        if flit.src_node is not 5:
                            result = is_destination_reachable_via_port(noc_rg, flit.src_node, flit.was_going_out_via(),
                                                                        flit.dst_node, False)
                        else:
                            result = is_destination_reachable_from_source(noc_rg, 5, flit.dst_node)


                        if not result and print_verbose:
                            print("WARNING: Generated Packet was not valid according to routing algorithm. "\
                                    "Packet was sent_flits from %d %s to %d via router 5. %s" \
                                    % (flit.src_node, flit.was_going_out_via(), flit.dst_node, str(flit)), file=sys.stderr)
                            res.misrouted_sent += 1

                for k, v in node_states.items():
                    if v != FlitType.TAIL:
                        res.sents_invalid += 1


                # sys.exit("BYE!") # FIXME: FOR DEBUG ONLY!!

                # A state machine to check the validity of flit order. Checks that the order is always (HeadBody+Tail)*
                node_states = {i: FlitType.TAIL for i in [1, 4, 5, 6, 9]}

                for flit in recvd_flits:
                    # def tmpfunc(nodestates, flit):
                    #     res.recv_invalid += 1

                    node_states = evaluateFlitFSM(node_states, flit, res.recv_invalid)

                    src_to_dst_string = str(flit.src_node) + 'to' + str(flit.dst_node)

                    if src_to_dst_string in src_to_dst_counter:
                        src_to_dst_counter[src_to_dst_string] -= 1

                    else:
                        src_to_dst_counter[src_to_dst_string] = -1


                    # check if reflected data in the body matches the packet header
                    if flit.type in [FlitType.BODY, FlitType.TAIL]:
                        if flit.id != flit.body_id or flit.src_node != flit.body_src \
                            or flit.dst_node != flit.body_dest \
                            or flit.length != flit.body_packet_length \
                            or not flit.parity_valid:
                            
                            res.recv_invalid += 1

                    # If the destination address of the packet is larger than 15, it will be always faulty in a 4x4 network
                    if flit.dst_node > 15:
                        res.misrouted_recv += 1
                        continue

                    result = is_destination_reachable_via_port(
                        noc_rg, 5, flit.going_out_via(), flit.dst_node, False)

                    if not result:
                        # print(
                        #   "WARNING: Received Packet was not valid according to routing algorithm. Packet was sent_flits from %d to %d via router 5. But it was received at: %d (dir:%s) %s" % (
                        #      flit.src_node, flit.dst_node, flit.currentrouter, flit.going_out_via(), str(flit)))
                        res.misrouted_recv += 1


                for src_dst_pair, count in src_to_dst_counter.items():
                    if count != 0:
                        res.connection_counter_invalid = True
                        res.faultinfo += "con_counter=(%s,%d) %s\n" % (src_dst_pair, count, flit)

                # print("EXPERIMENT:", exp_counter, "TIME:", flit.time, "ALL TAILS??:", all(value == FlitType.TAIL for value in node_states.values()))
                for node, flit_type in node_states.items():
                    if flit_type != FlitType.TAIL:
                        res.recv_invalid += 1
                        res.faultinfo += "flitfsm=(%s,%s) %s\n" % (node, flit_type, flit)

            except:
                res.errornous = True
                errornous.append(res)

                if print_verbose:
                    res.faultinfo += "Unexpected error in %s: " % res.exp_id, sys.exc_info()[
                        0], sys.exc_info()[1]
                    print("Unexpected error in %s: " %
                          res.exp_id, sys.exc_info()[0], sys.exc_info()[1])
                    print(res)

                continue
            results.append(res)

    print(file=sys.stderr)
    print('===============================', file=sys.stderr)
    print('Processed %d experiments in total' % exp_counter, file=sys.stderr)

    return errornous, results
# END evaluateFile()

def evaluateFlitFSM(node_states, flit, invalid_counter):
    """
    Checks if the next state is calculated correctly, following the state logic
    HEADER BODY1 BODY* TAIL for each packet. It also increases the invalid counter

    Parameters:
        node_states:    A dict specifying the current states for all the nodes
        flit:           Flit information
        invalid_counter:    The invalid counter to increase

    Return:
        The updated node states
    """

    init_count = invalid_counter
    new_state = flit.type

    if node_states[flit.currentrouter] == FlitType.HEAD:
        if new_state != FlitType.BODY1:
            invalid_counter += 1

    if node_states[flit.currentrouter] == FlitType.BODY1 or\
        node_states[flit.currentrouter] == FlitType.BODY:

        if new_state != FlitType.BODY and new_state != FlitType.TAIL:
            invalid_counter += 1

    if node_states[flit.currentrouter] == FlitType.TAIL:
        if new_state != FlitType.HEAD:
            invalid_counter += 1
    
    # # FIXME: FOR DEBUGGING ONLY
    # if init_count != invalid_counter:
    # if flit.src_node == 6:
    #     # print(flit.currentrouter, node_states[flit.currentrouter], new_state, invalid_counter - init_count)
    #     print(flit.src_node, flit.dst_node, flit.length, '->', node_states[flit.currentrouter])

    node_states[flit.currentrouter] = new_state

    return node_states
