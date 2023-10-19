library(mlr3)
library(mlr3learners)
library(mlbench)
data("BreastCancer")

selected <- BreastCancer[c("Cl.thickness", "Cell.size", "Cell.shape",
                           "Marg.adhesion", "Epith.c.size", "Bl.cromatin",
                           "Normal.nucleoli", "Mitoses", "Class"
)] 

task <- as_task_classif(selected, target="Class")
split <- partition(task, ratio=0.5)

learner <- lrn("classif.ranger", predict_type = "prob") ##install ranger
learner$train(task, row_ids = split$train)

predict(learner, selected[1:5,] )

library(iml)
cancer_x <- task$data(rows = split$train, cols = task$feature_names)
cancer_y <- task$data(rows = split$train, cols = task$target_names)
predictor <- Predictor$new(learner, data = cancer_x, y = cancer_y)

imp <- FeatureImp$new(predictor, loss="ce")
imp$plot()

library(DALEXtra)
model <- explain_mlr3(learner, 
                      data = cancer_x,
                      y = as.numeric(cancer_y$Class == "malignant"))
mod_perf <- model_performance(model)
mod_perf
plot(mod_perf, geom = "roc")