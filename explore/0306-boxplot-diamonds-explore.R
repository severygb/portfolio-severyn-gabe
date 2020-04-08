library(tidyverse)

explore <- diamonds %>% glimpse()

summary(explore)

explore <- explore %>%
  mutate(price_per_carat = price / carat) %>%
  glimpse()

p <- ggplot(explore, aes(x = price_per_carat, y = cut)) +
  geom_boxplot()
p

p <- ggplot(explore, aes(x = price_per_carat, y = color)) +
  geom_boxplot()
p

p <- ggplot(explore, aes(x = price_per_carat, y = clarity)) +
  geom_boxplot()
p

p <- ggplot(explore, aes(x = price_per_carat, y = cut, fill = clarity)) +
  geom_boxplot()
p #there's way too much information on this one. Absolute mess.

p <- ggplot(explore, aes(x = price_per_carat, y = color, fill = clarity)) +
  geom_boxplot()
p #this is the one. Some interesting things here.

