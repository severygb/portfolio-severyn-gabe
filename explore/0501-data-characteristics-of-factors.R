# Gabe Severyn
# date is stored as a double

# load packages
library("tidyverse")
library("lubridate")

x <- c("Dec", "Apr", "Jan", "Mar")

typeof(x)

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

typeof(month_levels)

(x_factor <- factor(x, levels = month_levels))

print(x_factor, max.levels = 0)
cat(unclass(x_factor))

#Useful functions for examining factors include,
#nlevels() yields the number of levels
#levels() yields the full set of levels