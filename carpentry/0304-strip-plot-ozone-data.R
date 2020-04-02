library(tidyverse)

ozone_data <- airquality %>% glimpse()

ozone_data <- 
  select(ozone_data, Ozone, Month)

ozone_data <- na.omit(ozone_data) %>%
  glimpse()

saveRDS(ozone_data, file = "data/0304-strip-plot-ozone-data.rds")
