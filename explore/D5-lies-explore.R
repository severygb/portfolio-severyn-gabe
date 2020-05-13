library(tidyverse)
library(readxl)
library(ggmap)
library(maps)
library(magrittr)
library(stringr)
library(RColorBrewer)

df <- read_excel(path = "data-raw/OICA-Global-Vehicles.xlsx", skip = 1, 
                 col_names = c("country", "motor_rate2015"),trim_ws = T) %>%
  glimpse()
#motorization rate is for 2015. rate is number of vehicles per 1000 people

#drop antartica
#world %<>% filter(region != "antarctica")

#using map tutorial from https://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html
world <- map_data("world")

world$region = str_to_lower(world$region)
df %<>%
  mutate(country = str_to_lower(df$country)) %>%
  rename("region" = "country")

#these are the names that don't immediately line up between the data sets
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

#only use countries in the data, not what I want to do
world_motor_rate <- inner_join(df, world, by = "region")

ggplot() +
  coord_fixed(1.2) +
  geom_polygon(data = world, aes(x = long, y= lat, group = group), fill = "grey", color = "grey") +
  geom_polygon(data = world_motor_rate, aes(x = long, y = lat, group = group, fill = motor_rate2015)) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank()
        ) +
  scale_colour_distiller(
    type = "seq",
    palette = "Oranges",
    direction = 1,
    space = "Lab",
    guide = "colourbar",
    aesthetics = "fill"
  ) +
  labs(title = "Motorization rate in 2015 (per 1000 people)", caption = "Source: OICA")