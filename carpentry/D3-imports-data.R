library(tidyverse)
library(graphclassmate)
library(GGally)
library(magrittr) #for the compound assignment pipe

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


#-- add country variable
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
  )) %>%
  mutate(body.style = fct_recode(body.style,
                              "coupe" = "hardtop"
  ))

summary(df$country)
glimpse(df)

#only keep data I care about. price, mpg, country, body.style
df_trimmed <- select(df, price, highway.mpg, country, body.style)

#reorder factors in a useful way
df_trimmed %<>%
  mutate(country = fct_reorder(country, highway.mpg, .desc = T)) %>%
  mutate(body.style = fct_reorder(body.style, highway.mpg))

saveRDS(df_trimmed, file = "data/D3-imports.rds")

df  %>% filter(country == "Germany") %>%
  filter(body.style == "convertible" | body.style == "coupe") %>%
  arrange(desc(price)) %>%
  select(price, make, body.style, highway.mpg) %>%
  head()
