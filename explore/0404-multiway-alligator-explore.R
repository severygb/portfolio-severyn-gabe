library(tidyverse)
data(Alligator, package = "vcdExtra")

explore <- Alligator
glimpse(explore)

explore <- explore %>%
  mutate(lake = fct_reorder(lake, count))

ggplot(explore, aes(x = count, y = lake)) +
  geom_point() +
  facet_wrap(vars(food), as.table = F)

explore2 <- explore %>%
  mutate(size_sex = str_c(size, sex, sep = " ")) %>%
  mutate(size_sex = fct_reorder(size_sex, count))

ggplot(explore2, aes(x = count, y = food)) +
  geom_point() +
  facet_wrap(vars(size_sex))
