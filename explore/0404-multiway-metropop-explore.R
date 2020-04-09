library("tidyverse")
library("graphclassmate")


explore <- metro_pop %>% 
  glimpse()

summary(explore$population)

explore %>%
  select(race) %>%
  unique() %>%
  arrange(race)

explore %>%
  select(county) %>%
  unique() %>%
  arrange(county)

ggplot(explore, aes(x = population, y = race)) +
  geom_point()

ggplot(explore, aes(x = population / 1000, y = race)) +
  geom_point() +
  scale_x_continuous(breaks = seq(0, 1100, 100))

#log scale to help with the extreme variation in population
ggplot(explore, aes(x = population / 1000, y = race)) +
  geom_point() +
  scale_x_continuous(trans = 'log2')
#log 2 means each gridline is double the previous