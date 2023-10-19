library(rbioinfcookbook)
genes <- count_dataframe[['gene']]
count_dataframe[['gene']] <- NULL
count_matrix <- as.matrix(count_dataframe)
rownames(count_matrix) <- genes

experiments_of_interest <- c("L1Larvae", "L2Larvae")
columns_of_interest <- which( 
  pheno_data[['stage']] %in% experiments_of_interest 
)

grouping <- pheno_data[['stage']][columns_of_interest] |>
  forcats::as_factor()

counts_of_interest <- count_matrix[,counts = columns_of_interest]

library(edgeR)
count_dge <- edgeR::DGEList(
  counts = counts_of_interest,
  group = grouping
)

design <- model.matrix(~grouping)
eset_dge <- edgeR::estimateDisp(count_dge, design)
fit <- edgeR::glmQLFit(eset_dge, design)
result <- edgeR::glmQLFTest(fit, coef=2)
topTags(result)

## From eset

head(modencodefly.eset)

experiments_of_interest <- c("L1Larvae","L2Larvae")
columns_of_interest <- which(
  phenoData(modencodefly.eset)[['stage']] %in%
    experiments_of_interest
)

grouping <- droplevels(
  phenoData(modencodefly.eset)[['stage']][columns_of_interest]
)

counts_of_interest <- exprs(modencodefly.eset)[,columns_of_interest]

eset_dge <- edgeR::DGEList(
  counts = counts_of_interest,
  group = grouping
)

design <- model.matrix(~ grouping)
eset_dge  <- edgeR::estimateDisp(eset_dge, design)
fit <- edgeR::glmQLFit(eset_dge, design)
result <- edgeR::glmQLFTest(fit ,coef=2)
topTags(result)