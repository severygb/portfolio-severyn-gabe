# Gabe Severyn
# 4/13/2020

# load packages
library("tidyverse")
library("lubridate")
library("seplyr") 

df <- presidential

ggplot(data = df, aes(x = start, xend = end, y = name, yend = name)) +
  geom_segment()

#turn string into a data-time, replace the name at that time
year_index <- df$start == lubridate::date("1989-01-20")
df$name[year_index] <- "Bush_41"

#turn string into a data-time, replace the name at that time
year_index <- df$start == lubridate::date("2001-01-20")
df$name[year_index] <- "Bush_43"

#makes name into a factor
df <- df %>% 
  mutate(name = factor(name))

attributes(df$name)

ggplot(data = df, aes(x = start, xend = end, y = name, yend = name)) +
  geom_segment()

#turns name back into a character string...
df <- df %>% 
  mutate(name = as.character(name))

#hand-make a list of levels ordered in the way you want
name_levels = c("Eisenhower", "Kennedy", "Johnson", "Nixon", "Ford", "Carter", "Reagan", "Bush_41", "Clinton", 
                "Bush_43", "Obama")

#remake the name factor according to the defined levels
df <- df %>% 
  mutate(name = factor(name, levels = name_levels))

ggplot(data = df, aes(x = start, xend = end, y = name, yend = name)) +
  geom_segment()

# convert back to character... for learning purposes
df <- df %>% 
  mutate(name = as.character(name))

#start and stop dates of their administrations as object type Date
class(df$start)

#reorder name by the start data (which is represented by an integer deep down)
df <- df %>% 
  mutate(name = fct_reorder(name, start))

#this is ordered by date, but without having to look up the order of presidents
ggplot(data = df, aes(x = start, xend = end, y = name, yend = name)) +
  geom_segment()

glimpse(gss_cat)

#look at the factor relig
attributes(gss_cat$relig)

#group by religion, to turn data into just these categories
grouping_variables <- c("relig")
relig_tv <- gss_cat %>%
  group_summarize(grouping_variables, tvhours = mean(tvhours, na.rm = TRUE))

ggplot(data = relig_tv, aes(x = tvhours, y = relig)) + 
  geom_point()

# reorder the levels of the factor by number of TV hours
relig_tv <- relig_tv %>%
  mutate(relig = fct_reorder(relig, tvhours))

# graph with reordered factor  
ggplot(data = relig_tv, aes(x = tvhours, y = relig)) + 
  geom_point()

#group by 2 variables
grouping_variables <- c("marital", "relig")
marital_relig_tv <- gss_cat %>%
  group_summarize(grouping_variables, tvhours = mean(tvhours, na.rm = TRUE)) %>% 
  ungroup() 

#we want to remove some categories before operating on marital status
marital_relig_tv <-  marital_relig_tv %>% 
  filter(marital != "No answer") %>% 
  filter(relig   != "No answer") %>% 
  filter(relig   != "Don't know")
#and remove any NAs
sum(is.na(marital_relig_tv$tvhours))
marital_relig_tv <- marital_relig_tv %>%
  mutate(tvhours = replace_na(tvhours, 0)) 

#finally reorder them
marital_relig_tv <- marital_relig_tv %>%
  mutate(marital = fct_reorder(marital, tvhours)) %>% 
  mutate(relig = fct_reorder(relig, tvhours)) 

ggplot(data = marital_relig_tv, aes(x = tvhours, y = relig)) + 
  geom_point() +
  facet_wrap(vars(marital), ncol = 1, as.table = FALSE)

#---reorder factor by frequency of levels
df <- gss_cat %>% 
  count(marital) %>% #count makes a new column of counts, n
  glimpse()

df <- df %>% 
  mutate(marital = fct_reorder(marital, n)) 

ggplot(data = df, aes(x = n, y = marital)) +
  geom_point() 

#create frequency tables of two variables
df <- gss_cat %>% 
  count(marital, relig) %>% 
  glimpse()

df <- df %>% 
  mutate(marital = fct_reorder(marital, n)) %>% 
  mutate(relig   = fct_reorder(relig, n))

df <-  df %>% 
  filter(n > 100)

ggplot(data = df, aes(x = n, y = relig)) + 
  geom_point() +
  facet_wrap(vars(marital), ncol = 1, as.table = FALSE)

#recode factor levels
df <- gss_cat %>% 
  count(partyid)

df

#hand-made new fancy labels for each factor level. new = old
df <- df %>% 
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat"
  ))

#gets rid of some levels by combining them into a sigle new level
df <- df %>% 
  mutate(partyid = fct_recode(partyid,
                              "Independent"           = "Independent, near rep",
                              "Independent"           = "Independent, near dem",
                              "Other"                 = "No answer",
                              "Other"                 = "Don't know",
                              "Other"                 = "Other party"
  )) 

grouping_names <- c("partyid")
df <- df %>% 
  group_summarise(grouping_names, n = sum(n))

#omit other, b/c it is quite small in comparison
df <- df %>% 
  filter(partyid != "Other")

#'Other' is not used, this function removes it from the list of levels
fct_drop(df$partyid)

ggplot(data = df, aes(x = partyid, y = n)) +
  geom_point()

#reverse factor order to plot according to conventions
df <- df %>% 
  mutate(partyid = fct_rev(partyid))

ggplot(data = df, aes(x = partyid, y = n)) +
  geom_point()
