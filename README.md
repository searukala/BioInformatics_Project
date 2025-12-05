# BioInformatics_Project
# Identification of Differentially Expressed Genes in Type 2 Diabetes Mellitus (T2DM)

## 📌 Overview
This project analyzes RNA-Seq data from PBMC samples to identify biomarkers associated with Type 2 Diabetes. It utilizes a standard bioinformatics pipeline including quality control, alignment, quantification, and differential expression analysis.

## 📂 Repository Structure
* **`scripts/`**: Contains all processing and analysis scripts.
    * `01_qc_trim.sh`: FastQC and Trimmomatic.
    * `02_alignment.sh`: STAR alignment.
    * `03_quantification.sh`: featureCounts.
    * `04_analysis.R`: R script for DESeq2, GSEA, and visualization.
* **`environment.yml`**: Conda environment specification.
* **`ai_usage.md`**: Log of AI tools used for the project.

## 🛠️ Pipeline Steps
1.  **Quality Control:** Raw reads assessed using FastQC.
2.  **Trimming:** Adapters and low-quality bases removed using Trimmomatic.
3.  **Alignment:** Cleaned reads aligned to the hg38 reference genome using STAR.
4.  **Quantification:** Gene counts generated using featureCounts.
5.  **Analysis (R):** Differential expression performed with DESeq2; Pathway enrichment with GSEA.

## 🚀 Usage
To replicate this environment:
```bash
conda env create -f environment.yml
conda activate t2dm_genomics_env
