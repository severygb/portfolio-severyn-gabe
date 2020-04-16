library("tidyverse")
data(gapminder, package = "gapminder")

df <- as.tibble(gapminder) %>%
  glimpse()
countries_to_keep <- c("Norway","Switzerland" , "Sweden", "Japan" ,"Italy", "Greece", "Canada" ,
                         "Spain","Singapore","Germany","United States","Australia","India","China",
                         "Korea, Dem. Rep.","Mexico")

df <- df %>%
  select(!continent) %>% 
  filter(country %in% countries_to_keep) %>%
  mutate(country = fct_recode(country,"South Korea" = "Korea, Dem. Rep.")) %>%
  mutate(country = fct_reorder(country, lifeExp)) %>%
  droplevels() %>%
  glimpse()

saveRDS(df, file = "data/0504-scatterplot-gapminder-01.rds")
