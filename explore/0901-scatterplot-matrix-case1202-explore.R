# Gabe Severyn
# 5/11/2020

# load packages
library("tidyverse")
library("graphclassmate")
library("GGally")

data(case1202, package = "Sleuth2")
glimpse(case1202)

df <- case1202 %>%
  select(Sex, Senior, Age, Bsal, Sal77) %>%
  mutate(Senior = Senior/12) %>%
  mutate(Age = Age/12) %>%
  mutate(Bsal = Bsal/1000) %>%
  mutate(Sal77 = Sal77/1000) %>%
  glimpse()

#just some color assignments
my_color <- c(rcb("dark_BG"),  rcb("dark_Br"))
my_fill  <- c(rcb("light_BG"), rcb("light_Br"))
my_title <- "Sex discrimination in a bank"

ggscatmat(df, columns = 2:5, color = "Sex", alpha = 0.5) +
  geom_point(size = 1, alpha = 0.1, na.rm = TRUE)  +
  scale_color_manual(values = my_color) +
  labs(title = my_title) +
  theme(legend.position = "right",
        panel.spacing = unit(1, "mm"),  
        axis.text.x = element_text(angle = 90, hjust = 1))

# I can't figure out how to add a loess curve to each panel... 
# pm <- ggpairs(df, columns = 2:5,  
#               mapping = ggplot2::aes(color = Sex, fill = Sex), 
#               title   = my_title, 
#               legend  = 1, 
#               upper   = list(continuous = wrap("cor", size = 2.5))) +
#   theme(legend.position = "right",
#         panel.spacing = unit(1, "mm"),  
#         axis.text.x = element_text(angle = 90, hjust = 1))
# pm
#   
# # loop through each panel to edit colors
# for(i in 1:pm$nrow) {
#   for(j in 1:pm$ncol){
#     pm[i, j] <- pm[i, j] + 
#       scale_fill_manual(values  = my_fill) +
#       scale_color_manual(values = my_color)
#   }}
# 
# # index to the panels I want to edit alpha
# row_col_index <- wrapr::build_frame(
#   "row", "col" |
#     1, 1 |
#     2, 2 |
#     3, 3 |
#     4, 4 |
#     5, 5 |
#     6, 6
# )
# 
# # add alpha to the density plots on the diagonal
# for(i in 1:nrow(row_col_index)) {
#   ii <- row_col_index$row[i]
#   jj <- row_col_index$col[i]
#   
#   p <- pm[ii, jj]
#   p <- p + geom_density(alpha = 0.6)
#   
#   pm[ii, jj] <- p
# }
# pm
# 
