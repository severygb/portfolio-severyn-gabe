library(tidyverse)
library(graphclassmate)

#plot by year
year_deaths <- readRDS(file = "data/D4-motorsports-deaths-yearly.rds")

ggplot(year_deaths, aes(x = year, y = n)) +
  geom_line() +
  scale_x_date(date_breaks = "10 years", date_labels = "%Y") +
  theme_graphclass() +
  labs(x = "", title = "Fatalities from car and truck motorsports in the US", caption = "Source: Motorsport Memorial", y = "Individuals")
  