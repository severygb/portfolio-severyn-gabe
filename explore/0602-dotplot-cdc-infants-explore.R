# Gabe Severyn
# 4/21/2020

# load packages
library("tidyverse")
library("seplyr")
library(graphclassmate)

data(infant_mortality, package = "graphclassmate")

glimpse(infant_mortality)

grouping_variables <- c("region", "county_id", "race", "age")
df <- infant_mortality %>% 
  seplyr::group_summarise(., 
                          grouping_variables, 
                          births = sum(births, na.rm = TRUE), 
                          deaths = sum(deaths, na.rm = TRUE)) %>% 
  mutate(rate = round(deaths / births * 1000, 0)) %>% 
  filter(complete.cases(.)) %>% 
  glimpse()

data(county_income)
glimpse(county_income)

df <- left_join(df, county_income, by = "county_id")  %>% 
  select(region, county_id, state, county, everything()) %>% 
  arrange(region, county_id) %>% 
  filter(complete.cases(.))

glimpse(df)

ggplot(df, aes(x = income, y = rate, color = race)) +
  geom_jitter() +
  facet_wrap(vars(age), as.table = FALSE)

ggplot(df, aes(x = rate, y = age, color = race)) +
  geom_jitter() +
  facet_wrap(vars(region), as.table = FALSE)

df <- df %>% 
  filter(complete.cases(.)) %>% 
  mutate(race   = forcats::fct_reorder(race,  rate)) %>% 
  mutate(region = forcats::fct_reorder(region, rate))

ggplot(df, aes(x = age, y = rate, color = race)) +
  geom_jitter() +
  facet_grid(rows = vars(region), cols = vars(race), as.table = FALSE)
#mortality for black is much higher than everyone else

ggplot(df, aes(x = income, y = rate, color = race)) +
  geom_jitter() +
  facet_grid(rows = vars(age), cols = vars(race), as.table = FALSE)
#no real income effect

#mother's age group and whether or not she is black are the two important factors