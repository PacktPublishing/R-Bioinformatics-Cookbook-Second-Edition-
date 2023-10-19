library(rbioinfcookbook)
library(palmerpenguins)
library(ggplot2)
library(ggridges)
library(gghighlight)
library(ggdist)


p1 <- ggplot(data = penguins) +
  aes(x = bill_length_mm, y = species,
      fill = factor(stat(quantile))) +
  stat_density_ridges(geom = "density_ridges_gradient",
                      calc_ecdf = TRUE,
                      quantiles = c(0.05, 0.95)) +
  scale_fill_manual(
    name = "Probability",
    values = alpha(c("goldenrod", "gray", "steelblue"), 0.5),
    labels = c("< 0.05", "0.05 to 0.95", " > 0.95 "),
    guide = guide_legend(nrow = 3, byrow = TRUE)
  ) +
  theme_ridges() +
  theme(legend.position = "bottom")

p2 <- fission_ge |>
  dplyr::mutate(
    signif = dplyr::if_else(padj < 0.05, TRUE, FALSE),
    scaled_p = -log10(padj)
  ) |>
  ggplot() +
  aes(x = log2FoldChange, y = scaled_p) +
  geom_point(aes(colour = signif)) +
  gghighlight(scaled_p > 10 ,
              label_key = id) +
  theme(legend.position = "bottom")

p3 <- ggplot(penguins) +
  aes(x = flipper_length_mm, y = island, ) +
  stat_halfeye(aes(fill = stat((x > 190 & x < 200)))) +
  geom_vline(xintercept =  c(190, 200), linetype = "dashed") +
  scale_fill_manual(values = c("gray", "steelblue"),
                    guide = guide_legend(nrow = 2, byrow = TRUE)) +
  theme_minimal() +
  theme(legend.position = "bottom")


p4 <- allele_freqs |>
  dplyr::filter(Chr == 1) |>
  ggplot() +
  aes(x = Pos, y = Allele_Freq, label = info) +
  geom_point(aes(colour = type)) +
  facet_grid(Chr ~ ., scales = "free_x", space = "free") +
  scale_colour_manual(
    values = c("steelblue", "gray", "goldenrod", "red"),
    labels = c("CDS", "NON-CDS", "NON-SYN-Coding", "CTGA")
  ) +
  theme(legend.position = "bottom")

library(cowplot)
left_column <- plot_grid( p1 + theme(legend.position = "none"),
                          p2 + theme(legend.position = "none"), 
                          p3 + theme(legend.position = "none"),
                          ncol = 1, labels = c("A", "B", "C")
)

l1 <- get_legend(p1)
l3 <- get_legend(p3)

right_column <- plot_grid(l1, NULL, l3,  ncol=1)

two_cols <- plot_grid(left_column, right_column, ncol = 2, rel_widths = c(0.66, 0.34))
labelled_4 <- plot_grid(p4, labels = "D")

plot_grid(two_cols, labelled_4, ncol = 1, rel_heights = c(0.6, 0.4)) 
