# tidyplots - Visualizing data

# Reference: https://jbengler.github.io/tidyplots/articles/Visualizing-data.html#annotation

# Explore the visualization of different types of datasets using tidyplots

# DATA POINTS #

library(tidyplots)

animals %>% 
  tidyplot(x = weight, y = size) %>% 
  add_data_points()

animals %>% 
  tidyplot(x = weight, y = size) %>% 
  add_data_points(white_border = TRUE)

animals %>% 
  tidyplot(x = weight, y = size) %>% 
  add_data_points(alpha = 0.4)

animals %>% 
  tidyplot(x = weight, y = size) %>% 
  add_data_points(shape = 1)

study %>% 
  tidyplot(x = treatment, y = score) %>% 
  add_data_points()

study %>% 
  tidyplot(x = treatment, y = score) %>% 
  add_data_points_jitter()

study %>% 
  tidyplot(x = treatment, y = score) %>% 
  add_data_points_beeswarm()

# AMOUNTS #

spendings

spendings %>% 
  tidyplot(x = category) %>% 
  add_count_bar()

spendings %>% 
  tidyplot(y = category) %>% 
  add_count_bar()

spendings %>% 
  tidyplot(x = category) %>% 
  add_count_bar() %>% 
  adjust_x_axis(rotate_labels = TRUE)

spendings %>% 
  tidyplot(x = category, y = amount, color = category) %>% 
  add_sum_bar() %>% 
  adjust_x_axis(rotate_labels = TRUE)

spendings %>% 
  tidyplot(x = category, y = amount, color = category) %>% 
  add_sum_bar() %>% 
  adjust_x_axis(rotate_labels = TRUE) %>% 
  remove_x_axis_labels() %>% 
  remove_x_axis_title() %>% 
  remove_x_axis_ticks()

spendings %>% 
  tidyplot(x = category, y = amount, color = category) %>% 
  add_sum_bar(width = 0.03) %>% 
  add_sum_dot() %>% 
  add_sum_value(accuracy = 1) %>% 
  adjust_x_axis(rotate_labels = TRUE) %>% 
  remove_x_axis_labels() %>% 
  remove_x_axis_title() %>% 
  remove_x_axis_ticks()

# HEATMAPS #

gene_expression %>% 
  dplyr::glimpse()

gene_expression %>% 
  tidyplot(x = sample, y = external_gene_name, color = expression) %>% 
  add_heatmap()

gene_expression %>% 
  tidyplot(x = sample, y = external_gene_name, color = expression) %>% 
  add_heatmap() %>%
  adjust_size(height = 100)

gene_expression %>% 
  tidyplot(x = sample, y = external_gene_name, color = expression) %>% 
  add_heatmap(scale = "row") %>%
  adjust_size(height = 100)

gene_expression %>% 
  tidyplot(x = sample, y = external_gene_name, color = expression) %>% 
  add_heatmap(scale = "row") %>%
  adjust_size(height = 100) %>% 
  sort_y_axis_labels(direction)

# CENTRAL TENDENCY #

study %>% 
  tidyplot(x = treatment, y = score) %>% 
  add_data_points_beeswarm() %>% 
  add_mean_dash()

time_course %>% 
  tidyplot(x = day, y = score, color = treatment) %>% 
  add_mean_line() %>% 
  add_mean_dot()

time_course %>% 
  tidyplot(x = day, y = score, color = treatment) %>% 
  add_mean_line(linewidth = 1) %>% 
  add_mean_area(alpha = 0.1)

study %>% 
  tidyplot(x = treatment, y = score) %>% 
  add_mean_bar() %>% 
  add_mean_value()

study %>% 
  tidyplot(x = treatment, y = score) %>% 
  add_data_points_beeswarm(color = "grey") %>% 
  add_mean_dash(color = "orange") %>% 
  add_median_dash(color = "purple")

# DISPERSION AND UNCERTAINTY #

time_course %>% 
  tidyplot(x = day, y = score, color = treatment) %>% 
  add_mean_line() %>% 
  add_mean_dot() %>% 
  add_sem_errorbar(width = 2)

time_course %>% 
  tidyplot(x = day, y = score, color = treatment) %>% 
  add_mean_line() %>% 
  add_mean_dot() %>% 
  add_sem_ribbon()

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_violin()

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_violin(draw_quantiles = 0.5) %>% 
  add_data_points_beeswarm()

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_boxplot()

time_course %>% 
  tidyplot(x = day, y = score, color = treatment) %>% 
  add_curve_fit()

# DISTRIBUTION #

energy %>% 
  tidyplot(x = energy) %>% 
  add_histogram()

