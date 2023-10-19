library(tidyr)
nested_mt <- nest(mtcars, -cyl)

library(dplyr)
library(purrr)
nested_mt_list_cols <- nested_mt |> 
  mutate(
    model = map(data, ~ lm(mpg ~ wt, data = .x))
  )

library(broom)
nested_mt_list_cols <- nested_mt_list_cols |>
  mutate(tidy_model = map(model, tidy))

simple_df <- unnest(nested_mt_list_cols, tidy_model)

