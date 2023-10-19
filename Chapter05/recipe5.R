library(rbioinfcookbook)
summary(compost)

interaction.plot(compost$compost, compost$supplement, compost$size,
                 xlab="Compost Type", ylab="Size", trace.label = "Supplement"
)

compost_int <- dplyr::mutate(compost,
                             compost_supp = interaction(compost, supplement)
)

model_1 <- lm(size ~ compost_supp, data=compost_int)
summary(model_1)

library(multcomp)
tested <- glht(model_1, 
               linfct = mcp(compost_supp = "Tukey")
)
summary(tested)

library(ggplot2)
ggplot(compost) +
  aes(compost, size) +
  geom_jitter(aes(colour = supplement), position=position_dodge(width=0.5))