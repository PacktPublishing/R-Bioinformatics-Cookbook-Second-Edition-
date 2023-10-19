library(rbioinfcookbook)
genes <- count_dataframe[['gene']]
count_dataframe[['gene']] <- NULL
count_matrix <- as.matrix(count_dataframe)
rownames(count_matrix) <- genes

experiments_of_interest <- c("L1Larvae", "L2Larvae")
columns_of_interest <- which(
  pheno_data[['stage']] %in%
    experiments_of_interest
)

stages <- pheno_data[['stage']][columns_of_interest] |>
  forcats::as_factor()
grouping <- data.frame(
  stage = stages
)

counts_of_interest <- count_matrix[,columns_of_interest]

library(DESeq2)
dds <- DESeqDataSetFromMatrix(
  countData = counts_of_interest,
  colData = grouping,
  design = ~ stage
)

dds <- DESeq(dds)

res <- results(dds, 
               contrast=c("stage", "L2Larvae", "L1Larvae")
)
res

## from eset

library(SummarizedExperiment)
summ_exp <- makeSummarizedExperimentFromExpressionSet(modencodefly.eset)
ddsSE <- DESeqDataSet(summ_exp, design = ~ stage)

ddsSE <- DESeq(ddsSE)
resSE <- results(ddsSE, contrast=
                   c("stage", "L2Larvae", "L1Larvae"))
resSE