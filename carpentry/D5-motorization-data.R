library(readxl)
library(tidyverse)
library(magrittr)


#carpent the map data
df <- read_excel(path = "data-raw/OICA-Global-Vehicles.xlsx", skip = 1, 
                 col_names = c("country", "motor_rate2015"),trim_ws = T) %>%
  glimpse()
#motorization rate is for 2015. rate is number of vehicles per 1000 people

#grab world map data
world <- map_data("world") #a ggplot2 function


#fix names that match between the data sets
world$region = str_to_lower(world$region)
df %<>%
  mutate(country = str_to_lower(df$country)) %>%
  rename("region" = "country")

(in_data_not_map <- anti_join(df, world, by = "region"))
(in_map_not_data <- anti_join(world, df, by = "region") %>%
    select(region) %>%
    unique())

world$region %<>%  str_replace("\\buk\\b","united kingdom")
world$region %<>%    str_replace("bosnia and herzegovina","bosnia")
world$region %<>%    str_replace("usa","united states of america")
world$region %<>% str_replace("azerbaidjan","azerbaijan")
world$region %<>% str_replace("democratic republic of the congo","congo kinshasa")

unique(world$region)
unique(df$region)

#match map data with motorization data
world_motor_rate <- inner_join(df, world, by = "region")

saveRDS(world_motor_rate, file = "data/D5-motorization-map-data.rds")

#carpent the dot plot data
continents_data <- read_excel(path = "data-raw/OICA-Continent-Vehicles.xlsx", skip = 1, 
                              col_names = c("region", "motor_rate2015"),trim_ws = T) %>%
  glimpse()

continents_data %<>%
  mutate(region = as_factor(region)) %>%
  mutate(region = fct_reorder(region, motor_rate2015)) %>%
  glimpse()

saveRDS(continents_data, file = "data/D5-motorization-dot-plot-data.rds")

ggplot(continents_data, aes(x = motor_rate2015, y = region)) +
  geom_point()