library(mlr3)
library(mlr3viz)
library(mlbench)
data("BreastCancer")

selected <- BreastCancer[c("Cl.thickness", "Cell.size", "Cell.shape",
                           "Marg.adhesion", "Epith.c.size", "Bl.cromatin",
                           "Normal.nucleoli", "Mitoses", "Class"
)] 

task <- as_task_classif(selected, target="Class")
autoplot(task)

library(mlr3learners)
learner <- lrn("classif.kknn") #install "kknn" package
learner

learner$param_set$set_values(k = 4)
learner

split <- partition(task, ratio=0.8)

learner$train(task, split$train)
learner$model

predictions <- learner$predict(task, split$test)
predictions
autoplot(predictions)

measures <- msrs(c("classif.precision", "classif.specificity", "classif.sensitivity"))
predictions$score(measures)