library(rtracklayer)
get_annotated_regions_from_gff <- function(file_name) {
  gff <- rtracklayer::import.gff(file_name)
  as(gff, "GRanges")
}

library(csaw)
library(rbioinfcookbook)

bam_path <- fs::path_package("extdata", 
                             "windows.bam", 
                             package="rbioinfcookbook"
)

gff_path <- fs::path_package("extdata", 
                             "genes.gff", 
                             package="rbioinfcookbook"
)

whole_genome <- csaw::windowCounts(
  bam_path,
  bin = TRUE,
  filter = 0,
  width = 500,
  param = csaw::readParam(minq = 20,
                          dedup = TRUE,
                          pe = "both")
)

colnames(whole_genome) <- c("small_data")
annotated_regions <-
  get_annotated_regions_from_gff(gff_path)

library(IRanges)
library(SummarizedExperiment)

windows_in_genes <- IRanges::overlapsAny(
  SummarizedExperiment::rowRanges(whole_genome),
  annotated_regions
)

annotated_window_counts <- whole_genome[windows_in_genes, ]

non_annotated_window_counts <- whole_genome[!windows_in_genes, ]

window_counts <- data.frame(assay(non_annotated_window_counts))
window_ranges <- data.frame(ranges(non_annotated_window_counts))
results <- cbind(window_ranges, window_counts)
results

get_annotated_regions_from_bed <- function(file_name) {
  bed <- rtracklayer::import.bed(file_name)
  as(bed, "GRanges")
}