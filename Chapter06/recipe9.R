library(rbioinfcookbook)
library(SummarizedExperiment)

make_tag <- function(grange_obj) {
  paste0(
    grange_obj@seqnames,
    ":",
    grange_obj@ranges@start,
    "-",
    (grange_obj@ranges@start + grange_obj@ranges@width)
  )
}

counts <- assay(arab_infection.rse)

if ( ! is.null(names(rowRanges(arab_infection.rse))) ){
  rownames(counts) <- names(rowRanges(arab_se))
} else {
  rownames(counts) <- make_tag(rowRanges(arab_infection.rse))
}