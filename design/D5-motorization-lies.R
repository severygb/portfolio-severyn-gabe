#Gabe Severyn
#May 2020
library(tidyverse)
library(magrittr)
library(mapproj)
library(graphclassmate)

map_data <- readRDS("data/D5-motorization-map-data.rds")
#motorization rate is for 2015. rate is number of vehicles per 1000 people
world <- map_data("world")

#for testing
# ggplot(world, aes(x = long, y = lat, group = group)) +
#   geom_polygon(fill = "gray") +
#   coord_map(projection = "mollweide",
#             xlim = c(-150, 170),
#             ylim = c(-50, 75),
#             orientation = c(90, 0, 0))


#makes gray background map
map <- ggplot(world, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "gray") +
  coord_map(projection = "mollweide", 
            xlim = c(-150, 170),
            ylim = c(-50, 75),
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

#adds layer for color gradient
map <- map +
  geom_polygon(data = map_data, aes(x = long, y = lat, group = group, fill = motor_rate2015)) +
  labs(title = "        Motorization rate in 2015", caption = "Source: OICA        ", fill = "Vehicles\nper 1000 people") +
  scale_colour_distiller(
    type = "seq",
    palette = "Oranges",
    direction = 1,
    space = "Lab",
    guide = "colourbar",
    aesthetics = "fill"
    ) +
  theme(legend.position = c(0.15,0.25),
        plot.title = element_text(size = 11),
        plot.caption = element_text(size = 11),
        legend.title = element_text(size = 10),
        legend.background = element_rect(fill = NA),
        plot.margin = unit(c(0.1, 0, 0.1, 0), "in")
        )

map

ggsave(plot = map, filename = "D5-map.png",
       path    = "figures",
       width   = 10,
       height  = 5,
       units   = "in",
       dpi     = 300)


#dot plot
dot_plot_data <- readRDS("data/D5-motorization-dot-plot-data.rds")

percent_change <- wrapr::build_frame(
      "region",                         "change" |
      "EU 28 countries + EFTA",         "9"      |
      "Russia, Turkey & other Europe",  "59"     |
      "NAFTA",                          "6"      |
      "Central & South America",        "60"     |
      "Asia/Oceania/Middle East",       "141"    |
      "Africa",                         "35"     |
      "Japan & South Korea",            "7"      |
      "Australia & New Zealand",        "18.6"
      ) %>%
  mutate(change = as.numeric(change)/100) %>%
  glimpse()

#compute motorization rate in 2005 from change written on graphic
#then pivot data to get year as a factor
dot_plot_data %<>%
  mutate(motor_rate2005 = motor_rate2015 / (1 + percent_change$change)) %>%
  pivot_longer(cols = starts_with("motor_rate"),
               names_to = "year",
               names_prefix = "motor_rate",
               names_ptypes = list(year = factor()),
               values_to = "rate"
               ) %>%
    glimpse()

dot_plot <- ggplot(dot_plot_data, aes(x = rate, y = region, color = year)) +
  geom_point(size = 2) +
  theme_graphclass() +
  theme(
    plot.margin = unit(c(0.1, 0.25, 0.1, 0), unit = "in")
  ) +
  labs(x = "Vehicles per 1000 people", y = "", caption = "Source: OICA",
       title = "Motorization rate in 2015", color = "Legend") +
  scale_x_continuous(breaks = c(0,200,400,600,800)) +
  scale_color_brewer(type = "qual", palette = "Set2")

dot_plot

ggsave(plot = dot_plot, filename = "D5-dot-plot.png",
       path    = "figures",
       width   = 6,
       height  = 4,
       units   = "in",
       dpi     = 300)
