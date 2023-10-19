set.seed(2345)
l <- list(
  a = rnorm(10, mean = 1),
  b = rnorm(10, mean = 10),
  c = rnorm(10, mean = 20)
)

library(purrr)

keep(l, function(x) mean(x) >= 10)
keep(l, ~ mean(.x) >= 10)

detect_index(l, ~ mean(.x) >= 10)

every(l, ~ mean(.x) >= 10)
some(l, ~ mean(.x) >= 10)

names <- c("ones", "tens", "twenties")
l <- set_names(l, names)

short_l <- modify(l, function(x) x[1:3])
transpose(short_l)

