library(tidyverse)
library(graphclassmate)
library(GGally)

df <- read.csv(file = "data-raw/imports-85.csv", header = T)

#change data types for wrongly read columns
#need to convert to character then numeric to avoid factors being coerced to their level
df <- df %>%
  rename("stroke" = "strike") %>%
  mutate(bore = as.numeric(as.character(bore))) %>%
  mutate(stroke = as.numeric(as.character(stroke))) %>%
  mutate(horsepower = as.numeric(as.character(horsepower))) %>%
  mutate(peak.rpm = as.numeric(as.character(peak.rpm))) %>%
  mutate(price = as.numeric(as.character(price))) %>%
  glimpse()

summary(df)

#create scatterplot matrix, takes 5-ever, run at own risk
# ggpairs(df, columns = 4:26)
# 
# ggsave(filename = "D3-scatterplot-matrix.png",
#        path    = "figures",
#        width   = 20,
#        height  = 20,
#        units   = "in",
#        dpi     = 200)

# facet by body style -----------------------------------------------------

#drop 4wd type b/c few data points
summary(df$drive.wheels)
df2 <- filter(df, drive.wheels != "4wd")
#drop convert & hardtop b/c few data points
#df2 <- filter(df2, !(body.style == "convertible" | body.style == "hardtop"))

ggplot(df2, aes(x = price, y = highway.mpg)) +
  geom_point() +
  theme_graphclass() +  
  facet_wrap(vars(body.style), as.table = FALSE)
#so far the best, but only three cats with enough to matter


#facet by only top makes --------------------------------------------------

#include all makes to show correlation
ggplot(df, aes(x = price, y = highway.mpg)) +
  geom_point() +
  theme_graphclass()


top_makes <- df %>%
  count(make) %>%
  arrange(desc(n)) %>%
  head() %>%
  glimpse()

df3 <- df %>%
  filter(make %in% top_makes$make) %>%
  droplevels() %>%
  glimpse
#105 observations, 100 is requirement minumum
summary(df3$make)

ggplot(df3, aes(x = price, y = highway.mpg)) +
  geom_point() +
  theme_graphclass() +  
  facet_wrap(vars(make), as.table = FALSE)

#!!!!!  ISSUE !!!!!!
#filtering to only 6 makes leaves out a lot of the story... faceting by all makes is horrible though
#requirements need a cat w/ 5+ levels, I dont have one that represents 5 levels nearly equally




# #pare down to just the data I want
# df <- df %>%
#   select(drive.wheels, bore, stroke, body.style) %>%
#   na.omit() %>%
#   glimpse()
# 
# #drop 4wd type b/c few data points
# summary(df$drive.wheels)
# df <- filter(df, drive.wheels != "4wd") %>% 
#   glimpse()
# 
# forcats::fct_drop(df$drive.wheels)
# 
# levels(df$drive.wheels)
# #fct_drop DOES NOT WORK, STILL HAS 3 LEVELS!
# 
# saveRDS(df, file = "data/D3-imports.rds")
