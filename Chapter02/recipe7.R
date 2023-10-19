chromosome_id <- c(1, 1, 1, 2, 2, 3, 3, 3)
gene_id <- c("A1", "A2", "A3", "B1", "B2", "C1", "C2", "C3")
strand <- c(
  "forward",
  "reverse",
  "forward",
  "forward",
  "reverse",
  "forward",
  "forward",
  "reverse"
)
length <- c(2000, 1500, 3000, 2500, 2000, 1000, 2000, 3000)
genes_df <- data.frame(chromosome_id, gene_id, strand, length)

library(dplyr)

genes_df |>
  group_by(chromosome_id) |>
  summarise(total_length = sum(length))


genes_df |>
  group_by(chromosome_id, strand) |>
  summarise(num_genes = n(),
            avg_length = mean(length))

chromosome_id <- c(1, 1, 1, 2, 2, 3, 3, 3)
gene_id <- c("A1", "A2", "A3", "B1", "B2", "C1", "C2", "C3")
strand <-
  c(
    "forward",
    "reverse",
    "forward",
    "forward",
    "reverse",
    "forward",
    "forward",
    "reverse"
  )
length <- c(2000, 1500, 3000, 2500, 2000, 1000, 2000, 3000)
genes_df <- data.frame(chromosome_id, gene_id, strand, length)

genes_df$samples <-
  list(
    data.frame(sample_id = 1:2, expression = c(2, 3)),
    data.frame(sample_id = 1:3, expression = c(3, 4, 5)),
    data.frame(sample_id = 1:2, expression = c(4, 5)),
    data.frame(sample_id = 1:3, expression = c(5, 6, 7)),
    data.frame(sample_id = 1:2, expression = c(6, 7)),
    data.frame(sample_id = 1:2, expression = c(1, 2)),
    data.frame(sample_id = 1:2, expression = c(2, 3)),
    data.frame(sample_id = 1:2, expression = c(3, 4))
  )


genes_df |>
  tidyr::unnest() |>
  group_by(chromosome_id, strand) |>
  summarise(mean_expression = mean(expression))