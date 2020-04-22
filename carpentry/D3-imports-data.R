library(tidyverse)
library(graphclassmate)

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

#pare down to just the data I want
df <- df %>%
  select(drive.wheels, bore, stroke, body.style) %>%
  na.omit() %>%
  glimpse()

#drop 4wd type b/c few data points
summary(df$drive.wheels)
df <- filter(df, drive.wheels != "4wd") %>% 
  glimpse()

forcats::fct_drop(df$drive.wheels)

levels(df$drive.wheels)
#fct_drop DOES NOT WORK, STILL HAS 3 LEVELS!

saveRDS(df, file = "data/D3-imports.rds")
