library(bio3d)

f1xwc.pdb <- fs::path_package(
  "extdata",
  "1xwc.pdb",
  package="rbioinfcookbook"
)
f3trx.pdb <- fs::path_package(
  "extdata",
  "3trx.pdb",
  package="rbioinfcookbook"
)

a <- read.pdb(f1xwc.pdb)
b <- read.pdb(f3trx.pdb)


pdbs <- pdbaln(list("1xwc"=a,"3trx"=b), fit=TRUE,exefile="msa")

env_path <- function(env, program = ""){
  
  df <- reticulate::conda_list()
  b <- df$python[which(df$name == env)]
  
  if (length(b) == 0) {
    stop("no environment with that name found")
  }
  
  file.path(dirname(b), program)
}

pymol_path <-  env_path("bioinformatics_project", "pymol")

pymol(pdbs, exefile = pymol_path, type = "launch", as="cartoon")