m <- matrix(rep(1:10, 10, replace=TRUE), nrow=10)
apply(m,1, sum)
apply(m,2, mean)
apply(m,2, function(x){max(x * 2)})

numbers <- 1:3
number_of_numbers <- function(x){rnorm(x)}
my_list <- lapply(numbers, number_of_numbers)

lapply(my_list, mean)
sapply(my_list, mean)

list_from_data_frame <- lapply(iris, mean, trim=0.1, na.rm=TRUE)
unlist(list_from_data_frame)