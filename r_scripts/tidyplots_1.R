# Overview of the tidyplots package

# tidyplots is an R package to generate publication-ready plots for scientific papers

# References
# 1) https://tidyplots.org/
# 2) https://tidyplots.org/use-cases/
# 3) https://jbengler.github.io/tidyplots/articles/tidyplots.html

# A) Getting Started

# Install packages

#install.packages("tidyverse")
#install.packages("tidyplots")

# Data preparation

# More formally, in tidy data: 

# 1. each variable must have its own column
# 2. each observation must have its own row and
# 3. each value must have its own cell

# Load the data

library(tidyplots)

study

View(study)

# The study dataset consists of a table with 7 columns, also called variables, 
# and 20 rows, also called observations. The study participants received 4 
# different kinds of treatment (A, B, C, or D) and a score was measured to 
# assess treatment success.

# Base plot
study %>% 
  tidyplot(x = treatment, y = score) %>% 
  add_data_points()

# ADD #

# Add points
study %>% 
  tidyplot(x = treatment, y = score) %>% 
  add_data_points()

# Add mean bar and points

study %>% 
  tidyplot(x = treatment, y = score) %>% 
  add_data_points() %>% 
  add_mean_bar(alpha = 0.4)

# Add mean dash, error bar, and points

study %>% 
  tidyplot(x = treatment, y = score) %>% 
  add_data_points() %>% 
  add_mean_dash() %>% 
  add_sem_errorbar()

# Group by dose

study %>% 
  tidyplot(x = group, y = score, color = dose) %>% 
  add_data_points() %>% 
  add_mean_dash() %>% 
  add_sem_errorbar()

# REMOVE #

study %>% 
  tidyplot(x = group, y = score, color = dose) %>% 
  add_data_points() %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  remove_legend_title() %>% 
  remove_y_axis()

# ADJUST #

# Base plot

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points() %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar()

# Adjust size (default is 50 by 50)

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points_beeswarm(shape = 1) %>%
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  adjust_size(width = 100, height = 100)

# Adjust multiple options

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points() %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  adjust_title("This is my fantastic plot title") %>%
  adjust_x_axis_title("Treatment group") %>%
  adjust_y_axis_title("Disease score") %>%
  adjust_legend_title("") %>%
  adjust_caption("Here goes the caption")

# Adjust colors

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points() %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  adjust_colors(new_colors = c("#644296","#F08533","#3B78B0", "#D1352C"))

# One can also adjust the various color schemes
# https://jbengler.github.io/tidyplots/articles/Color-schemes.html

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points() %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  adjust_colors(new_colors = colors_discrete_seaside)

# Rename, reorder, sort, and reverse

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points() %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  rename_x_axis_labels(new_names = c("A" = "This",
                                     "B" = "is",
                                     "C" = "totally",
                                     "D" = "new"))


study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points() %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  reorder_x_axis_labels("D", "C")


study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points() %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  sort_x_axis_labels()


study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points() %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  reverse_x_axis_labels()

# THEMES #

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points() %>% 
  add_sem_errorbar() %>% 
  add_mean_dash() %>% 
  theme_tidyplot()

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points() %>% 
  add_sem_errorbar() %>% 
  add_mean_dash() %>% 
  theme_ggplot2()

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points() %>% 
  add_sem_errorbar() %>% 
  add_mean_dash() %>% 
  theme_minimal_y() %>% 
  remove_x_axis_line()

# SPLIT #

study %>% 
  tidyplot(x = group, y = score, color = group) %>% 
  add_data_points() %>% 
  add_sem_errorbar() %>% 
  add_mean_dash() %>% 
  split_plot(by = dose) %>%
  save_plot("images/tidyplot_1.png")

# OUTPUT #

study %>% 
  tidyplot(x = group, y = score, color = group) %>% 
  add_data_points() %>% 
  add_sem_errorbar() %>% 
  add_mean_dash() %>% 
  save_plot("my_plot.pdf")

