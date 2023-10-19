library(clusterProfiler)
search_kegg_organism('mgr', by='kegg_code')

library(rbioinfcookbook)
mo_gexp <- fs::path_package(
  "extdata",
  "mo_gexp.csv",
  package="rbioinfcookbook"
)

genes <- readr::read_csv(mo_gexp)

kegg_result <- enrichKEGG(gene = genes$gene_id, organism="mgr", pvalueCutoff = 0.05)
as.data.frame(kegg_result)

browseKEGG(kegg_result,"mgr00513")