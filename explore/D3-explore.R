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

#data is tidy at this point ----------------------------

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


#-- facet by country

summary(df$make)

df <- df %>% 
  mutate(country = fct_recode(make,
                              "Britain" = "jaguar",
                              "France" = "peugot",
                              "France" = "renault",
                              "Germany" = "audi",
                              "Germany" = "bmw",
                              "Germany" = "mercedes-benz",
                              "Germany" = "porsche",
                              "Germany" = "volkswagen",
                              "Italy" = "alfa-romero",
                              "Japan" = "honda",
                              "Japan" = "mazda",
                              "Japan" = "mitsubishi",
                              "Japan" = "nissan",
                              "Japan" = "subaru",
                              "Japan" = "toyota",
                              "Korea" = "isuzu",
                              "Sweden" = "saab",
                              "Sweden" = "volvo",
                              "United States" = "chevrolet",
                              "United States" = "dodge",
                              "United States" = "mercury",
                              "United States" = "plymouth"
  )) 

summary(df$country)

glimpse(df)

ggplot(df, aes(x = price, y = highway.mpg, color = country)) +
  geom_point() +
  theme_graphclass() +  
  facet_wrap(vars(body.style), as.table = FALSE)

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
