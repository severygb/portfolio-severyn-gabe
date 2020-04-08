library(tidyverse)
library(graphclassmate)

explore <- museum_exhibits %>% glimpse()

explore %>% summary()
explore %>% count(exhibit)

explore <- explore %>%
  mutate(exhibit = as_factor(exhibit)) %>%
  mutate(exhibit = fct_reorder(exhibit, minutes)) %>%
  glimpse()

ggplot(explore, aes(x = minutes, y = exhibit)) +
  geom_point()
