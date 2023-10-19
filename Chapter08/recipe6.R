library(msa)

seq_file <- fs::path_package(
  "extdata",
  "hglobin.fa",
  package="rbioinfcookbook"
)
seqs <- readAAStringSet(seq_file)

alignment <- msa(seqs, method = "ClustalOmega")

msaPrettyPrint(alignment, output="pdf", showNames="left",
               showLogo="none", verbose=FALSE, 
               file="whole_align.pdf")

msaPrettyPrint(alignment, c(10,30), 
               output="pdf", showNames="left",
               file = "zoomed_align.pdf", 
               showLogo="top", askForOverwrite=FALSE, verbose=FALSE)

alignment_seqinr <- msaConvert(alignment, type="seqinr::alignment")
distances <- seqinr::dist.alignment(alignment_seqinr, "identity")
tree <- ape::nj(distances)
plot(tree, main="Phylogenetic Tree of HBA Sequences")