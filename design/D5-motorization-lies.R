library(tidyverse)
library(magrittr)
library(mapproj)
library(graphclassmate)

map_data <- readRDS("data/D5-motorization-map-data.rds")
#motorization rate is for 2015. rate is number of vehicles per 1000 people
world <- map_data("world")

#makes gray background map
map <- ggplot(world, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "gray") +
  coord_map(projection = "mollweide", 
            ylim = c(-75, 75), 
            orientation = c(90, 0, 0)) +
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
  )
map

#adds layer for color gradient
map %<>% +
  geom_polygon(data = map_data, aes(x = long, y = lat, group = group, fill = motor_rate2015)) +
  labs(title = "Motorization rate in 2015 (per 1000 people)", caption = "Source: OICA") +
  scale_colour_distiller(
  type = "seq",
  palette = "Oranges",
  direction = 1,
  space = "Lab",
  guide = "colourbar",
  aesthetics = "fill"
)

#dot plot
dot_plot_data <- readRDS("data/D5-motorization-dot-plot-data.rds")

ggplot(continents_data, aes(x = motor_rate2015, y = region)) +
  geom_point() +
  theme_graphclass()
