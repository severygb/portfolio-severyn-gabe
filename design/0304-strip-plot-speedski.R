library("tidyverse")
library("graphclassmate")

speed_ski <-  readRDS("data/0304-strip-plot-speedski-data.rds") %>%
  glimpse()

p <- ggplot(speed_ski, aes(x = speed, y = event, color = sex, fill = sex)) + 
  geom_jitter(width = 0, height = 0.1, shape = 21, size = 2, alpha = 0.7) +
  theme_graphclass() +
  scale_color_manual(values = c(rcb("dark_BG"), rcb("dark_Br"))) +
  scale_fill_manual(values = c(rcb("mid_BG"), rcb("mid_Br")))

p <- p + 
  geom_text(aes(x = 200, y = 2.7, label = "women"), color = rcb("mid_BG")) +
  geom_text(aes(x = 210, y = 2.7, label = "men"), color = rcb("mid_Br")) +
  theme(legend.position = "none")  +
  labs(x = "Speed (km/hr)", y = "") 
p

ggsave(filename = "0304-strip-plot-speedski.png",
       path = "figures",
       device = "png",
       width = 8, 
       height = 2.5,
       units = "in",
       dpi = 300)
       