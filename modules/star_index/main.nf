#!/usr/bin/bash nextflow

process STAR_INDEX {
    label 'process_high'
    container 'ghcr.io/bf528/star:latest'
    publishDir params.outdir

    input:
    path(genome)
    path(gtf)
    
    output:
    path "star_index"

    script:
    """
    mkdir star_index
    STAR --runThreadN $task.cpus --runMode genomeGenerate --genomeDir star_index --genomeFastaFiles $genome --sjdbGTFfile $gtf 
    """

}