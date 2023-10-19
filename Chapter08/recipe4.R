my_url <- "whatever_the_url_you_get_is"
library(tmhmm)
install_tmhmm(my_url)

fasta_file <- fs::path_package(
  "extdata",
  "rlk_proteins.fa",
  package = "rbioinfcookbook"
)

tmhmm_predictions <- tmhmm::predict_topology(fasta_filename)

library(pureseqtmrinstall)
install_pureseqtm()

pureseq_tm_predictions <- pureseqtmrinstall::predict_topology(fasta_filename)

install.packages("devtools")
devtools::install_github("richelbilderbeek/tmhmm")
devtools::install_github("richelbilderbeek/pureseqtmrinstall")