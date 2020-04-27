library(tidyverse)
library(seplyr)
library(lubridate)

data(flights, package = "nycflights13")

df <- flights %>% glimpse()

class(df$time_hour)
#time_hour is a POSIXct
#date also included in integer parts

df <- df %>%
  select(year, month, day)




group_variables <- c("year", "month", "day")
df <- group_summarize(df, 
                groupingVars = group_variables,
                "n" = n()) %>%
  glimpse()

df %<>%
  mutate(date_2013 = make_date(year = df$year, month = df$month, day = df$day)) %>%
  mutate(day_of_week = wday(date_2013, label = T, abbr = T))

glimpse(df) #carpentry completed

ggplot(df, aes(x = date_2013, y = n)) +
  geom_line() +
  facet_wrap(vars(day_of_week)) +
  scale_x_date(date_breaks = "3 months", date_labels = "%b")
