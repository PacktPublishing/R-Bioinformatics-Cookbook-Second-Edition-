
devtools::install_github("danmaclean/rbioinfcookbook")

library(rbioinfcookbook)

rbioinfcookbook::function_from_branch()

devtools::install_github("danmaclean/rbioinfcookbook@example_devtools_branch")

rbioinfcookbook::function_from_branch()

rbioinfcookbook::function_from_PR()

devtools::install_github("danmaclean/rbioinfcookbook#1")

detach("package:rbioinfcookbook", unload=TRUE)

remove.packages("rbioinfcookbook")

install.packages("danmaclean/rbioinfcookbook")
