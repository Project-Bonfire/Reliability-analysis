#!/usr/bin/python3
import json
import argparse

def main(args):
    exp_name = args.resultsFile.split('/')[-1][:-5].split('_')[1]
    results = []

    with open(args.resultsFile, 'r') as res_file:
        results = json.load(res_file)

        print (results)    

if __name__ == '__main__':
    parser = argparse.ArgumentParser('Analyzes the simulation results')

    parser.add_argument('--resultsFile', type=str,
                        help='JSON results file to analyze')

    parser.add_argument('--resultsFolder', type=str,
                        help='Path to the results folder')

    args = parser.parse_args()
    main(args)
