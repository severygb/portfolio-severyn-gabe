library(tidyverse)
library(graphclassmate)

df <- read.csv(file = "data-raw/imports-85.csv", header = T)

glimpse(df)

summary(df)
#it brought in everything as factors, awesome!

#change data types for wrongly read columns
df <- df %>%
  rename("stroke" = "strike") %>%
  mutate(bore = as.numeric(as.character(bore))) %>%
  mutate(stroke = as.numeric(as.character(stroke))) %>%
  mutate(horsepower = as.numeric(as.character(horsepower))) %>%
  mutate(peak.rpm = as.numeric(as.character(peak.rpm))) %>%
  mutate(price = as.numeric(as.character(price))) %>%
  glimpse()

summary(df)
# --------------------------------------------------------
levels(df$body.style)
summary(df$body.style)

filter(df, num.of.cylinders == "five") %>% glimpse()

levels(df$fuel.type)
summary(df$horsepower)

ggplot(df, aes(x = curb.weight, y = horsepower, color = body.style)) +
  geom_point()
#oookay, not great. 

ggplot(df, aes(x = bore, y = stroke, color = body.style)) +
  geom_point() +
  facet_wrap(vars(drive.wheels))
#this is workable. interesting story, can talk about lots of aspects


#----------- price/lb
ggplot(df, aes(x = curb.weight, y = price, color = body.style)) +
  geom_point()
#interesting. May want to compare $/lb

df <- mutate(df, price_lb = price/curb.weight)
#price per pound relates to value and economy segments
#not much more useful than just price

ggplot(df, aes(x = price_lb, y = highway.mpg, color = body.style)) +
  geom_point()
#economy cars are get better mpg, wooow. more expensive cars get worse mpg... revolutionary

# --------------- over/under square engines

df <- mutate(df, bs.ratio = bore/stroke)

ggplot(df, aes(x = bs.ratio, y = highway.mpg, color = body.style)) +
  geom_point()
#no real correlation there...

ggplot(df, aes(x = bs.ratio, y = peak.rpm, color = fuel.type)) +
  geom_point()
#colored by aspiration: no real relation w/ ratio & power
#colored by fuel.type: diesel engines look to be slightly undersquare

ggplot(df, aes(x = bs.ratio, y = highway.mpg, color = aspiration)) +
  geom_point()
#turbo engines tend to be lower mpg, but not strongly so.