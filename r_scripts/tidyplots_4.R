# tidyplots - Advanced plotting

# Reference: https://jbengler.github.io/tidyplots/articles/Advanced-plotting.html

# Explore advanced plotting techniques offered in tidyplots

# RASTERIZATION #

library(tidyplots)

gene_expression %>%
  tidyplot(x = sample, y = external_gene_name, color = expression) %>%
  add_heatmap(scale = "row", rasterize = TRUE, rasterize_dpi = 30) %>%
  adjust_size(height = 100)

study %>%
  tidyplot(x = treatment, y = score, color = treatment) %>%
  add_data_points(rasterize = TRUE, rasterize_dpi = 50)

# CUSTOM STYLING #

my_style <- 
  . %>% 
  adjust_colors(colors_continuous_bluepinkyellow) %>% 
  adjust_font(family = "mono", face = "bold") %>% 
  remove_x_axis_ticks() %>% 
  remove_y_axis_ticks()

study %>% 
  tidyplot(group, score, color = treatment) %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  add_data_points_beeswarm() %>% 
  my_style()

energy_week %>% 
  tidyplot(date, power, color = energy_source) %>% 
  add_areastack_relative() %>% 
  my_style()

# DATA SUBSETTING #

animals %>%
  tidyplot(x = weight, y = size) %>%
  add_data_points() %>% 
  add_data_points(data = filter_rows(size > 300), color = "red")

animals %>%
  tidyplot(x = weight, y = size) %>%
  add_data_points() %>% 
  add_data_points(data = filter_rows(size > 300), color = "red") %>% 
  add_data_labels_repel(data = max_rows(weight, n = 3), label = animal, color = "black")

animals %>% 
  tidyplot(x = weight, y = size) %>% 
  add_data_points() %>% 
  add_data_points(data = max_rows(weight, n = 3), color = "red", shape = 1, size = 3)

animals %>% 
  tidyplot(x = weight, y = size) %>% 
  add_data_points(rasterize = TRUE, rasterize_dpi = 50) %>% 
  add_data_points(data = max_rows(weight, n = 3), color = "red", shape = 1, size = 3)

# PLOTTING PIPELINES #

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_mean_dash() %>% 
  #save_plot(filename = "stage_1.pdf") %>%
  add_sem_errorbar() %>% 
  #save_plot(filename = "stage_2.pdf") %>% 
  add_data_points_beeswarm() %>% 
  #save_plot(filename = "stage_3.pdf")

gene_expression %>% 
  tidyplot(x = condition, y = expression, color = sample_type) %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  add_data_points_beeswarm() %>% 
  view_plot(data = filter_rows(external_gene_name == "Apol6"), title = "Apol6") %>% 
  view_plot(data = filter_rows(external_gene_name == "Bsn"), title = "Bsn")

# PAIRED DATA #

study %>% 
  tidyplot(x = treatment, y = score, color = group) %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  add_line(group = participant, color = "grey") %>% 
  add_data_points()

study %>%
  tidyplot(x = treatment, y = score, color = group) %>%
  add_mean_dash() %>% 
  add_sem_errorbar() %>%
  add_data_points() %>%
  add_line(group = participant, color = "grey") %>%
  reorder_x_axis_labels("A", "C")

# MISSING DATA #

animals %>%
  tidyplot(x = number_of_legs, color = family) %>%
  add_barstack_absolute()

animals %>%
  tidyplot(x = number_of_legs, color = family) %>%
  add_areastack_absolute()

animals %>%
  tidyplot(x = number_of_legs, color = family) %>%
  add_areastack_absolute(replace_na = TRUE)

# MULTIPLOT LAYOUTS #

gene_expression %>% 
  # filter down to 4 genes for demonstration
  dplyr::filter(external_gene_name %in% c("Apol6","Bsn","Vgf","Mpc2")) %>% 
  # start plotting
  tidyplot(x = condition, y = expression, color = sample_type) %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  add_data_points_beeswarm() %>% 
  add_test_asterisks(hide_info = TRUE) %>% 
  split_plot(by = external_gene_name, ncol = 2, nrow = 2)


gene_expression %>% 
  tidyplot(x = condition, y = expression, color = sample_type) %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  add_data_points_beeswarm() %>% 
  add_test_asterisks(hide_info = TRUE) %>% 
  split_plot(by = external_gene_name, ncol = 3, nrow = 3) %>% 
  save_plot("test.pdf")


# ORIENTATION #

animals %>% 
  tidyplot(x = diet, y = weight) %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar()

# Switch x and y

animals %>% 
  tidyplot(x = weight, y = diet) %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar()

time_course %>% 
  tidyplot(x = score, y = day) %>% 
  add_curve_fit(orientation = "x") %>% 
  add_title("orientation = x")

time_course %>% 
  tidyplot(x = score, y = day) %>% 
  add_curve_fit(orientation = "y") %>% 
  add_title("orientation = y")


# PADDING #

animals %>% 
  tidyplot(x = weight, y = speed) %>% 
  add_data_points()


animals %>% 
  tidyplot(x = weight, y = speed) %>% 
  add_data_points() %>% 
  adjust_padding(top = 0.2, right = 0.2, bottom = 0.2, left = 0.2)


animals %>% 
  tidyplot(x = weight, y = speed) %>% 
  add_data_points() %>% 
  remove_padding()


study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  add_data_points()


study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  add_data_points() %>% 
  adjust_padding(bottom = 0.05)


# DODGING #


study %>% 
  tidyplot(x = group, y = score, color = dose) %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  add_data_points()


study %>% 
  tidyplot(x = group, y = score, color = dose, dodge_width = 0.4) %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  add_data_points()


study %>% 
  tidyplot(x = group, y = score, color = dose, dodge_width = 0) %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  add_data_points()


time_course %>% 
  tidyplot(x = day, y = score, color = treatment) %>% 
  add_mean_line() %>% 
  add_mean_dot()


# COLORING #


study %>% 
  tidyplot(x = group, y = score, color = dose) %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  add_data_points()


study %>% 
  tidyplot(x = group, y = score, color = dose) %>% 
  add_boxplot(fill = NA)


study %>% 
  tidyplot(x = group, y = score, color = dose) %>% 
  add_boxplot(color = "black")


study %>% 
  tidyplot(x = group, y = score, color = dose) %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_mean_value(color = "black")


# ALPHA VERSUS SATURATION #

study %>% 
  tidyplot(x = group, y = score, color = dose) %>% 
  add_mean_bar() %>% 
  theme_minimal_y()

study %>% 
  tidyplot(x = group, y = score, color = dose) %>% 
  add_mean_bar(alpha = 0.6) %>% 
  theme_minimal_y()

study %>% 
  tidyplot(x = group, y = score, color = dose) %>% 
  add_mean_bar(saturation = 0.2) %>% 
  theme_minimal_y()


# SPECIAL CHARACTERS #

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_data_points() %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add_sem_errorbar() %>% 
  adjust_title("$H[2]*O$") %>% 
  adjust_x_axis_title("$E==m*c^{2}$") %>% 
  adjust_y_axis_title("$TNF*alpha~level$")

# GGPLOT2 COMPATIBILITY #

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_mean_bar(alpha = 0.4) %>% 
  add(ggplot2::geom_point())


