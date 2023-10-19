here::i_am("R/do_sleuth.R")
abundance <- here::here("data", "sample_a", "abundance.tsv" )
df <- readr::read_csv(abundance)

here::i_am("analysis/0001_diff_exp.Rmd")

source(here::here("R", "functions.R"))
