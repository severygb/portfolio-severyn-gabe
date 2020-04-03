library("tidyverse")
library("graphclassmate")


explore <- readRDS("data/0304-strip-plot-speedski-data.rds") %>%
  glimpse()

summary(explore)

# much better than the other way 'round
p <- ggplot(explore, aes(x = speed, y = event, fill = sex)) +
  geom_boxplot()

p

explore <- explore %>% 
  mutate(event_sex = str_c(event, sex, sep = " ")) %>% 
  mutate(event_sex = fct_reorder(event_sex, speed))

p <- ggplot(explore, aes(x = speed, y = event_sex, fill = sex)) +
  geom_boxplot()

p

# p <- ggplot(explore, aes(x = speed, y = sex, fill = event)) +
#   geom_boxplot()
# 
# p
