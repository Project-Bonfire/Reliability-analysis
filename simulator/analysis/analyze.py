#!/usr/bin/python3

###########################################################################
#                                                                         #
# File:   analyze.py                                                      #
# Author: Karl Janson (karl.janson@taltech.ee)                            #
# Last modification date: 2019-05-07                                      #
# ----------------------------------------------------------------------- #
#                                                                         #
# Parses the simulation results and calculates propagation probabilities. #
# The results are stored both per experiment run and also as averages     #
# in JSON files.                                                          #
#                                                                         #
###########################################################################

import argparse
import json
import pprint


def evaluateResult(exp_run):
    """
    Performs calculations to figure out fault probabilities.
    Params: 
        exp_run: Dictionary containing the results from a single experiment run to process
    
    Return:
        A dictionary containing the calculated probabilities
    """
    percentage_tl_errors_caused_by_module = dict()
    percentage_tl_errors_caused_by_module_total = dict()
    percentage_tl_failure_caused_by_module = dict()
    percentage_tl_failure_caused_by_module_total = dict()
    module_logic_error_propagation_rate = dict()
    module_input_error_propagation_rate = dict()

    # Sanity checks:
    all_errors = sum(exp_run['module_caused_error_at_top_level'].values())
    if all_errors != exp_run['top_level_error_count']:
        raise RuntimeError('Packet length ' + exp_run['packet_length'] + ', frame length ' 
                            + exp_run['frame_length'] + ': Number of errors logged into '
                            + 'modules and the number of errors seen in the TL is different!')

    all_failures = sum(exp_run['module_caused_failure_at_top_level'].values())
    if all_failures != exp_run['top_level_failure_count']:
        raise RuntimeError('Packet length ' + exp_run['packet_length'] + ', frame length ' 
                            + exp_run['frame_length'] + ': Number of failures logged into '
                            + 'modules and the number of failures seen in the TL is different!')

    # Process the data
    for module, errors in exp_run['module_caused_error_at_top_level'].items():
        percentage_tl_errors_caused_by_module[module] = errors / exp_run['module_exp_count'][module]
        percentage_tl_errors_caused_by_module_total[module] = errors / exp_run['experiment_count']

    for module, errors in exp_run['module_caused_failure_at_top_level'].items():
        percentage_tl_failure_caused_by_module[module] = errors / exp_run['module_exp_count'][module]
        percentage_tl_failure_caused_by_module_total[module] = errors / exp_run['experiment_count']

    for module, errors in exp_run['fault_in_module_caused_error_at_module'].items():
        module_logic_error_propagation_rate[module] = errors / exp_run['module_exp_count'][module]

    for module, errors in exp_run['module_error_propagation_count'].items():
        module_input_error_propagation_rate[module] = errors / exp_run['module_input_exp_count'][module]

    calculated_results = {
        'percentage_tl_errors_caused_by_module': percentage_tl_errors_caused_by_module,
        'percentage_tl_errors_caused_by_module_total': percentage_tl_errors_caused_by_module_total,
        'percentage_tl_failure_caused_by_module': percentage_tl_failure_caused_by_module,
        'percentage_tl_failure_caused_by_module_total': percentage_tl_failure_caused_by_module_total,
        'module_logic_error_propagation_rate': module_logic_error_propagation_rate,
        'module_input_error_propagation_rate': module_input_error_propagation_rate
    }

    return calculated_results


def average_dict(current_average, results, level):
    """
    Recursively calculates the average values in two dictionaries with identical structure
    Parameters:
        current_average: Dictionary containing the intermediate averaging result.
                         The contents of the 'results' dict will be averaged with this.
        results:         Dictionary containing the results of the current experiment run to be
                         added to the existing average

    Return:
        Version of the 'current_average' dictionary with the contents of 'results' dictionary
        averaged to it.
        
    """
    for key, value in results.items():
        if isinstance(value, dict):
            current_average[key] = average_dict(current_average.get(key, dict()), 
                                                value, level + 1)
        else:
            current_average[key] = (current_average.get(key, value) + results[key]) / 2

    return current_average


def main(args):
    """
    Evaluates the results and stores them in JSON files.

    Parameters:
        args: Command line arguments of the program
    """
    average_results = dict()

    with open(args.resultsFile, 'r') as res_file:
        results = json.load(res_file)

        for exp_run in results:
            exp_run_results = evaluateResult(exp_run)

            # Store current results
            results_file = args.resultsFolder + '/results_' + \
                            str(exp_run['packet_length']) + '_' + \
                            str(exp_run['frame_length']) + '.json'

            with open(results_file, 'w') as res_file:
                formatted_json = json.dumps(
                    exp_run_results, sort_keys=True, indent=4)
                res_file.write(formatted_json)

            # Find and store average values
            average_results = average_dict(average_results, exp_run_results, 0)

    results_file = args.resultsFolder + '/results_average.json'

    with open(results_file, 'w') as res_file:
        formatted_json = json.dumps(average_results, sort_keys=True, indent=4)
        res_file.write(formatted_json)


##################################################################

if __name__ == '__main__':
    parser = argparse.ArgumentParser('Analyzes the simulation results')

    parser.add_argument('--resultsFile', type=str,
                        help='JSON results file to analyze')

    parser.add_argument('--resultsFolder', type=str,
                        help='Path to the results folder')

    args = parser.parse_args()
    main(args)
