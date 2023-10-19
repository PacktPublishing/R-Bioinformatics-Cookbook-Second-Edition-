library(mlr3)
library(mlbench)
library(mlr3learners)
data("BreastCancer")

selected <- BreastCancer[c("Cl.thickness", "Cell.size", "Cell.shape",
                           "Marg.adhesion", "Epith.c.size", "Bl.cromatin",
                           "Normal.nucleoli", "Mitoses", "Class"
)] 

task <- as_task_classif(selected, target="Class")
learner <- lrn("classif.log_reg")
resamp_kcv <- rsmp("cv")
resamp_kcv$param_set$values = list(folds = 3)
measure <- msr("classif.acc")

as.data.table(learner$param_set)

library(mlr3tuning)
learner$param_set$set_values(epsilon = to_tune(0, 10),
                             maxit = to_tune(1, 10) )

terminate <- trm("run_time", secs = 5)

tunit <- ti(
  task = task,
  learner = learner,
  resampling = resamp_kcv,
  measures = measure,
  terminator = terminate
)

tuner <- tnr("random_search")
tuner$optimize(tunit)
tunit$result

library(mlr3viz)
autoplot(tunit)