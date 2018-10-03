import argparse
import gzip

import pickle
from typing import List

from evaluation_tools.Evaluator import Result
from evaluation_tools.Evaluator import Faulttype

parser = argparse.ArgumentParser(description='Evaluation the result of a Reliability-analysis simulation.')
parser.add_argument('infile', type=str, help='The inputfile to read, either a `.results` file or a `results.gz`.')
args = parser.parse_args()

filename = args.infile

results: List[Result] = pickle.load(gzip.open(args.infile, 'rb'))

filtered: List[Result]=[r for r in results if r.hasError(Faulttype.FAILEDDELIVERY) and r.getFaultModuleFromParam() == 'xbar']
for result in filtered:
    print(result.params)
    print(result.faultinfo)
    print("------------------")

