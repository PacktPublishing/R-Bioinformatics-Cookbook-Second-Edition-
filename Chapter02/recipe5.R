library(rbioinfcookbook)
library(stringr)

ids <- str_extract(ath_seq_names, "^AT\\dG.*\\.\\d")
description <- str_split(ath_seq_names, "\\|", simplify = TRUE)[,3] |> 
  str_trim()

info <- str_split(ath_seq_names, "\\|", simplify = TRUE)[,4] |> 
  str_trim()

chr <- str_match(info, "chr(\\d):(\\d+)-(\\d+)")

strand_pos <- str_locate(info, "[FORWARD|REVERSE]")
strand <- str_sub(info, start=strand_pos, end=strand_pos+1)

lengths <- str_match(info, "LENGTH=(\\d+)$")[,2]

results <- data.frame(
  ids = ids,
  description = description,
  chromosome = as.integer(chr[,2]),
  start = as.integer(chr[,3]),
  end = as.integer(chr[,4]),
  strand = strand,
  length = as.integer(lengths)
)