library(graphclassmate)


df2 <- readRDS(file = "data/0501-factor-state.rds")


ggplot(df2, aes(x = Area, y = State)) +
  geom_point() +
  scale_x_log10() +
  labs(x = "Area (sq. miles)", y = "", caption = "state.x77 in base R") +
  theme_graphclass()

ggsave(filename = "0501-factor-state-area.png",
       path    = "figures",
       width   = 4,
       height  = 8,
       units   = "in",
       dpi     = 300)
