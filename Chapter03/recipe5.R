library(ggplot2)
library(ggdist)
library(palmerpenguins)

ggplot(penguins) +
  aes(x = flipper_length_mm, y = island) +
  geom_dots(side = "bottomleft", aes(colour = island)) +
  stat_slabinterval(aes(fill = island)) +
  theme_minimal()

library(ggplot2)
library(ggdist)
library(palmerpenguins)



ggplot(penguins) +
  aes(x = flipper_length_mm, y = island,) +
  stat_halfeye(aes(fill=stat( (x > 190 & x < 200) ))) +
  geom_vline(xintercept =  c(190, 200), linetype = "dashed" ) + 
  scale_fill_manual(values = c("gray", "steelblue")) +
  theme_minimal()



ggplot(penguins) +
  aes(x = flipper_length_mm, y = island) +
  stat_gradientinterval(aes(colour=island, fill=island)) +
  theme_minimal()

