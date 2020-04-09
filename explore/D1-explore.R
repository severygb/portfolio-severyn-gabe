library(readr)
library(tidyverse)
library("utils")
library(graphclassmate)

#scrape web data
url <- "https://dasl.datadescription.com/download/data/3249"

#brings it in as a tibble
college_raw  <- read_delim(url,
                   col_names = TRUE,
                   delim = "\t")

glimpse(college_raw)
summary(college_raw)
#head(college_raw)


#quantative variable: $ Earn
#category 1: School Type. Levels: public, private
#category 2: ACT Performance. Levels: above average, below average

college <- select(college_raw, c("Public", "Earn", "ACT","need_fraction")) %>% glimpse()

#eliminate rows with NA's
college <- na.omit(college)

#create above/below average ACT data
college <- college %>%
  mutate("ACT_rank" = ifelse(college$ACT > mean(college$ACT), "High ACT", "Low ACT")) %>%
  glimpse()

#create high/low need data
college <- college %>%
  mutate("need_rank" = ifelse(college$need_fraction > mean(college$need_fraction), "High Need", "Low Need")) %>%
  glimpse()

#turn Public into a category
college <- college %>%
  mutate("school_type" = ifelse(college$Public, "Public School", "Private School")) %>%
  glimpse()

#turn 4 combinations into 4 levels & reorder
college <- college %>% 
  mutate(category = str_c(ACT_rank, need_rank, sep = " & ")) %>% 
  mutate(category = fct_reorder(category, Earn)) #default ranking is median

p <- ggplot(college, aes(x = Earn, y = category, color = school_type, fill = school_type)) +
  geom_jitter(width = 0, height = 0.2, shape = 21, size = 2, alpha = 0.5) +
  theme_graphclass() +
  labs(x = "Annual Earnings Post-Graduation", y = "")
p

summary(college)
