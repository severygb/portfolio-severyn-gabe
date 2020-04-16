library(tidyverse)
library(graphclassmate)

readRDS("data/0504-scatterplot-gapminder-01.rds")

p <- ggplot(data = df, aes(x = gdpPercap/10000, y = lifeExp, color = year, size = pop/1e6)) +
  geom_point() +
  facet_wrap(vars(country), as.table = FALSE) +
  labs(x = "GDP per capita ($10k ppp)", y = "Life expectancy (years)", 
       caption = "Source: gapminder", title = "Life expectancy (years)")
p

ggsave(filename = "0504-scatterplot-gapminder-02.png",
       path    = "figures",
       width   = 8,
       height  = 8,
       units   = "in",
       dpi     = 300)
