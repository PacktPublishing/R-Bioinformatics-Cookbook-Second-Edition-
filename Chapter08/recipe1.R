env_path <- function(env, program = ""){
  
  df <- reticulate::conda_list()
  b <- df$python[which(df$name == env)]
  
  if (length(b) == 0) {
    stop("no environment with that name found")
  }
  
  file.path(dirname(b), program)
}

meme_path <-  env_path("bioinformatics_project", "meme")

library(universalmotif)
library(Biostrings)

motif_file <- fs::path_package("extdata", 
                               "simple_motif.txt", 
                               package="rbioinfcookbook")
motif <- read_matrix(motif_file)

promoter_file <- fs::path_package(
  "extdata",
  "promoters.fa",
  package = "rbioinfcookbook"
)
sequences <- readDNAStringSet(promoter_file)

motif_hits <- scan_sequences(motif, sequences = sequences)
head(motif_hits)

motif_info <- enrich_motifs(motif, 
                            sequences, 
                            shuffle.k = 3, 
                            verbose = 0, RC = TRUE)
motif_info

meme_run <- run_meme(sequences, bin = meme_path, output = "meme_out", overwrite.dir = TRUE)
motifs <- read_meme("meme_out/meme.txt")
view_motifs(motifs)