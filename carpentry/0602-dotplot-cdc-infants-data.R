library("tidyverse")
library("seplyr")
library("cdata")
data(infant_mortality, package = "graphclassmate")
glimpse(infant_mortality)

#omit extreme age groups
df <- infant_mortality %>% 
  filter(!age %in% c("15","45-49"))

# check results
sort(unique(df$age))
#no 15 or 45-49 are seen in data

#recode to two race groups: black and not black
df <- df %>% 
  mutate(race = if_else(race == "Black", 
                        true   = "Black", 
                        false  = "non-Black"))

# check results
sort(unique(df$race))

#recode census regions to names
df <- df %>%  
  mutate(region = recode(region, 
                         "CENS-R1" = "Northeast", 
                         "CENS-R2" = "Midwest",
                         "CENS-R3" = "South",
                         "CENS-R4" = "West"))

# check results
sort(unique(df$region))

grouping_variables <- c("age", "race", "region")
df <- df %>% 
  seplyr::group_summarise(grouping_variables, 
                          deaths = sum(deaths, na.rm = TRUE), 
                          births = sum(births, na.rm = TRUE)) %>% 
  mutate(rate = deaths / births * 1000) %>% 
  filter(complete.cases(.))

glimpse(df)

#order by mean mortality rate
df <- df %>%    
  mutate(region = fct_reorder(region, rate))

saveRDS(df, "data/0602-dotplot-cdc-infants-data.rds")

#find statistics for headline later
#looking for ratio of black to non-black mortality
temp <- df %>% 
  select(age, region, race, rate) %>% 
  cdata::pivot_to_rowrecs(
    data = ., 
    columnToTakeKeysFrom   = "race", 
    columnToTakeValuesFrom = "rate",
    rowKeyColumns          = c("age", "region")
  ) %>% 
  dplyr::rename(non_Black = "non-Black") %>% 
  mutate(ratio = Black/non_Black) %>% 
  arrange(desc(ratio))
#turn to rowrec form so Black and non-black are in separate columns, then divide them to get ratio
temp

#statistical summary
summary(temp$ratio)
#median ratio of Black to non-Black infant deaths per 1000 births from 2007 to 2016 is 2.2:1