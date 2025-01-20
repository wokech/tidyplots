# tidyplots - Color schemes

# Reference: https://jbengler.github.io/tidyplots/articles/Color-schemes.html

# Explore the default color schemes that come with tidyplots and are ready to use for plotting

# DEFAULT COLOR SCHEMES #

library(tidyplots)
colors_discrete_friendly

# Discrete color schemes are meant for categorical variables

energy %>% 
  tidyplot(year, power, color = energy_source) %>% 
  add_barstack_absolute()


energy %>% 
  tidyplot(year, power, color = energy_source) %>% 
  add_barstack_absolute() %>% 
  adjust_colors(colors_discrete_seaside)


energy %>% 
  tidyplot(year, power, color = energy_source) %>% 
  add_barstack_absolute() %>% 
  adjust_colors(colors_discrete_friendly_long)


energy %>% 
  tidyplot(year, power, color = energy_source) %>% 
  add_barstack_absolute() %>% 
  adjust_colors(colors_discrete_apple)


energy %>% 
  tidyplot(year, power, color = energy_source) %>% 
  add_barstack_absolute() %>% 
  adjust_colors(colors_discrete_ibm)


energy %>% 
  tidyplot(year, power, color = energy_source) %>% 
  add_barstack_absolute() %>% 
  adjust_colors(colors_discrete_candy)


energy %>% 
  tidyplot(year, power, color = energy_source) %>% 
  add_barstack_absolute() %>% 
  adjust_colors(colors_discrete_alger)


energy %>% 
  tidyplot(year, power, color = energy_source) %>% 
  add_barstack_absolute() %>% 
  adjust_colors(colors_discrete_rainbow)


# Continuous color schemes are meant for continuous variables

colors_continuous_viridis

climate %>% 
  tidyplot(x = month, y = year, color = max_temperature) %>% 
  add_heatmap()

climate %>% 
  tidyplot(x = month, y = year, color = max_temperature) %>% 
  add_heatmap() %>% 
  adjust_colors(new_colors = colors_continuous_inferno)

climate %>% 
  tidyplot(x = month, y = year, color = max_temperature) %>% 
  add_heatmap() %>% 
  adjust_colors(new_colors = colors_continuous_mako)

climate %>% 
  tidyplot(x = month, y = year, color = max_temperature) %>% 
  add_heatmap() %>% 
  adjust_colors(new_colors = colors_continuous_turbo)

climate %>% 
  tidyplot(x = month, y = year, color = max_temperature) %>% 
  add_heatmap() %>% 
  adjust_colors(new_colors = colors_continuous_rocket)

# Diverging color schemes are meant for continuous variables that have a 
# central point in the middle

colors_diverging_blue2red

gene_expression %>% 
  tidyplot(x = sample, y = external_gene_name, color = expression) %>% 
  add_heatmap(scale = "row") %>%
  sort_y_axis_labels(direction) %>% 
  adjust_size(height = 100)


gene_expression %>% 
  tidyplot(x = sample, y = external_gene_name, color = expression) %>% 
  add_heatmap(scale = "row") %>%
  sort_y_axis_labels(direction) %>% 
  adjust_size(height = 100) %>% 
  adjust_colors(new_colors = colors_diverging_blue2brown)


gene_expression %>% 
  tidyplot(x = sample, y = external_gene_name, color = expression) %>% 
  add_heatmap(scale = "row") %>%
  sort_y_axis_labels(direction) %>% 
  adjust_size(height = 100) %>% 
  adjust_colors(new_colors = colors_diverging_spectral)


gene_expression %>% 
  tidyplot(x = sample, y = external_gene_name, color = expression) %>% 
  add_heatmap(scale = "row") %>%
  sort_y_axis_labels(direction) %>% 
  adjust_size(height = 100) %>% 
  adjust_colors(new_colors = colors_diverging_icefire)


# CUSTOM COLOR SCHEMES #

my_colors <- 
  new_color_scheme(c("#ECA669","#E06681","#8087E2","#E2D269"),
                   name = "my_custom_color_scheme")
my_colors


energy %>% 
  tidyplot(year, power, color = energy_source) %>% 
  add_barstack_absolute() %>% 
  adjust_colors(new_colors = my_colors)


colors_discrete_metro[2]


colors_discrete_metro[2:4]


c(colors_discrete_metro, colors_discrete_seaside)


