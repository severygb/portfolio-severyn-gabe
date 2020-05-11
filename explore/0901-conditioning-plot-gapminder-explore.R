# Gabe Severyn
# 5/11/2020

# load packages
library("tidyverse")

data(gapminder, package = "gapminder")

df <- gapminder %>%
  glimpse()

df %<>%
  mutate(continent = fct_reorder(continent, gdpPercap)) %>%
  glimpse()

coplot(lifeExp ~ log(gdpPercap) | continent * log(pop), data = df,
      pch  = 21, 
      col  = rcb("mid_BG"), 
      bg   = rcb("pale_BG"), 
      bar.bg = c(num = rcb("pale_BG"), fac = rcb("pale_BG")), 
      panel = my_panel
)
