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

