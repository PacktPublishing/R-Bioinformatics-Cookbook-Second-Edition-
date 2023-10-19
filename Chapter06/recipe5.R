library(RNAseqData.HNRNPC.bam.chr14)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(SGSeq)

si <- data.frame(
  sample_name = RNAseqData.HNRNPC.bam.chr14_RUNNAMES, 
  file_bam = RNAseqData.HNRNPC.bam.chr14_BAMFILES
)

si <- getBamInfo(si)

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
txdb <- keepSeqlevels(txdb, "chr14")
seqlevelsStyle(txdb) <- "NCBI"

txf_ucsc <- convertToTxFeatures(txdb)
seqlevels(txf_ucsc) <- "chr14"
sgf_ucsc <- convertToSGFeatures(txf_ucsc)

sgfc <- analyzeFeatures(si, txf_ucsc)

df <- plotFeatures(sgfc, geneID = 1)

sgvc_pred <- analyzeVariants(sgfc)

sgv <- rowRanges(sgvc_pred)
sgvc <- getSGVariantCounts(sgv, sample_info = si)
counts <- counts(sgvc)
exon_id <- variantID(sgvc)
group_id <- eventID(sgvc)

sample_info <- data.frame(
  sample = colnames(counts),
  condition = c(rep("Test", 4), rep("Control",4))
)

library(DEXSeq)
dx <- DEXSeqDataSet(
  counts,
  sample_info,
  design = ~ sample + exon + condition:exon,
  as.character(exon_id),
  as.character(group_id)
  
)

dx <- estimateSizeFactors(dx)
dx <- estimateDispersions(dx)
dx <- testForDEU(dx)
dx <- estimateExonFoldChanges(dx, fitExpToVar="condition")

results <- DEXSeqResults(dx)
