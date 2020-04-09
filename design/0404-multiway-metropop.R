library("tidyverse")
library("graphclassmate")

#read in our nice and tidy already carpentered data frame
metro_pop <- readRDS("data/0404-multiway-metropop-data.rds") %>%  
  glimpse()

p <- ggplot(metro_pop, aes(x = population, y = race)) +
  geom_point(size = 2, shape = 21, color = rcb("dark_BG"), fill = rcb("light_BG")) +
  facet_wrap(vars(county), as.table = FALSE, ncol = 3) +
  scale_x_continuous(trans = 'log2', breaks = 2^seq(2, 10)) +
  theme_graphclass() +
  labs(y = NULL, x = "Population (thousands) log-2 scale")
#facet_wrap(ncol = #) makes only three panels/column, because these needed to be a little bit wider so the x-axis shows correctly
#as.table = F orders panels with maximum at top right. default is max at bottom right
p

ggsave(filename = "0404-multiway-metropop-01.png",
       path    = "figures",
       width   = 8,
       height  = 5.3,
       units   = "in",
       dpi     = 300)

#plot the dual of the multiway
#flip y and facet variables
ggplot(metro_pop, aes(x = population, y = county)) +
  geom_point(size = 2, shape = 21, color = rcb("dark_BG"), fill = rcb("light_BG")) +
  facet_wrap(vars(race), as.table = FALSE, ncol = 3) +
  scale_x_continuous(trans = 'log2', breaks = 2^seq(2, 10)) +
  theme_graphclass() +
  labs(y = NULL, x = "Population (thousands) log-2 scale")


ggsave(filename = "0404-multiway-metropop-02.png",
       path    = "figures",
       width   = 8,
       height  = 5.3,
       units   = "in",
       dpi     = 300)
