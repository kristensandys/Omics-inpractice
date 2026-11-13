# Omics-inpractice

RNA-seq analysis workflow using STARsolo for alignment and UMI counting, followed by DESeq2 for differential-expression analysis.

## Analysis directories

- STARsolo project: `/scratch/Omics_in_practice/kristens/projects/brbseq`
- Downstream analysis: `/scratch/Omics_in_practice/kristens/downstream`


## 1. Link the raw FASTQ files

```bash
mkdir -p /scratch/Omics_in_practice/kristens/projects/brbseq/fastq
cd /scratch/Omics_in_practice/kristens/projects/brbseq/fastq

ln -s /scratch/Omics_in_practice/data/BRBseq/Omics_BRBseq_MQ_UDI_1_R1.fastq.gz sample_R1.fastq.gz
ln -s /scratch/Omics_in_practice/data/BRBseq/Omics_BRBseq_MQ_UDI_1_R2.fastq.gz sample_R2.fastq.gz
```

## 2. Prepare barcode files

The STARsolo barcode whitelist is:

```text
/scratch/Omics_in_practice/kristens/projects/brbseq/barcodes.txt
```

## 3. Run STARsolo

```bash
cd /scratch/Omics_in_practice/kristens/projects/brbseq
bash scripts/run_starsolo.sh
```

## 4. Convert the count matrix

```bash
cd /scratch/Omics_in_practice/kristens/projects/brbseq
Rscript scripts/convert_matrix.R
```

The resulting table should contain raw gene-level counts matrix with genes in rows and samples in columns.

## 5. Run downstream analysis

Place the count matrix in `downstream/data/` and sample metadata in `downstream/metadata/samples.tsv`.

The metadata must contain `sample` and `condition` columns. Sample names must match the count-column names exactly.

```bash
cd /scratch/Omics_in_practice/kristens/downstream

# Count validation, library sizes, and PCA
Rscript scripts/rnaseq_analysis.R

# Selected-gene heatmaps
Rscript scripts/heatmap.R

# Differential expression and gene-symbol annotation
Rscript scripts/deseq2.R

# Volcano plot and CEBPB normalized-count plot
Rscript scripts/volcano.R
```

Run each command successfully before continuing.

## Outputs

- `results/`: saved R objects, PCA coordinates, and differential-expression tables.
- `figures/`: library-size plots, PCA, heatmaps, volcano plots, and CEBPB count plots.

The differential-expression comparison is treatment versus control. Positive log2 fold changes indicate higher expression in treatment; negative values indicate lower expression in treatment.

The volcano plot highlights genes with adjusted p-value < 0.05 and absolute shrunken log2 fold change > 1.
