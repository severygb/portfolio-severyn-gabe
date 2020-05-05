library(tidyverse)
library(graphclassmate)
library(scales)

imports <- readRDS(file = "data/D3-imports.rds")


# vertical panels. 1 column of TALL
# ggplot(imports, aes(x = highway.mpg, y = price, color = country)) +
#   geom_point() +
#   theme_graphclass() +  
#   facet_wrap(vars(body.style), as.table = F, ncol = 1) +
#   scale_y_continuous(labels = dollar) +
#   labs(y = "Price (1985 dollars)", x = "Highway fuel economy (miles per gallon)",
#        caption = "Source: UCI Machine Learning Repository")

# ggsave(filename = "D3-scatterplot-imports.png",
#        path    = "figures",
#        width   = 5,
#        height  = 10,
#        units   = "in",
#        dpi     = 300)

# wide panel layout, 1 row

ggplot(imports, aes(x = price, y = highway.mpg, color = country)) +
  geom_point(size = 0.9) +
  theme_graphclass() +  
  facet_wrap(vars(body.style), as.table = F, nrow = 1) +
  scale_x_continuous(labels = dollar, breaks = seq(0,50000,15000)) +
  labs(x = "Price (1985 dollars)", y = "Highway fuel economy (mi/gal)",
       caption = "Source: UCI Machine Learning Repository",
       title = "New vehicles imported into the US in 1985") +
  theme(legend.position="bottom", plot.margin=unit(c(0.1,0.25,0.1,0.1),"in"))


ggsave(filename = "D3-scatterplot-imports.png",
       path    = "figures",
       width   = 9,
       height  = 4,
       units   = "in",
       dpi     = 300)
