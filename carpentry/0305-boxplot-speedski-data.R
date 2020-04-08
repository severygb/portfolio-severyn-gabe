library("tidyverse")
library("graphclassmate")

speed_ski <- readRDS("data/0304-strip-plot-speedski-data.rds") %>%
  glimpse()

summary(speed_ski)

speed_ski <- speed_ski %>% 
  mutate(event_sex = str_c(event, sex, sep = " ")) %>% 
  mutate(event_sex = fct_reorder(event_sex, speed))

saveRDS(speed_ski, file = "data/0305-boxplot-speedski-data.rds")