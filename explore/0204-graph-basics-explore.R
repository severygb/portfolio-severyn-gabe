library("tidyverse")
library("gapminder")
library("graphclassmate")

glimpse(gapminder)

p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + 
  geom_smooth(method = "gam") + 
  labs(x = "GDP per capita", y = "Life expertancy (years)") + 
  scale_x_log10(labels = scales::dollar)

p
# plot structure: ggplot assignes graph object to variable, tied to data. Add mapping (which things to plot), and geometry layer to display it. Layers for other features

summarytools::dfSummary(gapminder)
gapminder %>% count(continent)
my_gapminder <- gapminder %>% filter(continent != "Oceania") %>% glimpse()
summary(my_gapminder$year)

my_gapminder <-  my_gapminder %>%
  filter(year == max(year)) %>%
  mutate(continent = fct_reorder(continent, lifeExp)) %>%
  glimpse()

#split data by continent
p2 <- ggplot(data = my_gapminder,
             mapping = aes(x = gdpPercap/1000, y = lifeExp)) +
  labs(x = "GDP per capita (thousands of dollars)", y = "Life expectancy (years)") + 
  geom_point() + 
  facet_wrap(facets = vars(continent), ncol = 1, as.table = FALSE)
p2

#show all data in each panel, but highlight that continents data
p3 <- ggplot(data    = my_gapminder,
             mapping = aes(x  = gdpPercap / 1000, y = lifeExp)) +
  geom_point(data     = select(my_gapminder, -continent),
             size     = 1.25,
             color    = "#C7EAE5") +
  geom_smooth(data    = select(my_gapminder, -continent),
              method  = "loess",
              se      = FALSE,
              size    = 0.7,
              color   = "#35978F") +
  geom_point(mapping  = aes(color = continent),
             size     = 1.25,
             color    = "#01665E") +
  facet_wrap(vars(continent),
             ncol     = 1,
             as.table = FALSE) +
  labs(x = "GDP per capita (thousands of dollars)",
       y = "Life expectancy (years)",
       title   = "Life expectancy by country in 2007",
       caption = "Source: Gapminder") +
  theme_graphclass() +
  theme(legend.position = "none")
p3

ggsave(filename = "figures/0204-graph-basics-gapminder.png", 
       width = 6.5,
       height = 7.5,
       units = "in", 
       dpi = 300)
include_graphics("../figures/0204-graph-basics-gapminder.png")