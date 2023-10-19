library(rbioinfcookbook)


term2gene <- data.frame(
  term = mo_go$`GO term accession`,
  gene = mo_go$`Gene stable ID`
)

term2name <- data.frame(
  term = mo_go$`GO term accession`,
  name = mo_go$`GO term name`
)

all_genes <- unique(mo_go$`Gene stable ID`)


mo_exp_path <- fs::path_package(
  "extdata",
  "mo_gexp.csv", 
  package = "rbioinfcookbook"
)

mo_exp <- readr::read_csv(mo_exp_path)

library(clusterProfiler)
enrich_info <- enricher(mo_exp$gene_id,
                        universe = all_genes,
                        TERM2GENE = term2gene,
                        TERM2NAME = term2name)

result_table <- as.data.frame(enrich_info)

dotplot(enrich_info)

enricher_to_david <- function(enrich,terms){
  comma_sep_genes = gsub("/", ", ", enrich@result$geneID)
  
  terms <- dplyr::mutate(terms,
                         short_category = dplyr::if_else(`GO domain` == 'biological_process', "BP",
                                                         dplyr::if_else(`GO domain` == "molecular_function", "MF", "CC"))
  )
  
  id_to_category <- terms$short_category
  names(id_to_category) <- terms$`GO term accession`
  fixed_category <- id_to_category[enrich@result$ID]
  
  data.frame(
    category = fixed_category,
    ID = enrich@result$ID,
    term = enrich@result$Description,
    genes = comma_sep_genes,
    adj_pval = enrich@result$p.adjust
  )
  
  
}

david <- enricher_to_david(enrich_info, mo_go)


library(GOplot)
expr_info <- data.frame(
  ID = mo_exp$gene_id,
  logFC = mo_exp$log2.fc
)
circ <- circle_dat(david, expr_info)

circ <- circ |> dplyr::mutate(term = substr(term, 1, 20))

GOBubble(circ, labels = 10, display='single', table.legend = TRUE, ID=TRUE) +
  ggplot2::ylim(0, 330)
