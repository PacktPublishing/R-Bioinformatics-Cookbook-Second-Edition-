library(org.Hs.eg.db)
keytypes(org.Hs.eg.db)

k <- head(keys(org.Hs.eg.db, keytype = "ENSEMBL"), n = 3 )

result <- select(org.Hs.eg.db, keys = k, keytype="ENSEMBL", columns = c("PFAM"))
result

library(PFAM.db)
descriptions <- PFAMDE

all_ids <- mappedkeys(descriptions)

id_description_mapping <- as.data.frame(descriptions[all_ids])

dplyr::left_join(result, id_description_mapping, by = c("PFAM" = "ac") )

library(org.At.tair.db)
columns(org.At.tair.db)

library(bio3d)
seq_file <- fs::path_package("extdata",
                             "ecoli_hsp.fa",
                             package="rbioinfcookbook")

sequence <- read.fasta(seq_file)
result <- hmmer(sequence, type="hmmscan", db="pfam")
result$hit.tbl