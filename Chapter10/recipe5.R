library(rbioinfcookbook)

mo_ids  <- unique(mo_go$`Gene stable ID`)

geneid2_go <- lapply(mo_ids, function(gene_id){
  df <- dplyr::filter(mo_go, `Gene stable ID` == gene_id)
  unique(df$`GO term accession`)
})

names(geneid2_go) <- mo_ids

mo_exp_path <- fs::path_package(
  "extdata",
  "mo_gexp.csv", 
  package = "rbioinfcookbook"
)
mo_exp <- readr::read_csv(mo_exp_path)

gene_list <- factor(as.integer( mo_ids %in% mo_exp$gene_id))
names(gene_list) <- mo_ids 


library(topGO)

topGO_data <- new("topGOdata",
                  ontology = "MF",
                  allGenes = gene_list,
                  nodeSize = 3, 
                  annot = annFUN.gene2GO, 
                  gene2GO = geneid2_go
)

test_result_elim <- runTest(topGO_data, algorithm = "elim", statistic = "fisher")
test_result_pc <- runTest(topGO_data, algorithm = "parentchild", statistic = "fisher")

results <- GenTable(topGO_data, 
                    elim_fisher_pval = test_result_elim, 
                    pc_fisher_pval = test_result_pc,
                    orderBy = "elim_fisher_pval", 
                    ranksOf="elim_fisher_pval",
                    topNodes = 10)

showSigOfNodes(topGO_data, score(test_result_elim), 
               firstSigNodes = 5, 
               useInfo = "all")

showSigOfNodes(topGO_data, 
               score(test_result_pc), 
               firstSigNodes = 5, 
               useInfo = "all")