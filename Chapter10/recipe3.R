library(org.Hs.eg.db)
columns(org.Hs.eg.db)

keytypes(org.Hs.eg.db)

library(rbioinfcookbook)
annots <- select(org.Hs.eg.db,
                 keys = hu_gene_symbols,
                 keytype = "SYMBOL",
                 columns = c("ALIAS",
                             "GO",
                             "UNIPROT")
)

library(GO.db)

go_annots <- select(GO.db, 
                    keys=annots$GO, 
                    keytype = "GOID",
                    columns = "DEFINITION")


dplyr::left_join(annots, go_annots, by = c("GO" = "GOID"))

