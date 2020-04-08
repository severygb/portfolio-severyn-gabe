library("tidyverse")
library("graphclassmate")

explore <- nontraditional %>% glimpse()

summary(explore)

explore %>%
  count(sex, path) %>%
  arrange(desc(n))

ggplot(explore, aes(x = enrolled, y = path)) +
  geom_boxplot()

ggplot(explore, aes(x = enrolled, y = sex)) +
  geom_boxplot()

ggplot(explore, aes(y = enrolled, x = sex, fill = path)) +
  geom_boxplot()

explore <- explore %>% 
  mutate(sex_path = str_c(sex, path, sep = " ")) %>% 
  mutate(sex_path = fct_reorder(sex_path, enrolled))

ggplot(explore, aes(y = enrolled, x = sex_path)) +
  geom_boxplot()
