library(tidyverse)

diamond_data <- diamonds %>% glimpse()

diamond_data <-  diamond_data %>%
  mutate(price_per_carat = price / carat) %>%
  select(price_per_carat, color, clarity) %>%
  glimpse()

# diamond_data <-  diamond_data %>%
#   mutate(color = fct_reorder(color, desc(price_per_carat)))

saveRDS(diamond_data, file = "data/0306-boxplot-diamond-data.rds")
