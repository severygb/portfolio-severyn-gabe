library(tidyverse)

explore <- airquality %>% glimpse()

explore %>% summary()

explore %>%
  arrange(Month) %>%
  glimpse()

explore <- explore %>%
  mutate(Month = as_factor(Month)) %>%
  mutate(Month = fct_reorder(Month, Ozone)) %>%
  glimpse()

#Note: some values of ozone are missing, filter them out in carpentry


ggplot(explore, aes(x = Ozone, y = Temp, color = Month)) +
  geom_point()


ggplot(explore, aes(x = Month, y = Ozone, color = Temp)) +
  geom_point()


ggplot(explore, aes(x = Month, y = Ozone)) +
  geom_jitter(width = 0.1, height = 0)

ggplot(explore, aes(x = Month, y = Ozone)) +
  geom_point(shape = 1, size = 3)
