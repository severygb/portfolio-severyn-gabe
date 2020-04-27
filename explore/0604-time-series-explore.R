# Gabe Severyn
# 4/21/2020 (as.character here)

# load packages
library("tidyverse")
library("lubridate")
library("tsbox")
library("astsa")

data(economics, package = "ggplot2")
economics

class(economics$date)
#since it's a date, it's easy to graph nicely

ggplot(data = economics, mapping = aes(x = date, y = unemploy)) +
  geom_line()

# dealing with Time-Series class
#objects are numeric data vectors observed at equally-spaced time intervals
#they encode a hidden time value in addition to visible data value. Base R plot() can see this, ggplot cannot

data(LakeHuron)  #example with yearly observations
str(LakeHuron) 
attributes(LakeHuron)
print(LakeHuron)

#tsbox is great for transforming time series to useful forms
df <- ts_df(LakeHuron) %>% 
  glimpse()
#only the year was important, so remove the month and day
df <- df %>% 
  mutate(time = year(time)) %>% 
  glimpse()

df <- df %>% 
  dplyr::rename("lake_year" = "time", "lake_level" = "value") %>% 
  glimpse()

ggplot(data = df, mapping = aes(x = lake_year, y = lake_level)) +
  geom_line()

data(prodn, package = "astsa") #example with monthly observations
class(prodn)

df <- ts_df(prodn) %>% 
  glimpse()
df <- df %>% 
  dplyr::rename("date" = "time", "production_index" = "value") %>% 
  glimpse()
ggplot(data = df, mapping = aes(x = date, y = production_index)) +
  geom_line()


data(lap, package = "astsa") #an example with multiple measurements at each time
class(lap)
summary(lap)

df <- ts_df(lap) %>% 
  glimpse()
#it puts all the measurements into an 'id' column according to their name

df <- df %>% 
  dplyr::rename("date" = "time", "mortality" = "value") %>% 
  glimpse()

#measurements are weekly (freq in ts is 52). change to Date class to remove time from date
df <-  df %>% 
  mutate(date = as_date(date)) %>% 
  glimpse()

df_subset <- df %>% 
  filter(id %in% c("cmort", "rmort", "tmort")) #keep mortality data only
ggplot(data = df_subset, mapping = aes(x = date, y = mortality)) +
  geom_line() +
  facet_wrap(vars(reorder(id, mortality)), as.table = FALSE, ncol = 3)
