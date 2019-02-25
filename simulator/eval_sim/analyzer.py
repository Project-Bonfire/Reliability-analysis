import argparse
import os
import json
import pandas as pd

def main(args):
    exp_name = args.resultsFile.split('/')[-1][:-5].split('_')[1]
    results = []

    with open(args.resultsFile, 'r') as res_file:
        results = json.load(res_file)

        # router_fault_df = pd.DataFrame(columns=['frame_length', 'packet_length', 'modules', 'exp_count', 'error_in_module', 'error_in_tl', 'failure_in_tl'])

        # for i, scenario in enumerate(results):
        #     router_fault_df.loc[i] = [scenario['frame_length'], scenario['packet_length'], scenario['num_violations']]
        #     # line = str(scenario['frame_length']) + ',' +  str(scenario['packet_length']) + ',' + str(scenario['num_violations']) + '\n'
        #     # router_failure.writelines(line)

        # router_fault_df = router_fault_df.sort_values(by=['frame_length'])
        
        # packet_lenghts = router_fault_df['packet_length'].unique()

        # for pl in packet_lenghts:
        #     filtered_router_fault = router_fault_df.loc[router_fault_df['packet_length'] == pl]
        #     print(filtered_router_fault)

        #     with open(os.path.join(args.resultsFolder, 'router_failure_pl_' + str(pl) + '.csv'), 'w') as router_failure:
        #         filtered_router_fault.to_csv(router_failure, index=False)


    

if __name__ == '__main__':
    parser = argparse.ArgumentParser('Analyzes the simulation results')

    parser.add_argument('--resultsFile', type=str,
                        help='JSON results file to analyze')

    parser.add_argument('--resultsFolder', type=str,
                        help='Path to the results folder')

    args = parser.parse_args()
    main(args)
