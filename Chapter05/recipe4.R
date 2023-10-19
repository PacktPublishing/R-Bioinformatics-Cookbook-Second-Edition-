library(rbioinfcookbook)
summary(expression)
model_1 <- lm(Expression ~  Treatment + Replicate, data = expression)
summary(model_1)

library(multcomp)
tested <- glht(model_1, 
               linfct = mcp(Replicate = "Tukey",
                            Treatment = "Tukey"))
summary(tested)

library(ggplot2)

ggplot(expression) +
  aes(Treatment, Expression) + 
  geom_boxplot() + 
  geom_jitter(aes(colour = Replicate))