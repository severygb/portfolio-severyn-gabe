# reshape VA deaths data   
# Gabe Severyn
# 4/6/2020

library("tidyverse")
library("cdata")
library("wrapr")
library("seplyr")

data(VADeaths)

class(VADeaths)
print(VADeaths)
#we have row names, which are bad because data frames don't keep them
row.names(VADeaths)

#move row names to a column
VA_deaths <- data.frame(VADeaths) %>%
  rownames_to_column("age_group") %>%
  print()


#data in in row-record form: each row has multiple observations grouped in some way
#tidy data has a separate observation on every row.
#Transform row-record to row blocks to get the death table to be tidy
control_table <- wrapr::build_frame(
  "geo_area",  "sex",     "death_rate"   |
    "Rural",     "Male",    "Rural.Male"   |
    "Rural",     "Female",  "Rural.Female" |
    "Urban",     "Male",    "Urban.Male"   |
    "Urban",     "Female",  "Urban.Female"
)

#called row blocks because groups of rows are blocks made from each row-record
VA_tall <- rowrecs_to_blocks(
  wideTable        = VA_deaths,
  controlTable     = control_table,
  controlTableKeys = c("geo_area", "sex"),
  columnsToCopy    = c("age_group")
)

#the following reverses the transformation
VA_wide <- blocks_to_rowrecs(
  tallTable        = VA_tall,
  controlTable     = control_table,
  controlTableKeys = c("geo_area", "sex"), 
  keyColumns       = c("age_group")
)

