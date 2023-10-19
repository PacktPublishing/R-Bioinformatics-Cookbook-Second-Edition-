model_1 <- lm(weight ~ group, data = PlantGrowth)
summary(model_1)

library(multcomp)
tested <- glht(model_1, linfct = mcp(group = "Tukey"))
summary(tested)


df <- PlantGrowth
df$group<- relevel(df$group, ref="trt2")
model_2 <- lm(weight ~ group  , data = df,)
summary(model2)