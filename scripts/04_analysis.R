# Step 4: Differential Expression and GSEA in R

library(DESeq2)
library(ggplot2)
library(clusterProfiler)
library(org.Hs.eg.db)
library(pheatmap)

# 1. Load Data
counts_data <- read.table("results/counts/gene_counts.txt", header=TRUE, row.names=1)
# Clean column names and subset matrix
counts_matrix <- as.matrix(counts_data[,6:ncol(counts_data)])
condition <- factor(c(rep("Control", 5), rep("T2DM", 5)))
col_data <- data.frame(row.names=colnames(counts_matrix), condition=condition)

# 2. Run DESeq2
dds <- DESeqDataSetFromMatrix(countData=counts_matrix, colData=col_data, design=~condition)
dds <- DESeq(dds)
res <- results(dds, contrast=c("condition", "T2DM", "Control"))

# 3. Visualization: Volcano Plot
res_df <- as.data.frame(res)
res_df$sig <- ifelse(res_df$padj < 0.05 & abs(res_df$log2FoldChange) > 1, "Significant", "NS")

ggplot(res_df, aes(x=log2FoldChange, y=-log10(padj), color=sig)) +
  geom_point(alpha=0.6) +
  theme_minimal() +
  scale_color_manual(values=c("grey", "red")) +
  ggtitle("Volcano Plot: T2DM vs Control")

# 4. GSEA Analysis
gene_list <- res$log2FoldChange
names(gene_list) <- rownames(res)
gene_list <- sort(gene_list, decreasing = TRUE)

gse <- gseGO(geneList=gene_list, 
             Ont="BP", 
             OrgDb=org.Hs.eg.db, 
             keyType="ENSEMBL", 
             pvalueCutoff=0.05)

# Save Results
write.csv(as.data.frame(res), "results/deseq2_results.csv")
write.csv(as.data.frame(gse), "results/gsea_results.csv")
