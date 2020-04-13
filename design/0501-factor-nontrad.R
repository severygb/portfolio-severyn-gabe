library(graphclassmate)


df3 <- readRDS(file = "data/0501-factor-nontrad-data.rds")

ggplot(df_freq, aes(x = n/1000, y = race, color = sex)) +
  geom_point() +
  facet_grid(rows = vars(path), as.table = F) +
  theme_graphclass()+ 
  labs(x = "Number of students, thousands", y = "")


ggsave(filename = "0501-factor-nontrad.png",
       path    = "figures",
       width   = 8,
       height  = 3.5,
       units   = "in",
       dpi     = 300)