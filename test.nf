#!/usr/bin/env nextflow

include {PARSE_GTF} from './modules/parse_gtf'
include {STAR_INDEX} from './modules/star_index'

workflow {

    

    Channel.fromFilePairs(params.reads)
    | map {a, b -> tuple(a, b[0], b[1])}
    | view()
    // | set {align_ch}
    // fastqc_channel = align_ch.transpose()
    // fastqc_channel.view()

    // Channel.fromFilePairs(params.reads)
    // .transpose()
    // | view()

    // PARSE_GTF{params.gtf}

    // STAR_INDEX(params.genome, params.gtf)
    

}