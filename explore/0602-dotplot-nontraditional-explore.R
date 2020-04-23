library(tidyverse)
library(graphclassmate)
library(seplyr)

data("nontraditional", package = "graphclassmate")

df <- nontraditional %>%
  glimpse()

grouping_variables <- c("sex", "race", "path")  
df <- group_summarise(df, groupingVars = grouping_variables, med_SAT = median(SAT))

df %<>%
  mutate(sex = as.factor(sex)) %>%
  mutate(sex = fct_reorder(sex, med_SAT)) %>%
  mutate(race = as.factor(race)) %>%
  mutate(race = fct_reorder(race, med_SAT)) %>%
  mutate(path = as.factor(path)) %>%
  mutate(path = fct_reorder(path, med_SAT)) %>%
  rename("SAT" = "med_SAT") %>%
  glimpse()

ggplot(df, aes(x = SAT, y = race)) +
  geom_point() +
  facet_grid(rows = vars(sex), cols = vars(path), as.table = F)
#highlights how asians have the highest SAT         

ggplot(df, aes(x = SAT, y = path)) +
  geom_point() +
  facet_grid(rows = vars(race), cols = vars(sex), as.table = F)
#better to compare race, and sex

ggplot(df, aes(x = SAT, y = sex)) +
  geom_point() +
  facet_grid(rows = vars(race), cols = vars(path), as.table = F)
#most readable to compare race and sex. Harder to compare path, but not as compelling a story there


ggplot(df, aes(x = SAT, y = race, color = sex)) +
  geom_jitter(width = 0, height = 0.2) +
  facet_wrap(vars(path), as.table = F)
#story: race is a large predictor, followed by sex