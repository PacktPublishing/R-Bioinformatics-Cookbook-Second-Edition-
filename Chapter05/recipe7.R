library(ggplot2)
str(txhousing)
model <- lm(median ~ city + year + month, data = txhousing)

new_values <- data.frame(city = c("Abilene"), year = c(2000), month = c(2))

predict(model, newdata=new_values)

predict(model, newdata=new_values, interval = 'predict')