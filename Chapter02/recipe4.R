library(rbioinfcookbook)
library(dplyr)

x <- left_join(mo_gene_exp, mo_terms, by = c('gene_id' = 'Gene stable ID'))

y <- right_join(mo_go_acc, x, by = c( 'Gene stable ID' = 'gene_id' ) )

z <- inner_join(y, mo_go_evidence, by = c('GO term accession' = 'GO term evidence code'))

a <- right_join(x, mo_go_acc, by = c( 'gene_id' = 'Gene stable ID') )

mol_func <- filter(mo_go_evidence, `GO domain` == 'molecular_function')
cell_comp <- filter(mo_go_evidence, `GO domain` == 'cellular_component')

bind_rows(mol_func, cell_comp)

small_mol_func <- head(mol_func, 15)
small_cell_comp <- head(cell_comp, 15)
bind_cols(small_mol_func, small_cell_comp)