# Gabe Severyn
# 4/16/2020

# load packages
library("tidyverse")
library(VGAMdata)

prep <- oly12
str(prep)

#convert to tibble
prep <- prep %>% 
  as_tibble() %>% 
  glimpse()

prep_numeric <- prep %>% 
  select_if(is.numeric) %>% 
  glimpse()


prep_numeric <- prep_numeric %>% 
  select(Age, Height, Weight)

summary(prep_numeric)

#look at how many levels are in each factor
prep_factor <- prep %>% 
  select_if(is.factor) %>% 
  glimpse()
sapply(prep_factor, nlevels)

prep <- prep %>% 
  select(Name, Country, Age, Height, Weight, Sex, Sport, Event) %>% 
  filter(complete.cases(.)) %>% 
  glimpse()

#remove duplicates, and check num of rows to see how many
prep <- prep %>% 
  distinct() %>% 
  glimpse()

ggplot(data = prep, aes(x = Height, y = Weight, color = Sex)) +
  geom_jitter()

ggplot(data = prep, aes(x = Height, y = Weight, color = Sex)) +
  geom_jitter() +
  facet_wrap(vars(Sport))

#look at what sports have only a few people
n_athletes <- prep %>% 
  count(Sport) %>% 
  arrange(desc(n))

knitr::kable(n_athletes)

#drop all the sports with <50 people
n_small <- n_athletes %>% 
  filter(n < 50)

drop_these <- n_small$Sport %>% 
  droplevels() %>% 
  as.character()

prep <- prep %>% 
  filter(!Sport %in% drop_these) %>%
  filter(Weight < 200)

ggplot(data = prep, aes(x = Height, y = Weight, color = Sex)) +
  geom_jitter() +
  facet_wrap(vars(Sport))
