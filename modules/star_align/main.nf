#!/usr/bin/bash nextflow

process STAR_ALIGN {
    label 'process_high'
    container 'ghcr.io/bf528/star:latest'
    publishDir params.outdir

    input:
    tuple val(name), path(read1), path(read2)
    path(star_index)
    
    output:
    // val(name), emit: name
    // path("*.bam"), emit: bam
    tuple val(name), path('*.bam'), emit: bam
    // path('*.Log.final.out'), emit: log
    tuple val(name), path('*.Log.final.out'), emit: log

    script:
    """
    STAR --runThreadN $task.cpus --genomeDir $star_index --readFilesIn $read1 $read2 --readFilesCommand zcat --outFileNamePrefix $name. --outSAMtype BAM SortedByCoordinate 2> ${name}.Log.final.out
    """

}