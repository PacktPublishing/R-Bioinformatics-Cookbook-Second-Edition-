qmd_path <- fs::path_package("extdata", "shiny.qmd", 
                             package="rbioinfcookbook")
file.copy(qmd_path, 'somewhere/on/your/system/shiny.qmd')