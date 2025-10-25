#!/usr/bin/bash nextflow

process PARSE_VERSE_OUTPUT {
    label 'process_single'
    container 'ghcr.io/bf528/pandas:latest'
    publishDir params.outdir

    input:
    val(files)
    
    output:
    path('verse_summary.csv')

    script:
    """
    parse_verse_output.py -file ${files.join(' ')} -o verse_summary.csv
    """

}