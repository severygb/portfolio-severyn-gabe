library(tidyverse)
library("tsbox")
#library(lubridate)

data(jj, package = "astsa")

glimpse(jj)

df <- ts_df(jj) %>% 
  glimpse()

df %<>% 
  rename(qtr_date = time) %>%
  rename(qtr_earn = value) %>%
  glimpse()

ggplot(df, aes(x = qtr_date, y = qtr_earn)) +
  geom_line()
