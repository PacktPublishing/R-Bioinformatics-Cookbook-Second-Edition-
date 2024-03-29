library(broom)
model <- lm(mpg ~ cyl + qsec, data = mtcars)
tidy(model)
augment(model)
glance(model)

t_test_result <- t.test(x = rnorm(20), y = rnorm(20) )
tidy(t_test_result)

anova_result <- aov(Petal.Length ~ Species, data = iris)
tidy(anova_result)
post_hoc <- TukeyHSD(anova_result)
tidy(post_hoc)

library(biobroom)
library(Biobase)
library(rbioinfcookbook)

tidy(modencodefly.eset, addPheno=TRUE)