library(tidyverse)
library(graphclassmate)

museum <- museum_exhibits

museum <- museum %>%
  mutate(exhibit = as_factor(exhibit)) %>%
  mutate(exhibit = fct_reorder(exhibit, minutes)) %>%
  glimpse()

saveRDS(museum, file = "data/0304-strip-plot-museum-data.rds")