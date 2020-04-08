library("tidyverse")
library("GDAdata")

explore <- SpeedSki %>%
  glimpse()

explore %>%
  select(Speed) %>%
  summary()

explore %>% 
  count(Sex, Event) %>%
  complete(Sex, Event, fill = list(n=0)) %>%
  arrange(desc(n))

explore <-  explore %>%
  mutate(allevents = "All events")


set.seed(111111)
ggplot(explore, aes(x = Speed, y = allevents, color = Sex)) +
  geom_jitter(width = 0, height = 0.1)

ggplot(explore, aes(x = Speed, y = Event, color = Sex)) +
  geom_jitter(width = 0, height = 0.1)
