# tidyplots - Use cases (2)

# Reference: https://tidyplots.org/use-cases/

# Data Journalism

# 1 #

library(tidyverse)
library(tidyplots)

df <- 
  read_csv("https://tidyplots.org/data/sales-of-cigarettes-per-adult-per-day.csv") %>% 
  mutate(
    cigarettes = `Manufactured cigarettes sold per adult per day`,
    Entity = fct_relevel(Entity, "France", "Germany", "United States"),
    Entity = fct_rev(Entity)
  )

df %>% 
  tidyplot(x = Year, y = cigarettes, color = Entity) %>% 
  add_mean_line(linewidth = 0.5) %>% 
  add_title("Sales of cigarettes per adult per day") %>% 
  add_caption("Data source: Our World in Data") %>% 
  theme_minimal_y() %>% 
  adjust_y_axis(limits = c(0,11)) %>% 
  adjust_size(100, 50) %>% 
  adjust_colors(c(
    "France" = "#F6C54D",
    "Germany" = "#C02D45",
    "United States" = "#4DACD6"
  ), na.value = "lightgrey") %>% 
  adjust_legend_position("top") %>% 
  adjust_title(fontsize = 14) %>% 
  remove_legend_title() %>% 
  remove_y_axis_title()


# 2 #

library(tidyverse)
library(tidyplots)

df <- 
  read_csv2("https://tidyplots.org/data/countries-democracies-autocracies.csv") %>% 
  pivot_longer(ends_with("acies"), names_to = "type", values_to = "number")

df %>% 
  tidyplot(x = Year, y = number, color = type) %>% 
  add_areastack_relative() %>% 
  add_title("Countries by system of government") %>% 
  add_caption("Data source: Our World in Data") %>% 
  theme_minimal_y() %>% 
  adjust_size(100, 50) %>% 
  adjust_colors(c(
    "Closed autocracies" = "#E2514E",
    "Electoral autocracies" = "#F1B075",
    "Electoral democracies" = "#8BB7C6",
    "Liberal democracies" = "#5C95C5")) %>% 
  adjust_title(fontsize = 14) %>% 
  adjust_legend_position("top") %>% 
  adjust_theme_details(legend.key.height = unit(2, "mm")) %>% 
  adjust_theme_details(legend.key.width = unit(2, "mm")) %>% 
  adjust_y_axis(labels = scales::percent) %>% 
  remove_legend_title() %>% 
  remove_y_axis_title()

# 3 #

library(tidyverse)
library(tidyplots)

df <- 
  read_csv("https://tidyplots.org/data/electricity-generation-in-Germany.csv")

my_colors <- c("Renewable" = "#4FAE62",
               "Nuclear" = "#F6C54D",
               "Fossil" = "#CCCCCC",
               "Other" = "#888888")

df %>% 
  dplyr::filter(year %in% c(2003, 2013, 2023)) %>% 
  tidyplot(y = energy, color = energy_type) %>% 
  add_donut() %>% 
  adjust_colors(my_colors) %>%
  reorder_color_labels(names(my_colors)) %>% 
  remove_legend_title() %>% 
  split_plot(by = year, ncol = 3, widths = 35, heights = 35) &
  theme(legend.position = "bottom") &
  patchwork::plot_annotation(
    title = "Electricity generation in Germany",
    caption = "Data source: energy-charts.info",
    theme = theme(plot.title = element_text(hjust = 0.5, size = 14),
                  plot.caption = element_text(size = 6))
  )

# 4 #

library(tidyverse)
library(tidyplots)

df <- 
  read_csv("https://tidyplots.org/data/electricity-generation-in-Germany.csv")

my_colors <- c("Renewable" = "#4FAE62",
               "Nuclear" = "#F6C54D",
               "Fossil" = "#CCCCCC",
               "Other" = "#888888")

df %>% 
  tidyplot(x = year, y = energy, color = energy_type) %>% 
  add_barstack_absolute() %>% 
  add_title("Electricity generation in Germany (TWh)") %>% 
  add_caption("Data source: energy-charts.info") %>% 
  theme_minimal_y() %>% 
  adjust_size(100, 50) %>% 
  adjust_colors(my_colors) %>% 
  adjust_legend_position("top") %>% 
  adjust_title(fontsize = 14) %>% 
  adjust_x_axis_title("Year") %>% 
  remove_legend_title() %>% 
  remove_y_axis_title()

# 5 #

library(tidyverse)
library(tidyplots)

countries <- c("France", "Germany", "United States", "China", "World", "Norway")

df <- 
  read_csv("https://tidyplots.org/data/energy-use-per-person.csv") %>% 
  mutate(
    energy = `Primary energy consumption per capita (kWh/person)`
  ) %>% 
  filter(Entity %in% countries)

df %>% 
  tidyplot(x = Year, y = energy, color = Entity) %>% 
  add_mean_line(linewidth = 0.5) %>% 
  add_data_points(data = filter_rows(Year == 2023)) %>% 
  add_data_labels_repel(label = Entity, data = filter_rows(Year == 2023), background = TRUE, background_alpha = 1, nudge_x = 11, direction = "y", force_pull = 0, hjust = 0) %>% 
  add_title("Energy consumption per capita (kWh)") %>% 
  add_caption("Data source: Our World in Data") %>% 
  theme_minimal_y() %>% 
  adjust_padding(right = 0.07) %>% 
  adjust_y_axis(limits = c(0, 1.4e5), cut_short_scale = TRUE) %>% 
  adjust_size(100, 50) %>% 
  adjust_title(fontsize = 14) %>% 
  adjust_colors(colors_discrete_seaside) %>% 
  sort_color_labels() %>% 
  remove_legend() %>% 
  remove_y_axis_title()