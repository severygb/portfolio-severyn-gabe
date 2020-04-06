library("tidyverse")
library("graphclassmate")

speedski <- readRDS("data/0305-boxplot-speedski-data.rds")

p <- ggplot(speedski, aes(x = speed, y = event_sex, fill = sex)) +
  geom_boxplot() +
  theme_graphclass() +
  scale_fill_manual(values = c(rcb("light_BG"), rcb("light_Br"))) +
  scale_color_manual(values = c(rcb("dark_BG"), rcb("dark_Br"))) +
  guides(fill = guide_legend(title = NULL, reverse = TRUE, keyheight = 2), color = "none")  +
  labs(x = "Speed (km/hr)", y = "", title = "Speedskiing Classes")

p

ggsave(filename = "0305-boxplot-speedski.png",
       path    = "figures",
       width   = 8,
       height  = 2.5,
       units   = "in",
       dpi     = 300)

