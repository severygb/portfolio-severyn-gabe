library("tidyverse")
library("graphclassmate")

nontrad <- readRDS("data/0305-boxplot-nontrad-data.rds") %>% 
  glimpse()

outlier_only <- nontrad %>%
  group_by(sex_path) %>%
  mutate(outlier = enrolled < median(enrolled) - 1.5 * IQR(enrolled)) %>%
  ungroup() %>% 
  filter(outlier == TRUE)

glimpse(outlier_only)

p <- ggplot(nontrad, aes(y = sex_path, x = enrolled, fill = path, color = path)) +
  geom_boxplot(width = 0.45, alpha = 0.75, outlier.shape = NA) +
  labs(x = "Years enrolled", y = "", title = "Graduating students") +
  theme_graphclass() +
  scale_fill_manual(values = c(rcb("light_BG"), rcb("light_Br"))) +
  scale_color_manual(values = c(rcb("dark_BG"), rcb("dark_Br"))) +
  guides(fill = guide_legend(title = NULL, reverse = TRUE, keyheight = 2), color = "none") 

p <-  p +
  geom_jitter(data = outlier_only, width = 0.05, height = 0.2, alpha = 0.25, shape = 21)

p

ggsave(filename = "0305-boxplot-nontrad.png",
       path    = "figures",
       width   = 8,
       height  = 2.5,
       units   = "in",
       dpi     = 300)
