library(rbioinfcookbook)
summary(plant_growth_two)

library(dplyr)
group_means <- plant_growth_two |>  
  group_by(group) |>  
  summarize(mean_wt = mean(weight))

group_means

difference_in_means <- group_means$mean_wt[1] - group_means$mean_wt[2] 

difference_in_means