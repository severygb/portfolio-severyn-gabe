library("tidyverse")
library("graphclassmate")

data(nontraditional, package = "graphclassmate")

nontrad <- nontraditional %>% 
  mutate(sex_path = str_c(sex, path, sep = " ")) %>% 
  mutate(sex_path = fct_reorder(sex_path, enrolled))

saveRDS(nontrad, "data/0305-boxplot-nontrad-data.rds")
