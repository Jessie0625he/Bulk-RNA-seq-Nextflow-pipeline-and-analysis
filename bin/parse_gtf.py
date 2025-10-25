#!/usr/bin/env python

import argparse

parser = argparse.ArgumentParser(description='Extract gene_id and gene_name from GTF file')
parser.add_argument('-i', dest='input', help='Input GTF file', required=True)
parser.add_argument('-o', dest='output', help='Output file', required=True)

args = parser.parse_args()

with open(args.input, 'r') as infile, open(args.output, 'w') as outfile:
    outfile.write("gene_id\tgene_name\n")
    for line in infile:
        if line.startswith('#'):
            continue
        fields = line.strip().split('\t')
        if len(fields) < 9:
            continue
        if fields[2] == 'gene':
            attr_str = fields[8].strip().strip(';')
            attributes = {}
            for attr in attr_str.split(';'):
                if attr:
                    key_value = attr.strip().split(' ', 1)
                    if len(key_value) == 2:
                        key = key_value[0]
                        value = key_value[1].strip('"')
                        attributes[key] = value
            gene_id = attributes.get('gene_id')
            gene_name = attributes.get('gene_name')
            if gene_id and gene_name:
                outfile.write(f"{gene_id}\t{gene_name}\n")