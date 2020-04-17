library(tidyverse)
library(scales)
library(graphclassmate)
library(grid)

college <- readRDS("data/D1-college-data.rds")

ACT_mean <- mean(college$ACT)
need_mean <- mean(college$need_fraction)

p <- ggplot(college, aes(x = Earn, y = category, color = school_type, fill = school_type)) +
  geom_jitter(width = 0, height = 0.2, shape = 21, size = 2, alpha = 0.5) +
  theme_graphclass() +
  labs(x = "Annual earnings post-graduation", 
       y = "", caption = "Data: DASL graduate earnings", 
       color = "", fill = "",
       title = "Demographics do not strongly predict earnings at US colleges",
       subtitle = paste0("Average ACT score = ",round(ACT_mean, digits = 0),", and on average ",round(need_mean, digits = 2)*100,"% of students need financial aid.")) +
  scale_x_continuous(labels = dollar) +
  theme(plot.title = element_text(size = 12))

#create labels on colors, no legend
p <- p +
  geom_text(aes(x = 58000, y = 1.35, label = "private school"), color = "#E69F00") +
  geom_text(aes(x = 65500, y = 0.95, label = "public school"), color = "#56B4E9") +
  scale_color_manual(values = c("#E69F00", "#56B4E9")) +
  theme(legend.position = "none") +
  scale_fill_manual(values = c("#E69F00", "#56B4E9"))

p

ggsave(filename = "/D1-college.png",
       path    = "figures",
       width   = 8,
       height  = 4,
       units   = "in",
       dpi     = 300)
