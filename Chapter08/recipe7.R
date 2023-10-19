library(DECIPHER)
genomes_file <- fs::path_package(
  "extdata",
  "plastid_genomes.fa",
  package = "rbioinfcookbook"
)
long_seqs <- readDNAStringSet(genomes_file)
long_seqs

Seqs2DB(long_seqs, "XStringSet", "long_db", names(long_seqs))

synteny <- FindSynteny("long_db", verbose=FALSE)
pairs(synteny)

plot(synteny)

alignment <- AlignSynteny(synteny, "long_db", verbose=FALSE)

blocks <- unlist(alignment[[1]])
writeXStringSet(blocks, "genome_blocks_out.fa")