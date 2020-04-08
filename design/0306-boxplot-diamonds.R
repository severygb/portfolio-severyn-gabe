library("tidyverse")
library("graphclassmate")

diamond_data <- readRDS("data/0306-boxplot-diamond-data.rds")

p <- ggplot(diamond_data, aes(x = price_per_carat, y = reorder(color, desc(color)), fill = clarity)) +
  geom_boxplot(outlier.size = 0.5) +
  theme_graphclass() +
  labs(x = "Price per Carat ($)", y = "Color (D is best)", title = "Price for Varying Diamond Classifications") +
  guides(fill = guide_legend(title = "Clarity Level\n(IF is best)", reverse = TRUE, keyheight = 1.5))
  
p

ggsave(filename = "0306-boxplot-diamonds.png",
       path    = "figures",
       width   = 8,
       height  = 6,
       units   = "in",
       dpi     = 300)
