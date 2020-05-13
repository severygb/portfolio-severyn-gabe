library(tidyverse)
library(magrittr)
library(graphclassmate)

map_data <- readRDS("data/D5-motorization-map-data.rds")
#motorization rate is for 2015. rate is number of vehicles per 1000 people
world <- map_data("world")

ggplot() +
  coord_fixed(1.2) +
  geom_polygon(data = world, aes(x = long, y= lat, group = group), fill = "grey", color = "grey") +
  geom_polygon(data = map_data, aes(x = long, y = lat, group = group, fill = motor_rate2015)) +
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

#dot plot
dot_plot_data <- readRDS("data/D5-motorization-dot-plot-data.rds")

ggplot(continents_data, aes(x = motor_rate2015, y = region)) +
  geom_point() +
  theme_graphclass()
