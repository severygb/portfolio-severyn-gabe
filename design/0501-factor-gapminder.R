library(graphclassmate)

df1 <- readRDS(file = "data/factor-gapminder-data.rds")

ggplot(df1, aes(x = lifeExp, y = country)) +
  geom_point() +
  labs(x = "Life Expectancy (years)", y = "", caption = "gapminder dataset") +
  theme_graphclass()


ggsave(filename = "0501-factor-gapminder.png",
       path    = "figures",
       width   = 8,
       height  = 2.5,
       units   = "in",
       dpi     = 300)

