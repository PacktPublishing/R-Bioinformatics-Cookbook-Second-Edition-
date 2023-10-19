library(readr)
filename <- fs::path_package("extdata",
                             "census_2021.csv",
                             package = "rbioinfcookbook")

col_names = c(
  c(
    "area_code",
    "country",
    "region",
    "area_name",
    "all_persons",
    "under_4"
  ),
  paste0(seq(5, 85, by = 5), "_to_", seq(9, 89, by = 5)),
  c("over_90")
)

col_types = cols(
  area_code = col_character(),
  country = col_factor(levels = c("England", "Wales")),
  region = col_factor(
    levels = c(
      "North East",
      "Yorkshire Humber",
      "East Midlands",
      "West Midlands",
      "East of England",
      "London",
      "South East",
      "South West",
      "Wales"
    ),
    ordered = TRUE
  ),
  area_name = col_character(),
  .default = col_number()
)

df <- read_csv(filename,
               skip = 8,
               col_names = col_names,
               col_types = col_types)
