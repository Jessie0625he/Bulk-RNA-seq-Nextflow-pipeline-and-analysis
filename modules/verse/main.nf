#!/usr/bin/bash nextflow

process VERSE {

    container 'ghcr.io/bf528/verse:latest'
    publishDir params.outdir

    input:
    path(gtf)
    tuple val(name), path(bam) 

    output:
    path("*.exon.txt")

    script:
    """
    verse -a $gtf -o $name -S $bam 
    """

    
}