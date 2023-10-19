env_path <- function(env, program = ""){
  
  df <- reticulate::conda_list()
  b <- df$python[which(df$name == env)]
  
  if (length(b) == 0) {
    stop("no environment with that name found")
  }
  
  file.path(dirname(b), program)
}
blast_path <-  env_path("bioinformatics_project")

make_blastdb <- function(fasta, blast_path) {
  system(paste0(blast_path, "makeblastdb -in ", 
                fasta,
                " -input_type fasta -dbtype prot -hash_index"
  ))
  
}

run_blast <- function(query, db, outfile, blast_path, evalue="1E-5", max_target_seqs=1000) {
  system(
    paste0(
      blast_path,
      'blastp -db ',
      db,
      ' -query ',
      query,
      ' -evalue ',
      evalue,
      ' -max_target_seqs ',
      max_target_seqs,
      ' -out ',
      outfile,
      ' -outfmt "6',
      ' qseqid sseqid pident nident length mismatch gapopen gaps positive ppos qstart qend qlen qcovs qcovhsp sstart send slen evalue bitscore score"'
    )
  )
}

sceres <- fs::path_package(
  "extdata",
  "sceres_100.fa",
  package = "rbioinfcookbook"
)

spombe <- fs::path_package(
  "extdata",
  "spombe_100.fa",
  package = "rbioinfcookbook"
)

blast_res_a <- "sp_vs_sc.csv"
make_blastdb(sceres, blast_path)
run_blast(spombe, sceres, blast_res_a, blast_path)

blast_res_b <- "sc_vs_sp.csv"
make_blastdb(spombe, blast_path)
run_blast(sceres, spombe, blast_res_b, blast_path)

parse_hits <- function(outfile){
  col_names <-
    c(
      "query_id", "subject_id",
      "perc_identity", "num_ident_matches",
      "alig_length", "mismatches",
      "gap_openings", "n_gaps",
      "pos_match", "ppos",
      "q_start", "q_end",
      "q_len", "qcov",
      "qcovhsp", "s_start",
      "s_end", "s_len",
      "evalue", "bit_score",
      "score_raw"
    )
  
  hits <-
    data.table::as.data.table(
      readr::read_delim(
        file = outfile,
        delim = "\t",
        col_names = FALSE,
        col_types = readr::cols(
          "X1" = readr::col_character(), "X2" = readr::col_character(),
          "X3" = readr::col_double(), "X4" = readr::col_integer(),
          "X5" = readr::col_integer(), "X6" = readr::col_integer(),
          "X7" = readr::col_integer(), "X8" = readr::col_integer(),
          "X9" = readr::col_integer(), "X10" = readr::col_double(),
          "X11" = readr::col_integer(), "X12" = readr::col_integer(),
          "X13" = readr::col_integer(),
          "X14" = readr::col_double(),
          "X15" = readr::col_double(),
          "X16" = readr::col_integer(),
          "X17" = readr::col_integer(),
          "X18" = readr::col_integer(),
          "X19" = readr::col_double(),
          "X20" = readr::col_number(),
          "X21" = readr::col_double()
        )
      )
    )
  
  data.table::setnames(x   = hits,
                       old = paste0("X", 1:length(col_names)),
                       new = col_names)

  filter_best_hits <- function(x) {
    
    min_val <- min(x$evalue)
    evalue <- alig_length <- NULL
    res <- dplyr::filter(x, evalue == min_val)
    if (nrow(res) > 1) {
      max_len <- max(res$alig_length)
      res <- dplyr::filter(res, alig_length == max_len)
    }
    
    if (nrow(res) > 1) 
      res <- dplyr::slice(res, 1)
    return(res)
  }
  data.table::setkeyv(hits, c("query_id", "subject_id"))
  return(hits)
}

sp_sc <- parse_hits(blast_res_a)     |> 
  dplyr::group_by(query_id) |> 
  dplyr::do(filter_best_hits(.))
sc_sp <- parse_hits(blast_res_b)    |> 
  dplyr::group_by(query_id) |> 
  dplyr::do(filter_best_hits(.))

colnames(sc_sp)[1:2] <- c("subject_id", "query_id")
rbh <- dplyr::semi_join(
  sp_sc,
  sc_sp,
  by = c("query_id", "subject_id")
)