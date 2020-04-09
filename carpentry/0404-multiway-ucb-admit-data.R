library(tidyverse)
data("ucb_admit", package = "graphclassmate")

college_data <- ucb_admit %>%
 glimpse()

college_data <- college_data %>%
  mutate(ratio = admitted/applied) %>%
  mutate(dept = fct_reorder(dept, ratio))

saveRDS(college_data, file = "0404-multiway-ucb-admit-data.rds")
