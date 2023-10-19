library(dplyr)

df <- data.frame(
  gene_id = c("gene1", "gene2", "gene3"),
  tissue1 = c(5.1, 7.3, 8.2),
  tissue2 = c(4.8, 6.1, 9.5)
)


df <- df |> mutate(log2_tissue1 = log2(tissue1),
                   log2_tissue2 = log2(tissue2))

df |> mutate_if(is.numeric, log2)
df |> mutate_at(vars(starts_with("tissue")), log2)

library(dplyr)

df <- data.frame(
  gene_id = c("gene1", "gene2", "gene3"),
  tissue1 = c(5.1, 7.3, 8.2),
  tissue2 = c(4.8, 6.1, 9.5),
  tissue3 = c(8.5, 12.5, 6.5)
)


df <- df |>
  rowwise() |>
  mutate(mean = mean(c(tissue1, tissue2, tissue3)),
         stddev = sd(c(tissue1, tissue2, tissue3)))

df <- data.frame(
  gene_id = c("gene1", "gene2", "gene3"),
  tissue1_value = c(5.1, 7.3, 8.2),
  tissue1_pvalue = c(0.01, 0.05, 0.001),
  tissue2_value = c(4.8, 6.1, 9.5),
  tissue2_pvalue = c(0.03, 0.04, 0.001)
) |>
  tidyr::nest(-gene_id, .key = "tissue")

df <-
  df |> mutate(tissue = purrr::map(tissue, ~ mutate(
    .x, value_log2 = log2(.[1]), pvalue_log2 = log2(.[2])
  )))
