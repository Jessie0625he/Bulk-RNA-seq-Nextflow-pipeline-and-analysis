


```
conda activate nextflow_latest

chmod +x bin/parse_gtf.py

STAR --genomeDir star_index --runMode genomeGenerate --genomeFastaFiles project-2-rnaseq/refs/GRCh38.primary_assembly.genome.fa --sjdbGTFfile project-2-rnaseq/refs/gencode.v45.primary_assembly.annotation.gtf

STAR --genomeDir work/47/f46186590143f0582eda3625a39625/star_index --readFilesIn project-2-rnaseq/subsampled_files/control_rep3_R1.subset.fastq.gz project-2-rnaseq/subsampled_files/control_rep3_R2.subset.fastq.gz --readFilesCommand zcat --outFileNamePrefix control_rep3. --outSAMtype BAM 2> control_rep3.Log.final.out






```





