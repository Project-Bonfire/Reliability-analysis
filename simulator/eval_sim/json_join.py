import argparse
import os
import json

def main(args):

    experiment_list = []

    # Read all experiment evaluations to memory
    with open(args.exptlstFile, 'r') as explst:
        for experiment in explst.readlines():
            exp_file = os.path.join(args.resultsDir, experiment.strip(), 'eval.json')
            with open(exp_file, 'r') as exp:
                experiment_list.append(json.load(exp))

    # Store all experiments into a single file
    with open(args.evalsFile, 'w') as evals:
        json.dump(experiment_list, evals, sort_keys=True, indent=4)



if __name__ == '__main__':
    parser = argparse.ArgumentParser('Joins togenther simulation results from multiple simulations')

    parser.add_argument('--resultsDir', type=str,
                help='Directory containing the simulation results')

    parser.add_argument('--exptlstFile', type=str,
                        help='Experiment list file')

    parser.add_argument('--evalsFile', type=str,
                    help='File where to store the evaluation results')

    args = parser.parse_args()
    main(args)
