library(graphclassmate)
library(tidyverse)
library(scales)

readRDS(file = "data/D2-vessels-2000.rds")

p <- ggplot(vessels_2000, aes(x = n, y = Age)) +
  geom_point() +
  facet_wrap(vars(type), as.table = FALSE) +
  theme_graphclass() +
  scale_x_log10(label = comma) +
  labs(x = "Number of vessels", y = "Age of vessel", title = "Vessels flying the U.S. flag in 2000 by type")
p

ggsave(filename = "/D2-vessels-1.png",
       path    = "figures",
       width   = 8,
       height  = 5.3,
       units   = "in",
       dpi     = 300)

p2 <- ggplot(vessels_2000, aes(x = n, y = type)) +
  geom_point() +
  facet_wrap(vars(Age), as.table = FALSE) +
  theme_graphclass() +
  scale_x_log10(label = comma) +
  labs(x = "Number of vessels", y = "", subtitle = "Vessels flying the U.S. flag in 2000, by age")
p2
ggsave(filename = "D2-vessels-2.png",
       path    = "figures",
       width   = 8,
       height  = 5.3,
       units   = "in",
       dpi     = 300)