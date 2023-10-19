library(rbioinfcookbook)

means_mock <- rowMeans(arab_infection[, c("mock1", "mock2", "mock3")])
means_hrcc <- rowMeans(arab_infection[, c("hrcc1", "hrcc2", "hrcc3")])

log2fc <- log2(means_hrcc / means_mock)
prop_de <- sum(abs(log2fc) > 2) / length(log2fc)

finite_log2fc <- log2fc[is.finite(log2fc)]
plot(density(finite_log2fc))
extRemes::qqnorm(finite_log2fc)

library(powsimR)
params <- estimateParam(
  countData = arab_infection,
  Distribution = "NB",
  RNAseq = "bulk",
  Normalisation = "TMM"
)

de_opts <- Setup(
  ngenes = 1000,
  nsims = 25,
  p.DE = prop_de,
  pLFC = finite_log2fc,
  estParamRes = params
)

num_replicates <- c(3,6,12,18)

simDE <- simulateDE(de_opts,
                    DEmethod = "edgeR-LRT",
                    Normalisation = "TMM",
                    verbose = FALSE
)

evalDE <- evaluateDE(simDE,
                     alpha.type = "adjusted",
                     MTC = "BH",
                     alpha.nominal = 0.1,
                     stratify.by = "mean",
                     filter.by = "none",
                     strata.filtered = 1,
                     target.by = 'lfc',
                     delta = 0
)

plotEvalDE(evalDE,
           rate = "marginal",
           quick = FALSE,
           Annot = TRUE
)