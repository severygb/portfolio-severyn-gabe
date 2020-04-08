library("tidyverse")
library("graphclassmate")

ozone_data <-  readRDS("data/0304-strip-plot-ozone-data.rds") %>%
  glimpse()


p <- ggplot(ozone_data, aes(x = Month, y = Ozone)) +
  geom_point(shape = 1, size = 3) +
  theme_graphclass()

p <- p + 
  labs(x = "Month", y = "Ozone Readings (parts per billion)")

p

ggsave(filename = "0304-strip-plot-ozone.png",
       path = "figures",
       device = "png",
       width = 8,
       height = 2.5,
       units = "in",
       dpi = 300)
       
