library("tidyverse")
data(gapminder, package = "gapminder")

glimpse(gapminder)

explore <- as.tibble(gapminder)

prep_factor <- explore %>%
  select_if(is.factor) %>% 
  glimpse()
  
sapply(prep_factor, nlevels)

summary(explore)
