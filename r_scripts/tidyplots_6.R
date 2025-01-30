# tidyplots - Use cases (1)

# Reference: https://tidyplots.org/use-cases/

# Bioinformatics

# VOLCANO PLOT #

library(tidyverse)
library(tidyplots)

# saved in datasets

# df_1 <- 
#   read_csv("https://tidyplots.org/data/differential-expression-analysis.csv") %>% 
#   mutate(
#     neg_log10_padj = -log10(padj),
#     direction = if_else(log2FoldChange > 0, "up", "down", NA),
#     candidate = abs(log2FoldChange) >= 1 & padj < 0.05
#   )

# write_csv(df_1, "C:/R_Files/tidyplots/datasets/de_analysis.csv")

df_1 = read_csv("datasets/de_analysis.csv")

df_1 %>% 
  tidyplot(x = log2FoldChange, y = neg_log10_padj) %>% 
  add_data_points(data = filter_rows(!candidate),
                  color = "lightgrey", rasterize = TRUE) %>% 
  add_data_points(data = filter_rows(candidate, direction == "up"),
                  color = "#FF7777", alpha = 0.5) %>% 
  add_data_points(data = filter_rows(candidate, direction == "down"),
                  color = "#7DA8E6", alpha = 0.5) %>% 
  add_reference_lines(x = c(-1, 1), y = -log10(0.05)) %>% 
  add_data_labels_repel(data = min_rows(padj, 6, by = direction), label = external_gene_name,
                        color = "#000000", min.segment.length = 0, background = TRUE) %>% 
  adjust_x_axis_title("$Log[2]~fold~change$") %>% 
  adjust_y_axis_title("$-Log[10]~italic(P)~adjusted$")


# PRINCIPAL COMPONENT PLOT #

library(tidyverse)
library(tidyplots)

# saved to datasets

# df_2 <- 
#   read_csv("https://tidyplots.org/data/pca-plot.csv")

# write_csv(df_2, "C:/R_Files/tidyplots/datasets/pca_plot.csv")

df_2 <- read_csv("C:/R_Files/tidyplots/datasets/pca_plot.csv")

df_2 %>% 
  tidyplot(x = pc1, y = pc2, color = group) %>% 
  add_data_points(size = 1.3, white_border = TRUE) %>% 
  adjust_x_axis_title(paste0("Component 1 (", format_number(df$pc1_var*100), "%)")) %>% 
  adjust_y_axis_title(paste0("Component 2 (", format_number(df$pc2_var*100), "%)")) %>% 
  adjust_colors(colors_discrete_apple) %>% 
  adjust_legend_title("Group")


# CORRELATION #

library(tidyverse)
library(tidyplots)

# saved to datasets

# df_3 <- 
#   read_csv("https://tidyplots.org/data/correlation-matrix.csv")

# write_csv(df_3, "C:/R_Files/tidyplots/datasets/correlation-matrix.csv")

df_3 <- read_csv("C:/R_Files/tidyplots/datasets/correlation-matrix.csv")

df_3 %>% 
  tidyplot(x = x, y = y, color = correlation) %>% 
  add_heatmap() %>% 
  sort_x_axis_labels(order_x) %>% 
  sort_y_axis_labels(order_y) %>% 
  remove_x_axis() %>% 
  remove_y_axis() %>% 
  remove_legend_title() %>% 
  adjust_legend_position("right") %>% 
  adjust_colors(colors_continuous_inferno) %>% 
  adjust_theme_details(legend.key.height = unit(1, "null")) %>% 
  add_caption("Data source: Spellman PT, et al. 1998. Mol Biol Cell 9(12): 3273-97.")


# MICROBIOME COMPOSITION #

library(tidyverse)
library(tidyplots)

# saved to datasets

# df_4 <- 
#   read_csv("https://tidyplots.org/data/microbiota.csv") %>% 
#   mutate(genus = fct_inorder(genus),
#          sample = fct_reorder(sample, top, .desc = TRUE))

# write_csv(df_4, "C:/R_Files/tidyplots/datasets/microbiota.csv")

df_4 <- read_csv("C:/R_Files/tidyplots/datasets/microbiota.csv")

df_4 %>%
  tidyplot(x = sample, y = rel_abundance, color = genus) %>%
  add_areastack_absolute(alpha = 0.6) %>%
  add_caption("Data source: Tamburini FB, et al. 2022. Nat Comm 13, 926.") %>%
  adjust_theme_details(legend.key.height = unit(3.4, "mm")) %>% 
  adjust_theme_details(legend.key.width = unit(3.4, "mm")) %>% 
  adjust_x_axis_title("Sample") %>% 
  adjust_y_axis_title("Relative abundance") %>% 
  remove_x_axis_labels() %>%
  remove_x_axis_ticks() %>%
  remove_legend_title()


# GENE EXPRESSION #

gene_expression %>% 
  tidyplot(x = sample, y = external_gene_name, color = expression) %>% 
  add_heatmap(scale = "row") %>%
  adjust_size(height = 100) %>% 
  sort_y_axis_labels(direction, -padj) %>% 
  adjust_theme_details(legend.key.height = unit(1, "null")) %>% 
  adjust_legend_title("Row Z-score") %>% 
  remove_x_axis_title() %>% 
  remove_y_axis_title()

