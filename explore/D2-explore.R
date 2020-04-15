library(tidyverse)
library(graphclassmate)

df <- read.delim(file = "data-raw/imports-85.txt", header = T, sep = "\t")

glimpse(df)

summary(df)
#it brought in everything as factors, awesome!


# --------------------------------------------------------

#get rid of dohcv and rotor because only one data point each
df2 <- df %>%
  filter(engine.type != "dohcv" & engine.type != "rotor") %>%
  mutate(engine.type = fct_reorder(engine.type, highway.mpg)) %>%
  select(c("body.style","engine.type", "highway.mpg"))

fct_drop(df2$engine.type)
#cat 1 = body style (5 levels)
#cat 2 = engine type (5 levels)
#quan = ?

#looks at what body style and engine type gets the best fuel economy
ggplot(df2, aes(x = highway.mpg, y = engine.type)) +
  geom_point() +
  facet_wrap(vars(body.style), as.table = FALSE) +
  theme_graphclass()

# --------------------------------------------------------
df3 <- df %>% mutate(engine.type = fct_reorder(engine.type, curb.weight))

#doesn't have a great story...
ggplot(df3, aes(x = curb.weight, y = body.style)) +
  geom_point() +
  facet_wrap(vars(engine.type), as.table = FALSE) +
  theme_graphclass()

# -----------------------------------------------------

#get rid of spfi, mfi, spdi because few data points
df4 <- df %>% 
  mutate(engine.type = fct_reorder(engine.type, highway.mpg)) %>%
  filter(fuel.system != "spfi" & fuel.system != "mfi" & fuel.system != "spdi")

fct_drop(df4$fuel.system)

# investigates fuel delivery method per engine design and economy
ggplot(df4, aes(x = highway.mpg, y = fuel.system)) +
  geom_point() +
  facet_wrap(vars(engine.type), as.table = FALSE) +
  theme_graphclass()

levels(df4$fuel.system)
summary(df4$fuel.system)


