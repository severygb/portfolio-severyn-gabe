#Gabe Severyn
#week 10 2020
# I'm so close!

library(tidyverse)
library(magrittr)
library(naniar) # for replacing na values
library("GGally")

COW_data <- read.delim(file = "data-raw/COW-data.txt", header = T, sep = ",") %>%
  glimpse()

#About the data set and variables. taken from https://correlatesofwar.org/data-sets/national-material-capabilities/nmc-codebook-v5-1/at_download/file
# Position Variable Description
# 1 “stateabb” 3 letter country Abbreviation
# 2 “ccode” COW Country code
# 3 “year” Year of observation
# 4 “irst” Iron and steel production (thousands of tons)
# 5 “milex” Military Expenditures (For 1816-1913: thousands of current year British Pounds. For 1914+: thousands of current year US Dollars.)
# 6 “milper” Military Personnel (thousands)
# 7 “pec” Energy consumption (thousands of coal-ton equivalents)
# 8 “tpop” Total Population (thousands)
# 9 “upop” Urban population (population living in cities with population greater than 100,000; in thousands)
# 10 “cinc” Composite Index of National Capability (CINC) score
# 11 “version” Version number of the data set


#Missing values are indicated by the value “-9”
COW_data %<>% replace_with_na_all(condition = ~.x == -9)

#check NA values got implemented
cols_w_na <- apply(COW_data, 2, function(x) any(is.na(x)))
colnames(COW_data)[cols_w_na]

#try a scatterplot matrix first
#entire data set has no meaning on it's own, don't use this...
# ggscatmat(COW_data, columns = 4:9) +
#   geom_point()  +
#   theme(legend.position = "right",
#         panel.spacing = unit(1, "mm"),  
#         axis.text.x = element_text(angle = 90, hjust = 1))

#just use most recent data
COW_recent <- COW_data %>%
  filter(year == max(COW_data$year)) %>%
  glimpse()

ggscatmat(COW_recent, columns = 4:9) +
  geom_point()  +
  theme(legend.position = "right",
        panel.spacing = unit(1, "mm"),
        axis.text.x = element_text(angle = 90, hjust = 1))
