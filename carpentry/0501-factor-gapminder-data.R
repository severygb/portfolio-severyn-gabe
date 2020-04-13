library(tidyverse)

data(gapminder, package = "gapminder")

df1 <- gapminder %>%
  glimpse()

df1 <- df1 %>%
  filter(continent == "Asia" & year == 2007) %>%
  glimpse()

attributes(df1$continent)
fct_drop(df1$continent)

df1 <- df1 %>%
  mutate(country = fct_reorder(country, lifeExp))

saveRDS(df1, file = "data/factor-gapminder-data.rds")