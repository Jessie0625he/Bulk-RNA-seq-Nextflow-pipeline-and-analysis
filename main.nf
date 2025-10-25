#!/usr/bin/env nextflow

include {FASTQC} from './modules/fastqc'
include {STAR_INDEX} from './modules/star_index'
include {STAR_ALIGN} from './modules/star_align'
include {PARSE_GTF} from './modules/parse_gtf'
include {MULTIQC} from './modules/multiqc'
include {VERSE} from './modules/verse'
include {PARSE_VERSE_OUTPUT} from './modules/parse_verse_output'

workflow {

    Channel.fromFilePairs(params.reads).map{a, b -> tuple(a, b[0], b[1])}.set{align_ch}
    Channel.fromFilePairs(params.reads).transpose().set{fastqc_ch}
    
    FASTQC(fastqc_ch)
    PARSE_GTF(params.gtf)
    STAR_INDEX(params.genome, params.gtf)

    STAR_ALIGN(align_ch, STAR_INDEX.out)

    STAR_ALIGN.out.log.map(v -> v[1]).mix(FASTQC.out.zip.map(v -> v[1]), FASTQC.out.html.map(v -> v[1])).collect().set{multiqc_ch}

    MULTIQC(multiqc_ch)

    VERSE(params.gtf, STAR_ALIGN.out.bam)

    VERSE.out.collect().set{verse_ch}

    PARSE_VERSE_OUTPUT(verse_ch)

}
