library(tidyverse)
data("ucb_admit", package = "graphclassmate")

explore <- ucb_admit
glimpse(explore)

explore <- explore %>%
  mutate(ratio = admitted/applied) %>%
  glimpse()

ggplot(explore, aes(x = ratio, y = sex)) +
  geom_point() +
  facet_wrap(vars(dept), as.table = F)

ggplot(explore, aes(x = ratio, y = dept)) +
  geom_point() +
  facet_wrap(vars(sex), as.table = F)

#not a good story
ggplot(explore, aes(x = applied, y = dept)) +
  geom_point() +
  facet_wrap(vars(sex))
