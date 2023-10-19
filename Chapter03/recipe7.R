library(rbioinfcookbook)
library(ggplot2)
library(ggrepel)

set.seed(44)

fission_ge |>
  dplyr::mutate(
    signif = dplyr::if_else(padj < 0.05, TRUE, FALSE),
    scaled_p = -log10(padj)
  ) |>
  ggplot() +
  geom_text_repel(aes(x = log2FoldChange, y = scaled_p, label = id), 
                  max.time = 60,
                  point.padding = NA,
                  arrow = arrow(
                    length = unit(0.03, "npc"),
                    type = "closed",
                    ends = "last",
                    angle = 15
                  ),
                  force = 10,
                  xlim  = c(NA, NA)
  ) +
  geom_point(aes(x = log2FoldChange, y = scaled_p, colour = signif)) +
  theme_minimal()