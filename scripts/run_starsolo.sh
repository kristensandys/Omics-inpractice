set -euo pipefail

cd /scratch/Omics_in_practice/kristens/projects/brbseq

STAR_BIN=/scratch/Omics_in_practice/kristens/software/STAR-2.7.9a/bin/Linux_x86_64_static/STAR
GENOME_DIR=/scratch/Omics_in_practice/genomes/GRCh38/index/star

"$STAR_BIN" \
  --runMode alignReads \
  --outSAMmapqUnique 60 \
  --runThreadN 8 \
  --outSAMunmapped Within \
  --soloStrand Forward \
  --quantMode GeneCounts \
  --outBAMsortingThreadN 8 \
  --genomeDir "$GENOME_DIR" \
  --soloType CB_UMI_Simple \
  --soloCBstart 1 \
  --soloCBlen 14 \
  --soloUMIstart 15 \
  --soloUMIlen 14 \
  --soloUMIdedup NoDedup 1MM_Directional \
  --soloCellFilter None \
  --soloCBwhitelist barcodes.txt \
  --soloBarcodeReadLength 0 \
  --soloFeatures Gene \
  --outSAMattributes NH HI nM AS CR UR CB UB GX GN sS sQ sM \
  --outFilterMultimapNmax 1 \
  --readFilesCommand zcat \
  --outSAMtype BAM SortedByCoordinate \
  --outFileNamePrefix results/starsolo/ \
  --readFilesIn fastq/sample_R2.fastq.gz fastq/sample_R1.fastq.gz

