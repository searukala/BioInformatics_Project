#!/bin/bash
# Step 1: Quality Control and Trimming

# Create directories
mkdir -p results/fastqc results/trimmed

# Run FastQC on raw data
echo "Running FastQC..."
fastqc data/*.fastq.gz -o results/fastqc/

# Run Trimmomatic (Loop through samples)
echo "Running Trimmomatic..."
for R1 in data/*_R1.fastq.gz; do
    R2=${R1/_R1.fastq.gz/_R2.fastq.gz}
    BASE=$(basename $R1 _R1.fastq.gz)
    
    trimmomatic PE -phred33 \
        $R1 $R2 \
        results/trimmed/${BASE}_1P.fq.gz results/trimmed/${BASE}_1U.fq.gz \
        results/trimmed/${BASE}_2P.fq.gz results/trimmed/${BASE}_2U.fq.gz \
        ILLUMINACLIP:adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done
