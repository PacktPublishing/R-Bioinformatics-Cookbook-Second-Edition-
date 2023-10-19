library(ape)
tree_file <- fs::path_package(
  "extdata",
  "mammal_tree.nwk",
  package="rbioinfcookbook"
)
newick <-read.tree(tree_file)

l <- subtrees(newick)

plot(newick)
plot(l[[4]], sub = "Node 4")

small_tree <- extract.clade(newick, 9)

new_tree <- bind.tree(newick, small_tree, 3)
plot(new_tree)