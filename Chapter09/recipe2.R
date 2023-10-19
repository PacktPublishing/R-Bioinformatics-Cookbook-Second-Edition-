library(ggplot2)
library(ggtree)

tree_file <- fs::path_package(
  "extdata",
  "itol.nwk",
  package="rbioinfcookbook"
)

itol <- ape::read.tree(tree_file)


ggtree(itol)
ggtree(itol, layout="circular")

ggtree(itol) +
  coord_flip() +
  scale_x_reverse()

ggtree(itol) + 
  geom_tiplab(color="blue",
              size= 2)

ggtree(itol, layout="circular") + 
  geom_strip(13,14, color="red",
             barsize=1)

ggtree(itol, layout="unrooted") +
  geom_hilight(node = 11, fill="steelblue")

MRCA(itol, tip=c("Photorhabdus_lumenscens", "Blochmannia_floridanus"))