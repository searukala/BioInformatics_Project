#!/bin/bash
# Step 3: Quantification with featureCounts

GTF_FILE="/path/to/gencode.v44.annotation.gtf"
mkdir -p results/counts

echo "Running featureCounts..."
featureCounts -T 8 -p -t exon -g gene_id \
    -a $GTF_FILE \
    -o results/counts/gene_counts.txt \
    results/bam/*.bam
