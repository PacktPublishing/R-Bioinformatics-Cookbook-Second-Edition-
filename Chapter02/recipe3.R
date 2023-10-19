library(rbioinfcookbook)
library(tidyr)

treatments |> 
  pivot_wider(
    names_from = measurement,
    values_from = value
  )
