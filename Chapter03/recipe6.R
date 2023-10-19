library(ggplot2)
library(plotly)
library(rbioinfcookbook)


p <- ggplot(allele_freqs) +
  aes(x = Pos, y = Allele_Freq, label = info) + 
  geom_point(aes(colour = type)) +
  facet_grid(Chr ~ ., scales = "free_x", space="free") + 
  scale_colour_manual(values = c("steelblue", "gray", "goldenrod", "red")) + 
  theme_minimal()

ggplotly(p, dynamicTicks = TRUE,
         dragmode = "zoom",
         tooltip = c("Chr", "Pos", "info")
) 