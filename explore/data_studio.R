# Data Basics lab

# Exerciese 4.4.1-3
x <- 12
library(tidyverse)
library(ggplot2)
ggplot(data = mpg)
geom_point(mapping = aes(displ,hwy))
#geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3)


# Exercises 5.1
#Had an arrival delay of two or more hours
(delay <- filter(flights, arr_delay >= 2))
#Flew to Houston (IAH or HOU)
(HOUSTON <- filter(flights, dest == 'HOU' | dest == 'IAH'))
#Were operated by United, American, or Delta
(sort_carrier <- filter(flights, carrier %in% c('AA','DL','UA')))
#Departed in summer (July, August, and September)
(summer <- filter(flights, month %in% c(6,7,8)))
#Arrived more than two hours late, but didn’t leave late
(arrive_delayed <- filter(flights, arr_delay > 120 & dep_delay < 1))
#Were delayed by at least an hour, but made up over 30 minutes in flight
(make_time <- filter(flights, dep_delay >= 60 & (dep_delay - arr_delay > 30)))
#Departed between midnight and 6am (inclusive)
(red_eye = filter(flights,hour <= 6))
#How many flights have a missing dep_time? What other variables are missing? What might these rows represent?
(missing_dep_time = filter(flights, is.na(dep_time)))
#8225 flights. They are missing all other time based columns, which are derived from the departure time
# 4. Those expressions always evaluate to a single known answer.

#Exerciese 5.3
#1. How could you use arrange() to sort all missing values to the start?
(arrange(flights, desc(is.na(dep_time))))
#2. Sort flights to find the most delayed flights. Find the flights that left earliest.
(arrange(flights,desc(dep_delay),dep_time))
#3.  Sort flights to find the fastest (highest speed) flights.
(arrange(flights, distance/air_time))
# 4. Which flights travelled the farthest? Which travelled the shortest?
arrange(flights, distance)
(arrange(flights, desc(distance))) #long
