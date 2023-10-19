library(rbioinfcookbook)
library(dplyr)

scores <- disease_scores |> transmute(
  strain = as.factor(strain),
  replicate = as.factor(replicate),
  score = as.factor(score)
)

scores <- scores |> transmute(
  score = factor(score, levels = c("1","2","3","4"), ordered = TRUE),
  rank_score = rank(score),
  strain,replicate
)

model <- lm(rank_score ~ strain, data = scores)
library(multcomp)
summary(glht(
  model, linfct = mcp(strain = "Tukey")
))

library(rcompanion)
tabulated <- xtabs(frequency ~ treatment + side_effect, data = side_effects)

tabulated
pairwiseNominalIndependence(tabulated, method = "fdr")

library(ggplot2)
ggplot(side_effects) + 
  aes(treatment, side_effect) + 
  geom_point(aes(size = frequency))