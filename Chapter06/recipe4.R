data.frame(
  sample = c(paste0("WT_mock_", 1:3), paste0("WT_infect_", 1:3), paste0("MUT_mock_", 1:3), paste0("MUT_infect_", 1:3)),
  condition = c(rep("WT", 6), rep("MUT", 6)),
  treatment = c(rep("mock", 3), rep("infect", 3), rep("mock",3), rep("infect",3)),
  path = paste0(c(paste0("WT_mock_", 1:3), paste0("WT_infect", 1:3), paste0("MUT_mock", 1:3), paste0("MUT_infect", 1:3)), "_kallisto_results")
)

custom_filter <- function(design,
                          row,
                          min_reads = 5,
                          min_prop = 0.47) {
  sum(apply(design, 2, function(x) {
    y <- as.factor(x)
    return(max(tapply(row, y, function(f) {
      sum(f >= min_reads)
    }) /
      tapply(row, y, length)) == 1
    || basic_filter(row, min_reads, min_prop))
  })) > 0
}

so <- sleuth_prep(s2c, ~treatment*condition, 
                  filter_fun=function(x){custom_filter(so$design,x)})
