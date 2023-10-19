
chain_df <- tibble::tibble(
  "type" = "CHAIN",
  "description" = c("example protein", "different protein"),
  "begin" = c(1,1),
  "end" = c(300, 450),
  "length" = c(300, 450),
  "accesion" =  c("AB1", "AB2"),
  "entryName" = c("protein_1", "protein_2"),
  "taxid" = c(2712, 2712),
  "order" = c(1,2)
)

domain_df <- tibble::tibble(
  "type" = "DOMAIN",
  "description" = c("dom1", "dom1", "dom2"),
  "begin" = c(100, 150, 350),
  "end" = c(200, 250, 420),
  "length" = c(100, 100, 70),
  "entryName" = c("protein_1", "protein_2", "protein_2"),
  "taxid" = c(2712,2712,2712),
  "order" = c(1,2,2)
)

library(drawProteins)
protein_df <- dplyr::bind_rows(chain_df, domain_df)

draw_canvas(protein_df) |> 
  draw_chains(protein_df) |> 
  draw_domains(protein_df, label_domains = TRUE)

draw_canvas(protein_df) |> 
  draw_chains(protein_df) |> 
  draw_domains(protein_df, label_domains = TRUE) +
  ggplot2::theme_bw(base_size = 20) +
  ggplot2::theme(panel.grid.minor=ggplot2::element_blank(),
                 panel.grid.major=ggplot2::element_blank()) +
  ggplot2::theme(axis.ticks = ggplot2::element_blank(),
                 axis.text.y = ggplot2::element_blank()) +
  ggplot2::theme(panel.border = ggplot2::element_blank())