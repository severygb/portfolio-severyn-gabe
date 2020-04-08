library("tidyverse")
library("GDAdata")

speed_ski <- SpeedSki #make a copy / do not change original

speed_ski <-  speed_ski %>%
  select(Event, Sex, Speed) %>%
  as_tibble()

glimpse(speed_ski)

speed_ski <- speed_ski %>%
  rename(event = Event, sex = Sex, speed = Speed) %>%
  glimpse()

speed_ski <-  speed_ski %>%
  mutate(event = as_factor(event)) %>%
  mutate(event = fct_reorder(event, speed))

saveRDS(speed_ski, "data/0304-strip-plot-speedski-data.rds")
