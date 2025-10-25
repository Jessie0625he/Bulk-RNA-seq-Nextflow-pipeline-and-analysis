#!/usr/bin/bash nextflow

process PARSE_GTF {
    label 'process_single'
    container 'ghcr.io/bf528/biopython:latest'
    publishDir params.outdir

    input:
    path(gtf)
    
    output:
    path('humanID_genename.txt')

    script:
    """
    parse_gtf.py -i $gtf -o humanID_genename.txt
    """

    stub:
    """
    touch humanID_genename.txt
    """
}