# HYPOTHESIS TESTING #

library(tidyverse)

gene_expression %>% 
  filter(external_gene_name %in% c("Apol6", "Col5a3", "Bsn", "Fam96b", "Mrps14", "Tma7")) %>% 
  tidyplot(x = sample_type, y = expression, color = condition) %>% 
  add_violin() %>% 
  add_data_points_beeswarm(white_border = TRUE) %>% 
  adjust_x_axis_title("") %>% 
  remove_legend() %>% 
  add_test_asterisks(hide_info = TRUE, bracket.nudge.y = 0.3) %>% 
  adjust_colors(colors_discrete_ibm) %>% 
  adjust_y_axis_title("Gene expression") %>% 
  split_plot(by = external_gene_name, ncol = 2)

# READ ALIGNMENT #

library(tidyverse)
library(tidyplots)

# df_5 <- read_csv("https://tidyplots.org/data/sequencing-qc-STAR.csv")
# 
# write_csv(df_5, "C:/R_Files/tidyplots/datasets/sequencing-qc-STAR.csv")

df_5 <- read_csv("C:/R_Files/tidyplots/datasets/sequencing-qc-STAR.csv")

my_colors <- c("Uniquely mapped" = "#437bb1",
               "Mapped to multiple loci" = "#7cb5ec",
               "Mapped to too many loci" = "#f7a35c",
               "Unmapped: too short" = "#b1084c",
               "Unmapped: other" = "#7f0000")

df_5 %>%
  tidyplot(x = reads, y = sample, color = category) %>%
  add_barstack_absolute(reverse = TRUE) %>%
  theme_minimal_x() %>%
  adjust_size(70, 50) %>%
  adjust_colors(my_colors) %>%
  adjust_x_axis(title = "Number of reads", cut_short_scale = TRUE) %>%
  reorder_color_labels(names(my_colors)) %>% 
  remove_legend_title() %>% 
  remove_y_axis_title()

# READ ALIGNMENT, RELATIVE #

library(tidyverse)
library(tidyplots)

df_5 <- read_csv("C:/R_Files/tidyplots/datasets/sequencing-qc-STAR.csv")

my_colors <- c("Uniquely mapped" = "#437bb1",
               "Mapped to multiple loci" = "#7cb5ec",
               "Mapped to too many loci" = "#f7a35c",
               "Unmapped: too short" = "#b1084c",
               "Unmapped: other" = "#7f0000")

df_5 %>%
  tidyplot(x = reads, y = sample, color = category) %>%
  add_barstack_relative(reverse = TRUE) %>%
  theme_minimal_x() %>%
  adjust_size(70, 50) %>%
  adjust_colors(my_colors) %>%
  adjust_x_axis(title = "Percentage of reads", labels = scales::percent) %>% 
  reorder_color_labels(names(my_colors)) %>% 
  remove_legend_title() %>% 
  remove_y_axis_title()

# FEATURE COUNTS #

library(tidyverse)
library(tidyplots)

# df_6 <- read_csv("https://tidyplots.org/data/sequencing-qc-featureCounts.csv")

# write_csv(df_6, "C:/R_Files/tidyplots/datasets/sequencing-qc-featureCounts.csv")

df_6 <- read_csv("C:/R_Files/tidyplots/datasets/sequencing-qc-featureCounts.csv")

my_colors <- c("Assigned" = "#7cb5ec",
               "Unassigned_Ambiguity" = "#434348",
               "Unassigned_MultiMapping" = "#90ed7d",
               "Unassigned_NoFeatures" = "#f7a35c")

df_6 %>%
  tidyplot(x = reads, y = sample, color = category) %>%
  add_barstack_absolute(reverse = TRUE) %>%
  theme_minimal_x() %>%
  adjust_size(70, 50) %>%
  adjust_colors(my_colors) %>%
  adjust_x_axis(title = "Number of reads", cut_short_scale = TRUE) %>%
  reorder_color_labels(names(my_colors)) %>% 
  remove_legend_title() %>% 
  remove_y_axis_title()

# FEATURE COUNTS, RELATIVE #

library(tidyverse)
library(tidyplots)

df_6 <- read_csv("C:/R_Files/tidyplots/datasets/sequencing-qc-featureCounts.csv")

my_colors <- c("Assigned" = "#7cb5ec",
               "Unassigned_Ambiguity" = "#434348",
               "Unassigned_MultiMapping" = "#90ed7d",
               "Unassigned_NoFeatures" = "#f7a35c")

df_6 %>%
  tidyplot(x = reads, y = sample, color = category) %>%
  add_barstack_relative(reverse = TRUE) %>%
  theme_minimal_x() %>%
  adjust_size(70, 50) %>%
  adjust_colors(my_colors) %>%
  adjust_x_axis(title = "Percentage of reads", labels = scales::percent) %>% 
  reorder_color_labels(names(my_colors)) %>% 
  remove_legend_title() %>% 
  remove_y_axis_title()

