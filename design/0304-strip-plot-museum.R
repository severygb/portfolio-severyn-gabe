library("tidyverse")
library("graphclassmate")

museum <-  readRDS("data/0304-strip-plot-museum-data.rds") %>%
  glimpse()

p <- ggplot(museum, aes(x = minutes, y = exhibit)) + 
  geom_jitter(width = 0, height = 0.2, shape = 21, size = 2) +
  theme_graphclass() +
  scale_color_manual(values = c(rcb("dark_BG"), rcb("dark_Br"))) +
  scale_fill_manual(values = c(rcb("mid_BG"), rcb("mid_Br")))

p <- p + 
  labs(x = "Minutes Viewed", y = "")

p

ggsave(filename = "0304-strip-plot-museum.png",
       path = "figures",
       device = "png",
       width = 8, 
       height = 2.5,
       units = "in",
       dpi = 300)
       