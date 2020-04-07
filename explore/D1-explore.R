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

college <- select(college_raw, c("Public", "Earn", "ACT")) %>% glimpse()

#create above/below average ACT data
college <- college %>%
  mutate("ACT_Average" = ifelse(college$ACT > mean(college$ACT), "Above Average", "Below Average")) %>%
  glimpse()

#turn Public into a category
college <- college %>%
  mutate("Type" = ifelse(college$Public, "Public School", "Private School")) %>%
  glimpse()

#turn 4 combinations into 4 levels & reorder
college <- college %>% 
  mutate(type_performance = str_c(ACT_Average, Type, sep = " @ ")) %>% 
  mutate(type_performance = fct_reorder(type_performance, Earn))

p <- ggplot(college, aes(x = Earn, y = type_performance, color = Type, fill = Type)) +
  geom_jitter(width = 0, height = 0.2, shape = 21, size = 2, alpha = 0.5) +
  theme_graphclass() +
  labs(x = "Post-Graduation Earnings", y = "")
p

summary(college)
