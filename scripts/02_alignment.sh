#!/bin/bash
# Step 2: STAR Alignment

GENOME_DIR="/path/to/hg38_index"
mkdir -p results/bam

echo "Running STAR Alignment..."
for R1 in results/trimmed/*_1P.fq.gz; do
    R2=${R1/_1P.fq.gz/_2P.fq.gz}
    BASE=$(basename $R1 _1P.fq.gz)

    STAR --runThreadN 8 \
         --genomeDir $GENOME_DIR \
         --readFilesIn $R1 $R2 \
         --readFilesCommand zcat \
         --outFileNamePrefix results/bam/${BASE}_ \
         --outSAMtype BAM SortedByCoordinate
done