distributions %>% 
  tidyplot(x = name, y = value) %>% 
  add_violin() %>% 
  add_data_points_beeswarm()

# PROPORTION #

energy %>% 
  dplyr::glimpse()

energy %>% 
  tidyplot(color = energy_type) %>% 
  add_pie()

energy %>% 
  tidyplot(color = energy_type) %>% 
  add_donut()

energy %>% 
  tidyplot(color = energy_type) %>% 
  add_barstack_absolute()

energy %>% 
  tidyplot(x = energy_type, y = energy, color = energy_type) %>% 
  add_sum_bar() %>% 
  add_sum_value() %>% 
  sort_x_axis_labels()

energy %>% 
  tidyplot(x = year, y = energy, color = energy_type) %>% 
  add_barstack_absolute()

energy %>% 
  tidyplot(x = year, y = energy, color = energy_type) %>% 
  add_barstack_relative()

energy %>% 
  tidyplot(x = year, y = energy, color = energy_type) %>% 
  add_areastack_relative()

energy %>% 
  # downsample to 4 representative years
  dplyr::filter(year %in% c(2005, 2010, 2015, 2020)) %>% 
  # start plotting
  tidyplot(y = energy, color = energy_type) %>% 
  add_donut() %>% 
  adjust_colors(new_colors = c("Fossil" = "grey",
                               "Nuclear" = "#F6C54D",
                               "Renewable" = "#4FAE62",
                               "Other" = "#C02D45")) %>%  
  split_plot(by = year)

energy_week %>% 
  tidyplot(date, power, color = energy_source) %>% 
  add_areastack_absolute()

energy_week %>% 
  tidyplot(date, power, color = energy_source) %>% 
  add_areastack_relative()

# STATISTICAL COMPARISON #

study %>% 
  tidyplot(x = dose, y = score, color = group) %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  add_data_points() %>% 
  add_test_asterisks()

study %>% 
  tidyplot(x = dose, y = score, color = group) %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  add_data_points() %>% 
  add_test_pvalue()

study %>% 
  tidyplot(x = dose, y = score, color = group) %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  add_data_points() %>% 
  add_test_pvalue(method = "wilcoxon", p.adjust.method = "BH")

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  add_data_points() %>% 
  add_test_pvalue(ref.group = "A")

gene_expression %>% 
  # filter to one gene
  dplyr::filter(external_gene_name == "Apol6") %>% 
  # start plotting
  tidyplot(x = condition, y = expression, color = sample_type) %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  add_data_points() %>% 
  add_test_pvalue()

gene_expression %>% 
  # filter to one gene
  dplyr::filter(external_gene_name == "Nt5m") %>% 
  # start plotting
  tidyplot(x = condition, y = expression, color = sample_type) %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  add_data_points() %>% 
  add_test_pvalue(hide.ns = TRUE)

gene_expression %>% 
  # filter to one gene
  dplyr::filter(external_gene_name == "Nucb1") %>% 
  # start plotting
  tidyplot(x = condition, y = expression, color = sample_type) %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  add_data_points() %>% 
  add_test_pvalue(hide.ns = TRUE, hide_info = TRUE)

# ANNOTATION #

study %>% 
  tidyplot(x = treatment, y = score, color = treatment) %>% 
  add_mean_dash() %>% 
  add_sem_errorbar() %>% 
  add_data_points() %>% 
  add_title("Interesting study") %>% 
  add_caption("Here is some more detail how the study was performed")

animals %>% 
  tidyplot(x = weight, y = speed) %>% 
  add_data_points()

animals %>% 
  tidyplot(x = weight, y = speed) %>% 
  add_data_points() %>% 
  add_data_points(data = max_rows(weight, 1), color = "red", shape = 1, size = 2) %>% 
  add_data_points(data = max_rows(speed, 1), color = "red", shape = 1, size = 2)

animals %>% 
  tidyplot(x = weight, y = speed) %>% 
  add_data_points() %>% 
  add_data_labels(label = animal)

animals %>% 
  tidyplot(x = weight, y = speed) %>% 
  add_data_points() %>% 
  add_data_labels_repel(label = animal)

animals %>% 
  tidyplot(x = weight, y = speed) %>% 
  add_data_points() %>% 
  add_data_labels_repel(data = max_rows(weight, 3), animal) %>% 
  add_data_labels_repel(data = max_rows(speed, 3), animal)

animals %>% 
  tidyplot(x = weight, y = speed) %>% 
  add_reference_lines(x = 4000, y = c(100, 200)) %>% 
  add_data_points() %>% 
  add_data_labels_repel(data = max_rows(weight, 3), animal) %>% 
  add_data_labels_repel(data = max_rows(speed, 3), animal)

