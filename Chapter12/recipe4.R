library(purrr)
df <- data.frame(
  small_nums = 1:3, 
  big_nums = c(100, 200, 300)
)

means <- map(df, mean, na.rm=TRUE)

norm <- map2(df, means, function(o, m){o / m} )

result <- pmap(list(df, means, norm), function(o, m, n){
  data.frame(original_value = o,
             means = m,
             normalised = n)
} )

map_dbl(df, mean)
map_chr(df, mean)
map_lgl(df, mean)

map_dfc(df, log)
walk_result <- walk(df, print,)