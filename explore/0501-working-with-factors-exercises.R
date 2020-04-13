library(tidyverse)
library(forcats)
library(seplyr)

# E1 gapminder ------------------------------------------------------------

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

ggplot(df1, aes(x = lifeExp, y = country)) +
  geom_point()


# E2 US state area --------------------------------------------------------


df2 <- state.x77

df2 <- cbind(rownames(df2), data.frame(df2, row.names=NULL))

glimpse(df2)

df2 <- df2 %>%
  rename("State" = "rownames(df2)") %>%
  mutate(State = factor(State)) %>%
  glimpse()

df2 <- df2 %>%
  mutate(State = fct_reorder(State, Area)) %>%
  glimpse()

ggplot(df2, aes(x = Area, y = State)) +
  geom_point() +
  scale_x_log10() +
  labs(x = "Area (sq. miles)", y = "", caption = "state.x77 in base R")



# E3 Nontraditional Students ----------------------------------------------

data(nontraditional, package = "graphclassmate") 

df3 <- nontraditional %>%
  glimpse()

groupings <- c("sex", "race", "path")

df_freq <- df3 %>%
  count(sex, race, path) %>%
  glimpse()

df_freq <- df_freq %>%
  mutate(sex = fct_reorder(sex, n)) %>%
  mutate(race = fct_reorder(race, n)) %>%
  mutate(path = fct_reorder(path, n)) %>%
  mutate(race = fct_recode(race,
                              "Asian-American"    = "Asian",
                              "Latino"      = "Hispanic"
  ))

ggplot(df_freq, aes(x = n/1000, y = race, color = sex)) +
  geom_point() +
  facet_grid(rows = vars(path))
