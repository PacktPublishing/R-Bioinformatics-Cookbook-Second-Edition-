library(kebabs)
library(Biostrings)
sequence_file <- fs::path_package(
  "extdata",
  "ecoli_proteins.fa",
  package = "rbioinfcookbook"
)
seqs <- readAAStringSet(sequence_file)

class_file <-  fs::path_package(
  "extdata",
  "ecoli_protein_classes.txt",
  package = "rbioinfcookbook"
)

classes <- readr::read_csv(class_file, col_names = TRUE)
classes <- classes$class

num_seqs <- length(seqs)
training_proportion <- 0.75
training_set_indices <- sample(1:num_seqs, training_proportion * num_seqs)
test_set_indices <- c(1:num_seqs)[-training_set_indices]


kernel <- gappyPairKernel(k=1, m=3)

model <- kbsvm(x=seqs[training_set_indices], 
               y=classes[training_set_indices], 
               kernel=kernel, 
               pkg="e1071", 
               svm="C-svc", cost=15)

predictions <- predict(model, seqs[test_set_indices])
evaluatePrediction(predictions, classes[test_set_indices], allLabels=c(1,-1) )

seq_to_test <- seqs[[1]][1:10]
prediction_profile <-getPredictionProfile(seq_to_test, kernel, featureWeights(model), modelOffset(model) )


plot(prediction_profile)