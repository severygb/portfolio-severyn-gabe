library(tidyverse)
library(forcats)
library(seplyr)

data(nontraditional, package = "graphclassmate") 

df3 <- nontraditional %>%
  glimpse()

groupings <- c("sex", "race", "path")

df_freq <- df3 %>%
  count(sex, race, path) %>%
  glimpse()

df_freq <- df_freq %>%
  mutate(sex = fct_reorder(sex, n)) %>%
  mutate(race = fct_reorder(race, n)) %>%
  mutate(race = fct_recode(race,
                           "Asian-American"    = "Asian",
                           "Latino"      = "Hispanic"
  )) %>%
  mutate(path = fct_reorder(path, n))

saveRDS(df_freq, file = "data/0501-factor-nontrad-data.rds")