data(metro_pop, package = "graphclassmate")

# convert categories to factors ordered by total population 
#sum command reorders the factors by the sum of population, not the median
metro_pop <- metro_pop %>% 
  mutate(county = fct_reorder(county, population, sum)) %>% 
  mutate(race   = fct_reorder(race, population, sum)) %>% 
  mutate(population = population / 1000)

saveRDS(metro_pop, "data/0404-multiway-metropop-data.rds")
