data(Alligator, package = "vcdExtra")

alli <- Alligator %>%
  mutate(food = fct_reorder(food, count)) %>%
  mutate(lake = fct_reorder(lake, count))

saveRDS(alli, file = "data/0404-multiway-alligator-data.rds")
