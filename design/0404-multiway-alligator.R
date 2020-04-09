library("tidyverse")
library("graphclassmate")


alli <- readRDS("data/0404-multiway-alligator-data.rds") %>%  
  glimpse()

p <- ggplot(alli, aes(x = count, y = lake)) +
  geom_point(size = 2, shape = 21, color = rcb("dark_BG"), fill = rcb("light_BG")) +
  facet_wrap(vars(food), as.table = FALSE) +
  theme_graphclass() +
  labs(x = "Number of Alligators", y = "Lake", caption = "Data: Agresti (2002) in vcdExtra package")
p

ggsave(filename = "0404-multiway-alligator-01.png",
       path    = "figures",
       width   = 8,
       height  = 5.3,
       units   = "in",
       dpi     = 300)

#plot dual
p <- ggplot(alli, aes(x = count, y = food)) +
  geom_point(size = 2, shape = 21, color = rcb("dark_BG"), fill = rcb("light_BG")) +
  facet_wrap(vars(lake), as.table = FALSE) +
  theme_graphclass() +
  labs(x = "Number of Alligators", y = "Primary Food Source", caption = "Data: Agresti (2002) in vcdExtra package")

p
ggsave(filename = "0404-multiway-alligator-02.png",
       path    = "figures",
       width   = 8,
       height  = 5.3,
       units   = "in",
       dpi     = 300)
