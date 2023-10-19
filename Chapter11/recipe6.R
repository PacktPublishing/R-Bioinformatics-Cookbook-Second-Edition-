library(palmerpenguins)
library(tidyr)
library(dplyr)
library(tibble)

penguins_filtered <- penguins |> 
  drop_na() |> 
  select(-year) |>
  mutate(ID=row_number())

penguins_scaled <- penguins_filtered |> 
  select(where(is.numeric)) |> 
  column_to_rownames("ID")  |> 
  scale()

library(Rtsne)
space <- expand.grid(perp = seq(5, 50, by = 10), dim = 1:3)

tsne <- function(p, d) {
  tsn <- Rtsne(penguins_scaled, perplexity = p, dimensions = p) 
  data.frame(
    SNE1 = tsn$Y[,1],
    SNE2 = tsn$Y[,2],
    perplexity = p,
    dimensions = d,
    species = penguins_filtered$species
  )
  
}

res <- purrr::map2(space$perp, space$dim, tsne) |> 
  purrr::list_rbind()

library(ggplot2)
ggplot(res) +
  aes(SNE1,SNE2 ) +
  geom_point(aes(colour = species)) + 
  facet_grid(perplexity ~ dimensions) + 
  theme_minimal()


library(umap)

space <- expand.grid(n_neighbours = c(5,25,50) , min_dist = c(0.01, 0.1, 0.5, 0.99))

do_umap <- function(n, m) {
  map <- umap(penguins_scaled, n_neighbours = n, min_dist = m)
  data.frame(
    UMAP1 = map$layout[,1],
    UMAP2 = map$layout[,2],
    n_neighbours = n,
    min_dist = m,
    species = penguins_filtered$species
  )
  
}

purrr::map2(space$n_neighbours, space$min_dist, do_umap) |> 
  purrr::list_rbind() |> 
  ggplot() +
  aes(UMAP1,UMAP2) +
  geom_point(aes(colour = species)) + 
  facet_grid(n_neighbours ~ min_dist) + 
  theme_minimal()