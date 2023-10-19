library(ggplot2)
library(ggridges)
library(palmerpenguins)

ggplot(data = penguins) +
  aes(x = bill_length_mm,
      y = species,
      fill = species,
      color = species) +
  geom_density_ridges(
    scale = 2,
    position = "raincloud",
    alpha = 0.5,
    jittered_points = TRUE
  ) +
  theme_ridges()

ggplot(data = penguins) +
  aes(x = bill_length_mm, y = species,
      fill = stat(x)) +
  geom_density_ridges_gradient(scale = 2,
                               rel_min_height = 0.01,) +
  theme_ridges()

ggplot(data = penguins) +
  aes(x = bill_length_mm, y = species,
      fill = factor(stat(quantile))) +
  stat_density_ridges(geom = "density_ridges_gradient",
                      calc_ecdf = TRUE,
                      quantiles = c(0.05, 0.95)) +
  scale_fill_manual(
    name = "Probability",
    values = alpha(c("goldenrod", "gray", "steelblue"), 0.5),
    labels = c("< 0.05", "0.05 to 0.95", " > 0.95 ")
  ) +
  theme_ridges()