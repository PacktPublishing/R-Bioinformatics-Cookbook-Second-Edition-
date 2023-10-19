library(mlr3)
library(mlbench)
library(mlr3learners)
data("BreastCancer")

selected <- BreastCancer[c("Cl.thickness", "Cell.size", "Cell.shape",
                           "Marg.adhesion", "Epith.c.size", "Bl.cromatin",
                           "Normal.nucleoli", "Mitoses", "Class"
)] 

task <- as_task_classif(selected, target="Class")
learner <- lrn("classif.kknn") #install "kknn" package
learner$param_set$set_values(k = 4)

resamp_kcv <- rsmp("cv")
resamp_kcv$param_set$values = list(folds = 3)

result_kcv <- resample(task, learner, resamp_kcv)

measures <- msrs(c("classif.precision", "classif.specificity", "classif.sensitivity"))
result_kcv$score(measures)

pred_kcv<- result_kcv$prediction()
pred_kcv$confusion

resamp_loo <- rsmp("loo")
result_loo <- resample(task, learner, resamp_loo)
result_loo$score(measures)

result_loo$score(measures)