library(ggplot2)
library(palmerpenguins)

p <- ggplot(data = penguins) +
  aes(x = bill_length_mm, y = bill_depth_mm)

p +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_boxplot()

p +
  geom_boxplot() +
  geom_point() +
  geom_smooth(method = "lm")

penguins |>
  dplyr::filter(!is.na(sex)) |>
  ggplot() +
  aes(x = species, y = bill_length_mm) +
  geom_boxplot(position = position_dodge(width = 0.75)) +
  geom_dotplot(
    binaxis = 'y',
    stackdir = 'center',
    method = "histodot",
    position = position_dodge(width = 0.75),
    alpha = 0.5,
    dotsize = .5
    
  ) 