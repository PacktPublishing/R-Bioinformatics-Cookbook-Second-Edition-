library(mlr3pipelines)
scale <- po("scale")
pca <- po("pca")

library(magrittr)
pipel <- scale %>>%
  pca

pipel$plot()

library(mlr3learners) 

learner = lrn("classif.kknn")
learner$param_set$set_values(k = 4)
pipel <- pipel %>>%
  po("learner", learner = learner)
pipel$plot()

p_learner <- as_learner(pipel)

library(mlbench)
data("BreastCancer")

selected <- BreastCancer[c("Cl.thickness", "Cell.size", "Cell.shape",
                           "Marg.adhesion", "Epith.c.size", "Bl.cromatin",
                           "Normal.nucleoli", "Mitoses", "Class"
)] 

task <- as_task_classif(selected, target="Class")

resamp_kcv <- rsmp("cv")
resamp_kcv$param_set$values = list(folds = 3)

result_kcv <- resample(task, p_learner, resamp_kcv)
measures <- msrs(c("classif.precision", "classif.specificity", "classif.sensitivity"))
result_kcv$score(measures)