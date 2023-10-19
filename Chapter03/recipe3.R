library(ggplot2)
library(ggeasy)
library(palmerpenguins)


p <- penguins |>
  dplyr::filter(!is.na(sex)) |>
  ggplot() +
  aes(x = species, y = bill_length_mm) +
  geom_boxplot(aes(fill = sex),
               position = position_dodge(width = 0.75)) +
  geom_dotplot(
    aes(fill = sex),
    binaxis = 'y',
    stackdir = 'center',
    method = "histodot",
    position = position_dodge(width = 0.75),
    alpha = 0.5,
    dotsize = .5
    
  ) +
  theme_minimal()

p + 
  easy_legend_at("bottom") +
  easy_labs(title = "Palmer Island Penguin Bill Length",
            subtitle = "by species and sex",
            x = "Species", y = "length (mm)") +
  easy_remove_x_axis("title") +
  easy_x_axis_labels_size(18) +
  easy_x_axis_labels_size(18) + 
  easy_y_axis_labels_size(14) +
  easy_y_axis_title_size(14) + 
  easy_remove_legend_title() + 
  easy_plot_legend_size(14)

