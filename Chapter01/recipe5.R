renv::init()
install.packages(c("ggplot2", "dplyr"))
renv::snapshot()

devtools::install_github("danmaclean/rbioinfcookbook@example_devtools_branch")

renv::restore()
