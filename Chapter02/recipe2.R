library(rbioinfcookbook)
library(dplyr)
library(tidyr)

long_df <- census_df |>
  rename("0_to_4" = "under_4", "90_to_120" = "over_90") |>
  pivot_longer(
    cols = contains("_to_"),
    names_to = c("age_from", "age_to"),
    names_pattern = "(.*)_to_(.*)",
    names_transform = list("age_from" = as.integer, age.to = as.integer),
    values_to = "count"
  )