library("tidyverse")
library("graphclassmate")

college_data <- readRDS("0404-multiway-ucb-admit-data.rds") %>%  
  glimpse()

p <- ggplot(college_data, aes(x = ratio, y = dept)) +
  geom_point(size = 2, shape = 21, color = rcb("dark_BG"), fill = rcb("light_BG")) +
  facet_wrap(vars(sex), as.table = FALSE) +
  theme_graphclass() +
  labs(x = "Ratio of Students Admitted to Students Applied", y = "Department", caption = "Data: ucb_admissions from graphclassmate package")
p

ggsave(filename = "/0404-multiway-ucb-admit-01.png",
       path    = "figures",
       width   = 8,
       height  = 5.3,
       units   = "in",
       dpi     = 300)

#plot dual
p <- ggplot(college_data, aes(x = ratio, y = sex)) +
  geom_point(size = 2, shape = 21, color = rcb("dark_BG"), fill = rcb("light_BG")) +
  facet_wrap(vars(dept), as.table = FALSE) +
  theme_graphclass() +
  labs(x = "Ratio of Students Admitted to Students Applied", y = "", caption = "Data: ucb_admissions from graphclassmate package", title = "Admissions data by department")

p
ggsave(filename = "/0404-multiway-ucb-admit-02.png",
       path    = "figures",
       width   = 8,
       height  = 5.3,
       units   = "in",
       dpi     = 300)