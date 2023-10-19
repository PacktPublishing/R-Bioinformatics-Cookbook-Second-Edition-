library(ape)
newick_file_path <- fs::path_package(
  "extdata",
  "mammal_tree.nwk",
  package="rbioinfcookbook"
)

nexus_file_path <- fs::path_package(
  "extdata",
  "mammal_tree.nexus",
  package="rbioinfcookbook"
)

newick <-ape::read.tree(newick_file_path)
nexus <-ape::read.nexus(nexus_file_path)


library(treeio)
beast_file_path <- fs::path_package(
  "extdata",
  "beast_mcc.tree",
  package="rbioinfcookbook"
)

raxml_file_path <- fs::path_package(
  "extdata",
  "RAxML_bipartitionsBranchLabels.H3",
  package="rbioinfcookbook"
)

library(treeio)
beast <- read.beast(beast_file_path)
raxml <- read.raxml(raxml_file_path)

class(newick)
class(nexus)
class(beast)
class(raxml)

beast_phylo <- treeio::as.phylo(beast)
newick_tidytree <- treeio::as.treedata(newick)

treeio::write.beast(newick_tidytree,file = "mammal_tree.beast")
ape::write.nexus(beast_phylo, file = "beast_mcc.nexus")
