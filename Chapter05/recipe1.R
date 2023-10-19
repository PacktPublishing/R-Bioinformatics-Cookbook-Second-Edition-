data("PlantGrowth")
summary(PlantGrowth)

model_1 <- lm(weight ~ group, data = PlantGrowth)
summary(model_1)

plot(model_1)