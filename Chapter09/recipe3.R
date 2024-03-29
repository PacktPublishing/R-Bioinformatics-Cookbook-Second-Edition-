library(ape)
library(adegraphics)
library(treespace)


file_path <- fs::path_package(
  "extdata",
  "gene_trees",
  package="rbioinfcookbook"
)

treefiles <- list.files(file_path, full.names = TRUE)
tree_list <- lapply(treefiles, read.tree)
class(tree_list) <- "multiPhylo"

comparisons <- treespace(tree_list, nf = 3)

table.image(comparisons$D, nclass=25)

plotGroves(comparisons$pco, lab.show=TRUE, lab.cex=1.5)

groves <- findGroves(comparisons, nclust = 4)
plotGroves(groves)