library("tidyverse")
library("graphclassmate")
oly12 <- readRDS("data/0504-scatterplot-oly12-data.rds")

glimpse(oly12)

p <- ggplot(data = oly12, aes(x = Height, y = Weight, col = Sex)) +
  geom_jitter(alpha = 0.2) +
  facet_wrap(vars(Sport), as.table = FALSE)

#adjust no. columns for readability
p <- p +
  facet_wrap(vars(Sport), as.table = FALSE, ncol = 4) +
  scale_x_continuous(breaks = seq(0, 3, by = 0.2)) +
  scale_y_continuous(breaks = seq(0, 200, by = 50))

p <-  p + 
  theme_graphclass() +
  labs(x = "Height (m)", 
       y = "Weight (kg)",
       title = "2012 Summer Olympics, Individual Athletes", 
       subtitle = "For sports with 50 or more athletes", 
       caption = "Source: VGAMdata package"
  ) +
  scale_color_manual(values = c(rcb("mid_BG"), rcb("mid_Br")))
p

ggsave(filename = "0504-scatterplot-oly12.png",
       path    = "figures",
       width   = 8,
       height  = 16,
       units   = "in",
       dpi     = 300)
