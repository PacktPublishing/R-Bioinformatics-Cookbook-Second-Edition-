library(rbioinfcookbook)
library(ggplot2)
library(ggforce)

allele_freqs |> 
  dplyr::filter(Chr == 1) |> 
  ggplot() +
  aes(x = Pos, y = Allele_Freq, label = info) + 
  geom_point(aes(colour = type)) +
  facet_grid(Chr ~ ., scales = "free_x", space="free") + 
  scale_colour_manual(values = c("steelblue", "gray", "goldenrod", "red")) + 
  facet_zoom(xlim = c(1000000,2000000) )

penguins |> 
  ggplot() + 
  aes(x = bill_depth_mm, y = bill_length_mm, colour = island) + 
  geom_point() +
  facet_zoom(x = island == "Dream", zoom.data = island == "Dream")