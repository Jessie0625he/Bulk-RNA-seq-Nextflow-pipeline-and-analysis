#!/usr/bin/env python

import argparse
import pandas as pd
from functools import reduce
import os

parser = argparse.ArgumentParser(description='Process verse output exon files')
parser.add_argument('-file', dest='input', help='list of exon files', required=True, type=str, nargs='+')
parser.add_argument('-o', dest='output', help='output')

args = parser.parse_args()

dfs = []

for file in args.input:
    df = pd.read_csv(file, sep="\t", header=0)
    # Use filename (without extension) as sample column name
    sample_name = os.path.splitext(os.path.basename(file))[0]
    df = df.rename(columns={'count': sample_name})
    dfs.append(df)

df_merged = reduce(lambda left, right: pd.merge(left, right, on='gene', how='outer'), dfs)

df_merged = df_merged.fillna(0)

df_merged.to_csv(args.output, sep='\t', index=False)