import argparse
import ast
import gzip
import json
import pickle
import sys

from evaluation_tools import Evaluator

def main(args):
    
    if args.verbose:
        print('Evaluating experiments file %s' % args.infile, file=sys.stderr)


    #############################
    # Read fault injection data #
    #############################

    if args.fi_info:
        # Read information, such as number of injection locations from the fi_info file 
        # and store it in the injection data variable
        injection_data = {}

        try:
            with open(args.fi_info, 'r') as fi:
                for line in fi.read().splitlines():
                    key, value = line.split('=', 1)
                    injection_data[key] = ast.literal_eval(value)

        except (FileNotFoundError, PermissionError) as err:
            print('Cannot open design file', args.design_info, file=sys.stderr)
            print('Error was:', err, file=sys.stderr)

        except ValueError as err:
            print('Wrongly formatted line in FI info file:', line, file=sys.stderr)
            print('The error was:', err, file=sys.stderr)


    if 'none' in injection_data['modules']:
        print('W A R N I N G: Module \'none\' was found in injection data and was removed! '
            '(Frame Length: %d, Packet Length: %d)' % (args.framelength, args.packetlength), 
            file=sys.stderr)

        injection_data['modules'].remove('none')


    ###########################
    # Process the experiments #
    ###########################

    experiments = []
    
    # If the experiments have been processed earlier, just read the file
    if args.read_experiments:
        if args.verbose:
            print('Reading Results file...', file=sys.stderr)

        experiments = pickle.load(gzip.open(args.read_experiments, 'rb'))

    # If the experiments have not been processed, process them first
    else:
        if args.verbose:
            print('Running Evaluator...', file=sys.stderr)

        noc_rg = Evaluator.init()
        errornous, experiments = Evaluator.evaluateFile(noc_rg, args.infile, 
                                                        print_verbose=args.verbose)

        if errornous:
            print('W A R N I N G: Evaluator reported errors! '
                '(Frame Length: %d, Packet Length: %d)' % (args.framelength, args.packetlength), 
                file=sys.stderr)

    # IF experiments should be stored in the file, do it.
    if args.write_experiments:
        if args.verbose:
            print('Writing Results...', file=sys.stderr)
        pickle.dump(experiments, gzip.open(args.write_experiments, 'wb'))
    

    #########################################
    # Initialize variables for data storage #
    #########################################

    results= {
        ##### General information #####

        # Total number of experiments
        'experiment_count' : len(experiments),

        # Experiment count per each module
        'module_exp_count' : {module:0 for module in injection_data['modules']},

        'packet_length' : args.packetlength,
        'frame_length' : args.framelength,
        'injection_rate' : 1/float(args.framelength),

        ##### ERRORS / FAILURES #####

        # Type: Error; Observed: toplevel output; Fault injected: anywhere in the design
        'top_level_error_count' : 0,

        # Type: Failure; Observed: toplevel output; Fault injected: anywhere in the design
        'top_level_failure_count' : 0,

        # Type: Error; Observed: module output; Fault injected: anywhere in the design
        'module_total_error_count': {module:0 for module in injection_data['modules']},
        
        # Type: Error; Observed: module output; Fault injected: anywhere in the design    
        'fault_in_module_caused_error_at_module' : {module:0 for module in injection_data['modules']},

        # Type: Error; Observed: toplevel output; Fault injected: anywhere in the design
        'module_caused_error_at_top_level' : {module:0 for module in injection_data['modules']},
        
        # Type: Failure; Observed: toplevel output; Fault injected: anywhere in the design
        'module_caused_failure_at_top_level' : {module:0 for module in injection_data['modules']}
    }

    #####################
    # Result evaluation #
    #####################

    # Count different effects of the faults over all experiments
    for exp in experiments:

        top_level_failure_detected = False
        top_level_error_detected = False

        # Find out into which module a fault was injected during the processed experiment
        faulty_module = exp.getFaultModuleFromParam()

        if faulty_module != 'nofault':
            results['module_exp_count'][exp.getFaultModuleFromParam()] += 1

        # Failure at toplevel
        if not exp.is_valid():
            results['top_level_failure_count'] += 1
            top_level_failure_detected = True

        # Error at toplevel
        if not exp.vcd_of_module_equal['top_level']:
            results['top_level_error_count'] += 1
            top_level_error_detected =True

        # Per-module statistics
        for module_name, errornous in exp.vcd_of_module_equal.items():
            if errornous and module_name != 'top_level':

                results['module_total_error_count'][module_name] += 1

                # Statistics for the case where the fault was also injected into the current module
                if exp.getFaultModuleFromParam() == module_name:
                    results['fault_in_module_caused_error_at_module'][module_name] += 1

                    if top_level_error_detected:
                        results['module_caused_error_at_top_level'][module_name] += 1
                    
                    if top_level_failure_detected:
                        results['module_caused_failure_at_top_level'][module_name] += 1

    if args.verbose:
        # Check if there is any experiments which does not have exp data in it.
        exp_result = [r for r in experiments if not r.vcd_of_module_equal]
        print('%d without module data' % len([r for r in exp_result if r.errornous]), 
                file=sys.stderr)


    ##################
    # Output results #
    ##################

    formatted_json = json.dumps(results, sort_keys=True, indent=4)

    print(formatted_json)

    if args.output_file:

        try:
            with open(args.output_file, 'w') as output:
                output.write(formatted_json)

        except (FileNotFoundError, PermissionError) as err:
            print('Cannot open design file', args.design_info, file=sys.stderr)
            print('Error was:', err, file=sys.stderr)


#######################################################
# Sets up the environment for running the application #
#######################################################

if __name__ == '__main__':

    if (sys.version_info < (3, 6)):
        print('This script is designed to run on Python 3.6 or newer!')
        exit(1)

    print()
    print('================')
    print('RESULT EVALUATOR')
    print('================')
    print()

    # Parse arguments
    parser = argparse.ArgumentParser('Evaluation the exp of a Reliability-analysis simulation.')

    parser.add_argument('infile', type=str,
                        help='The inputfile to read, either a `.experiments` '
                                'file or gzipped `experiments.gz`.')

    parser.add_argument('--verbose', action='store_true',
                        help='Prints progress and additional information.')

    parser.add_argument('--output-file', type=str,
                        help='The file where the output should be stored. '
                                'If no filename is the output will be printed on screen')

    parser.add_argument('--write-experiments', nargs='?', type=str, default=None,
                        help='Stores the intermediate exp objects to the given gzip file.')

    parser.add_argument('--read-experiments', nargs='?', type=str, default=None,
                        help='Loads intermediate exp objects from the given gzip '
                                'file instead of evaluating `infile`.')

    parser.add_argument('--fi-info', type=str, default=None,
                        help='The file which contains basic information about '
                                'the fault injection experiments...')

    parser.add_argument('--framelength', type=int, default=None,
                    help='Frame length for this set of experiments')

    parser.add_argument('--packetlength', type=int, default=None,
                    help='Frame length for this set of experiments')

    args = parser.parse_args()

    # Start the evaluator
    main(args)
