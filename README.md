# BF528 Project 2: Bulk RNA-seq Analysis Pipeline (Nextflow)

This repository contains a modular Nextflow pipeline for bulk RNA-seq analysis, developed across Weeks 1-4.  
The workflow performs quality control, reference indexing, alignment, quantification, count matrix generation, and downstream differential expression / enrichment analysis.

## Table of Contents

- Overview
- Features
- Workflow
- Repository Structure
- Requirements
- Setup
- Usage
- Configuration
- Inputs and Outputs
- Downstream Analysis
- Week-by-Week Progress
- Report Files

## Overview

A standard bulk RNA-seq workflow includes:
1. Read quality control
2. Alignment to a reference genome
3. Gene-level quantification
4. Aggregation of counts for differential expression analysis

This pipeline uses containerized processes (Singularity-compatible images from `ghcr.io/bf528`) for reproducibility and portability on BU SCC.

## Features

- Modular Nextflow design (`modules/`)
- Container-based execution per process
- FASTQ quality control with FastQC
- STAR genome indexing and alignment
- GTF parsing to map Ensembl IDs to gene symbols
- MultiQC aggregation of FastQC + STAR logs
- Gene-level quantification with VERSE
- Concatenation of sample-level counts into a single matrix
- Compatible with SCC local testing and cluster submission profiles

## Workflow

Main modules used in `main.nf`:

- `FASTQC`
- `PARSE_GTF`
- `STAR_INDEX`
- `STAR_ALIGN`
- `MULTIQC`
- `VERSE`
- `PARSE_VERSE_OUTPUT`

High-level flow:
1. Build paired-end channels from `params.reads`
2. Run FastQC on individual read files
3. Parse GTF for ID-to-gene mapping
4. Build STAR genome index
5. Align paired reads with STAR
6. Aggregate FastQC + STAR logs with MultiQC
7. Quantify alignments with VERSE
8. Merge per-sample VERSE outputs into a count matrix

## Repository Structure

```text
project-2-Jessie0625he/
├── bin/
├── modules/
├── main.nf
├── nextflow.config
├── envs/
├── results/
├── star_index/
├── Results_Analysis/
│   ├── analysis.Rmd
│   ├── PCA_plot.png
│   ├── sample_sample_distance.png
│   ├── volcano_plot.png
│   ├── fgsea.png
│   ├── enrichR.png
│   ├── enrichr_reactome_2024.png
│   ├── count_matrix.png
│   ├── vst_normalization.png
│   ├── top10genes.png
│   ├── sig_genes.txt
│   ├── pos_genes.txt
│   ├── neg_genes.txt
│   └── top10_genes.txt
├── Project2_Report_XJ_1b.ipynb
├── Project 2_Report.pdf
├── MultiQC Report.pdf
└── README.md
``` 

## Requirements

- BU SCC access
- Conda environment with Nextflow installed
- Singularity execution via Nextflow profile
- Appropriate SCC modules loaded

## Setup

```bash
module load miniconda
conda activate nextflow_latest
```
## Usage
Local/container profile test
```bash
nextflow run main.nf -profile singularity,local
```
Cluster submission (recommended for full runs)
```bash
nextflow run main.nf -profile singularity,cluster
```

## Configuration
Key parameters are defined in nextflow.config, including:

- params.reads (FASTQ glob pattern)
- params.genome (reference FASTA)
- params.gtf (reference GTF)
- results/publish paths
- process labels (process_low, process_medium, process_high)
- cluster options for SCC resource requests

## Inputs and Outputs
**Inputs**
- Paired-end FASTQ files (R1, R2) from params.reads
- Reference genome FASTA (params.genome)
- Reference annotation GTF (params.gtf)
**Outputs**
- FastQC HTML/ZIP reports
- STAR genome index directory
- STAR alignment BAM files and *.Log.final.out
- MultiQC HTML summary report
- VERSE *.exon.txt per-sample count outputs
- Combined count matrix from parsed VERSE outputs
- Gene ID ↔ gene symbol mapping file from GTF parsing
**Downstream Analysis**
Downstream RNA-seq analysis and figures are in Results_Analysis/, including:

- filtering and normalization outputs
- PCA plot
- sample-to-sample distance heatmap
- differential expression summaries
- volcano plot
- enrichment analysis (Enrichr / Reactome / FGSEA)
**Primary notebook/report files:**

- Results_Analysis/analysis.Rmd
- Project2_Report_XJ_1b.ipynb
- Project 2_Report.pdf

