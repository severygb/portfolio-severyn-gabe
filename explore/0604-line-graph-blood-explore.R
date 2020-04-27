library(tidyverse)
library("tsbox")

data(blood, package = "astsa")

glimpse(blood)

daily_blood <- ts_df(blood) %>% 
  glimpse()

daily_blood %<>%
  rename(test_id = id) %>%
  rename(test_result = value) %>%
  rename(observation = time) %>%
  glimpse()

daily_blood <- mutate(daily_blood, observation = year(observation))
#turn the bogus date into a sequence. year is the thing ts_df decided to use

ggplot(daily_blood, aes(x = observation, y = test_result)) +
  geom_line()+
  geom_point() +
  facet_wrap(vars(test_id), as.table = T, nrow = 3, scales = "free_y")
