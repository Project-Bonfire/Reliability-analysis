import argparse
import os
import json
import sys

def main(args):

    experiment_list = []

    # Read all experiment evaluations to memory
    with open(args.exptlstFile, 'r') as explst:
        for experiment in explst.readlines():
            exp_file = os.path.join(args.resultsDir, experiment.strip(), 'eval.json')

            try:
                with open(exp_file, 'r') as exp:
                    json_file_contents = json.load(exp)
                    experiment_list.append(json_file_contents)

            except (FileNotFoundError, PermissionError) as err:
                print('Cannot open input JSON file (%s)' % exp_file, file=sys.stderr)
                print('Error was:', err, file=sys.stderr)
                sys.exit()

            except (json.decoder.JSONDecodeError) as err:
                print('Error while decoding input JSON file (%s)' % exp_file, file=sys.stderr)
                print('Error was:', err, file=sys.stderr)
                sys.exit()
                

    # Store all experiments into a single file
    try:
        with open(args.evalsFile, 'w') as evals:
            json.dump(experiment_list, evals, sort_keys=True, indent=4)

    except (FileNotFoundError, PermissionError) as err:
        print('Cannot open output JSON file (%s)' % exp_file, file=sys.stderr)
        print('Error was:', err, file=sys.stderr)
        sys.exit()



if __name__ == '__main__':
    parser = argparse.ArgumentParser('Joins together simulation results from multiple simulations')

    parser.add_argument('--resultsDir', type=str,
                help='Directory containing the simulation results')

    parser.add_argument('--exptlstFile', type=str,
                        help='Experiment list file')

    parser.add_argument('--evalsFile', type=str,
                    help='File where to store the evaluation results')

    args = parser.parse_args()

    print("Results Dir:\t", args.resultsDir)
    print("Exptlst File:\t", args.exptlstFile)
    print("Evals File:\t", args.evalsFile)

    main(args)
