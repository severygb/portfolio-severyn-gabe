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
  labs(x = "Annual Earnings Post-Graduation", 
       y = "", caption = "Data: DASL Graduate Earnings", 
       color = "", fill = "",
       title = "Student Demographics and Post Graduation Earnings at US Colleges",
       subtitle = paste0("On average, ACT Score = ",round(ACT_mean, digits = 0)," and ",round(need_mean, digits = 2)*100,"% of students need aid.")) +
  scale_x_continuous(labels = dollar) +
  theme(plot.title = element_text(size = 12))

p

ggsave(filename = "/D1-college.png",
       path    = "figures",
       width   = 8,
       height  = 4,
       units   = "in",
       dpi     = 300)
